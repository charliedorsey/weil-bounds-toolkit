import rml

/-!
# Weil Bounds Toolkit: compiled consumers

Only the public umbrella import is used. These applications make the
coefficient conventions, squarefree-unit condition, and centered phase explicit.
Compile from the repository root with `lake env lean examples/Use.lean`.
-/

namespace WeilBoundsExamples
open RML.ExpSum.Weil

/-- The conventional coefficient order is the exported Weil (1948) theorem. -/
example (p : ℕ) [Fact p.Prime] (m n : ZMod p)
    (hm : m ≠ 0) (hn : n ≠ 0) :
    ‖weilKloostermanPrime p m n‖ ≤ 2 * Real.sqrt p := by
  exact weil1948_bound p m n hm hn

/-- The squarefree bound requires the first coefficient to be a unit. -/
example {q : ℕ} [NeZero q] (hsq : Squarefree q)
    (a b : ZMod q) (ha : IsUnit a) :
    ‖kloostermanUnitSum q a b‖ ≤
      (2 : ℝ) ^ q.primeFactors.card * Real.sqrt q := by
  exact squarefreeUnitNumerator_bound hsq a b ha

/-- Completion controls the *centered* phase at the reduced modulus. -/
example {A q : ℕ} (hq : 0 < q) (hsq : Squarefree q)
    (x : ZMod (reducedModulus A q)) (L : ℕ) :
    letI : NeZero (reducedModulus A q) :=
      ⟨Nat.ne_of_gt (reducedModulus_pos hq)⟩
    ‖centeredIntervalSum
        (reducedModulus A q)
        (reducedNumerator A q : ZMod (reducedModulus A q)) x L‖ ≤
      ((2 : ℝ) ^ (reducedModulus A q).primeFactors.card *
        Real.sqrt (reducedModulus A q)) *
      (1 + Real.log (reducedModulus A q)) := by
  exact centeredReducedIntervalSum_bound hq hsq x L

end WeilBoundsExamples
