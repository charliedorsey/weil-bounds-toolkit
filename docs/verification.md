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
| Lean | `leanprover/lean4:v4.35.0-rc2` (`lean-toolchain`) |
| Mathlib | `v4.35.0-rc2`, commit `065356127b1dc0016f66b7283ce0ce2c4055aa55` (`lake-manifest.json`) |
| Toolkit | `0.1.0` |

The [CI workflow](../.github/workflows/lean.yml) uses pinned action commits and runs the same checks when hosted on GitHub. No GitHub repository is required for local verification.

## Interpretation of results

- `SHA256SUMS` proves consistency with the *included* manifest, not external authorship or archive authenticity. Compare a release archive digest with a trusted publisher record when one exists.
- A successful compilation establishes only the propositions that Lean checks, under the displayed hypotheses and reported foundational axioms.
- The current authoritative proof evidence is the **Palomar full mechanical verification PASS** for immutable source commit `0f3e4c3010bb0e7c4e514ddb5bd3a0a0e082bf68`, [GitHub Actions run 41562922170](https://github.com/PalomarRegistry/PalomarSubmission/actions/runs/41562922170), using the 4.35.0-rc2 toolchain and manifest above. The submitted nine-theorem Challenge/Solution pair passed Palomar's independent-kernel verification. The report is for that exact submitted commit; this later documentation-only commit is not itself a new Palomar-verified snapshot.
- The **19 October 2026** Lean 4.34.0 / Mathlib `5ed2965...` [historical source release certificate](history/release_verification_20261019.json) concerns an earlier source baseline (8,964 jobs, eleven axiom declarations). It is not proof that the currently distributed 4.35.0-rc2 source is byte-identical to that old build. The [current release record](release_verification.json) separates the evidence rather than carrying the historical identity assertion forward.
- Palomar's editorial review of the prior immutable submission identified **no blocking issues**, but did note this stale documentation as a nonblocking warning. Changing docs after that reviewed commit does not revise the signed review or its immutable source record.

For the public theorem surface and limitations, see [theorems.md](theorems.md) and [scope.md](scope.md).
