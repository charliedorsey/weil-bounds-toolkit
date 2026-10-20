import rml.carlitz.recurrence_package

/-!
# Finite spectral aggregates

Defines the finite sums linking spectral power sums and curve-point data. Reference:
Harcos (2015), equation (3).
-/

namespace RML.ExpSum.Stepanov

open scoped BigOperators
open RML.ExpSum.Carlitz

/-- Finite aggregate appearing in the Stepanov point-count argument.
For the specialized curve, this is identified with
`#C_n - p^n` exactly, with no asymptotic notation. -/
noncomputable def errorAggregate
    (p n : ℕ) [Fact p.Prime] (c : ZMod p) : ℂ := by
  classical
  exact -1 +
    ∑ m : {m : ZMod p // m ≠ 0},
      Kseq p (m.1 ^ 2 * c) n


end RML.ExpSum.Stepanov
