module

public import rml

public section

/-!
# Weil Bounds Toolkit: proved solution

This module imports the complete toolkit. Every declaration named in
`comparator.json` is proved in `source/rml/weil/` under exactly the name and
statement given in `Challenge.lean`, and every definition those statements use
is defined there with the identical body. Comparator checks the statements and
definitions against the Challenge and audits the axioms of the proofs.

Proof locations:
* `prime_bound`, `weil1948_bound`: `rml.weil.prime_kloosterman`
  (Carlitz recurrence + Stepanov point count, via `rml.stepanov.*`);
* `kloostermanSumPrime_eq_weilKloostermanPrime`: `rml.weil.prime_foundation`;
* `kloostermanUnitSum_crt`, `reducedModulus_pos`: `rml.weil.crt_and_completion`;
* `squarefreeUnitNumerator_bound`, `reducedModulusSum_bound`,
  `centeredReducedIntervalSum_bound`, `weightedCenteredReducedIntervalSum_bound`:
  `rml.weil.contracts`.
-/
