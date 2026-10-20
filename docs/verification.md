# Reproducible verification

The distribution contains Lean source, a pinned toolchain and dependency manifest, and a SHA-256 inventory of the shipped files. From its root directory:

```sh
python3 docs/verify.py
lake exe cache get
lake build
lake env lean examples/Use.lean
python3 docs/check_axioms.py
```

1. **Integrity and layout:** `verify.py` checks hashes, the exact file set, the expected source modules, local imports and basic proof-source hygiene. It uses the Python 3 standard library.
2. **Dependencies:** `lake exe cache get` retrieves precompiled artifacts for the pinned Mathlib version. It is an optimization, not a premise of the proof.
3. **Proofs:** `lake build` compiles all `rml.*` modules, including boundary examples, contracts and the axiom audit. The library's Lake target explicitly includes those modules.
4. **Consumer examples:** `lake env lean examples/Use.lean` checks applications against the public interface with all assumptions visible.
5. **Axioms:** `check_axioms.py` inspects eleven selected theorem declarations and rejects dependencies beyond `propext`, `Classical.choice` and `Quot.sound`.

The development contains no distributed `sorry`, `admit`, explicit `axiom`, `unsafe`, or `native_decide` declarations. The text scan in `verify.py` is a useful preflight; it does not replace compilation and axiom inspection.

## Pinned versions

| Component | Version or identifier |
| --- | --- |
| Lean | `leanprover/lean4:v4.34.0` |
| Mathlib | `v4.34.0`, commit `5ed2965256430c3649e86755f9576b54eca72435` in `lake-manifest.json` |
| Toolkit | `0.1.0` |

The [CI workflow](../.github/workflows/lean.yml) uses pinned action commits and runs the same checks when hosted on GitHub. No GitHub repository is required for local verification.

## Interpretation of results

- `SHA256SUMS` proves consistency with the *included* manifest, not external authorship or archive authenticity. Compare a release archive digest with a trusted publisher record when one exists.
- A successful compilation establishes only the propositions that Lean checks, under the displayed hypotheses and reported foundational axioms.
- The [release evidence record](release_verification.json) distinguishes an independently compiled, byte-identical Lean source baseline from this final documentation-only repackaging. Its public API audit covers eleven selected declarations, not an exhaustive survey. The final archive passed package integrity checks; a fresh exact-archive Lean build was not run in this packaging environment. GitHub Actions is configured to repeat all steps once the repository is pushed.

For the public theorem surface and limitations, see [theorems.md](theorems.md) and [scope.md](scope.md).
