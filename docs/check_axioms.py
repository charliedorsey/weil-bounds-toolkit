#!/usr/bin/env python3
"""Run exact-source Lean axiom audit and reject unapproved axioms."""
import re
import subprocess
import sys
from pathlib import Path
root=Path(__file__).resolve().parent.parent
names=[
 'prime_bound','weil1948_bound','kloostermanUnitSum_crt',
 'kloostermanUnitSum_squarefree_unit_le','kloostermanUnitSum_reduced_le',
 'centeredReducedIntervalSum_le','weightedCenteredReducedIntervalSum_le',
 'squarefreeUnitNumerator_bound','reducedModulusSum_bound',
 'centeredReducedIntervalSum_bound','weightedCenteredReducedIntervalSum_bound',
]
r=subprocess.run(['lake','env','lean','source/rml/weil/axioms.lean'],cwd=root,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,encoding='utf-8',errors='replace',timeout=600)
print(r.stdout,end='')
if r.returncode!=0:sys.exit('FAIL: Lean axiom audit did not run successfully')
allowed={'propext','Classical.choice','Quot.sound'}
for name in names:
    # Output can include Lean file/line prefixes. Match the exact theorem name.
    pattern=r"'RML\.ExpSum\.Weil\."+re.escape(name)+r"' depends on axioms: \[([^\]]*)\]"
    matches=re.findall(pattern,r.stdout)
    if len(matches)!=1:
        sys.exit('FAIL: expected exactly one axiom listing for '+name)
    actual={a.strip() for a in matches[0].split(',') if a.strip()}
    if not actual.issubset(allowed):sys.exit('FAIL: unapproved axiom for '+name+': '+str(actual-allowed))
print('PASS: all eleven audited declarations depend on the ordinary Lean foundations only')
