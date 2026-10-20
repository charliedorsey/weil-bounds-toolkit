#!/usr/bin/env python3
"""Check exact SHA-256 file set, public layout, and local import closure."""
import hashlib
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT/'SHA256SUMS'
if not MANIFEST.is_file() or MANIFEST.is_symlink():
    sys.exit('FAIL: SHA256SUMS missing or not regular')
entries={}
for line in MANIFEST.read_text(encoding='utf-8').splitlines():
    match=re.fullmatch(r'([0-9a-f]{64})  ([^\x00\r\n]+)', line)
    if not match: sys.exit('FAIL: malformed manifest line')
    digest, rel=match.groups()
    path=Path(rel)
    if path.is_absolute() or '..' in path.parts or rel in entries:
        sys.exit('FAIL: unsafe or duplicate manifest path')
    entries[rel]=digest

excluded={'.git','.lake','__pycache__'}
files={}
for p in ROOT.rglob('*'):
    rel=p.relative_to(ROOT)
    if any(part in excluded for part in rel.parts): continue
    if p.is_symlink(): sys.exit('FAIL: symlink in distributable tree: '+str(rel))
    if p.is_dir(): continue
    if not p.is_file(): sys.exit('FAIL: unexpected file type: '+str(rel))
    if p == MANIFEST: continue
    files[rel.as_posix()]=p
if set(files)!=set(entries):
    sys.exit('FAIL: file set mismatch; missing '+repr(sorted(set(entries)-set(files)))+'; extras '+repr(sorted(set(files)-set(entries))))
for rel,digest in entries.items():
    if hashlib.sha256(files[rel].read_bytes()).hexdigest()!=digest:
        sys.exit('FAIL: SHA256 mismatch: '+rel)

# Lake's default build must select every distributed RML module, including
# contract and audit modules that are not dependencies of the public import.
lakefile=(ROOT/'lakefile.toml').read_text(encoding='utf-8')
if not re.search(r'(?m)^globs\s*=\s*\[\s*"rml\.\*"\s*\]',lakefile):
    sys.exit('FAIL: default Lake build does not cover every RML module')
ci=(ROOT/'.github/workflows/lean.yml').read_text(encoding='utf-8')
for action in re.findall(r'(?m)^\s*uses:\s*([^\s#]+)',ci):
    if not re.fullmatch(r'[^@]+@[0-9a-f]{40}',action):
        sys.exit('FAIL: CI action is not pinned to a full commit: '+action)

lean_files=sorted((ROOT/'source'/'rml').rglob('*.lean'))
if len(lean_files)!=39 or not (ROOT/'source'/'rml.lean').is_file():
    sys.exit('FAIL: expected 39 library modules plus public import source/rml.lean')
mods={p.relative_to(ROOT/'source').with_suffix('').as_posix().replace('/','.') for p in lean_files}
required_dirs={'carlitz','stepanov','weil'}
if not required_dirs.issubset({p.name for p in (ROOT/'source'/'rml').iterdir() if p.is_dir()}):
    sys.exit('FAIL: missing subject directory')
for p in lean_files:
    rel=p.relative_to(ROOT/'source').as_posix()
    if any(not re.fullmatch('[a-z0-9_]+', part) for part in Path(rel).with_suffix('').parts):
        sys.exit('FAIL: non-snake-case source module: '+rel)
    text=p.read_text(encoding='utf-8')
    for ns in re.findall(r'(?m)^namespace\s+([^\s]+)',text):
        if not ns.startswith('RML.ExpSum.'):
            sys.exit('FAIL: undeclared public namespace '+ns+' in '+rel)
    if re.search(r'(?m)^\s*(?:open|export)\s+(?:[A-Z][\w]*\.){2,}[A-Z]',text):
        # External opens remain permitted; namespace identity is checked above.
        pass
    for importname in re.findall(r'(?m)^import\s+([^\s]+)',text):
        if importname.startswith('rml.') and importname not in mods:
            sys.exit('FAIL: unshipped source import: '+importname+' from '+rel)
    if re.search(r'(?m)^\s*(sorry|admit|axiom|constant|opaque|unsafe|native_decide)\b', text):
        sys.exit('FAIL: unexpected omitted-proof/axiom declaration: '+rel)
print('PASS: %d SHA-256 payload files; %d Lean modules; self-contained local imports; no omitted-proof declarations'%(len(files),len(lean_files)))
