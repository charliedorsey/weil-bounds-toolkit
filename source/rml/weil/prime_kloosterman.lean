import rml.stepanov.prime_weil_bridge

/-!
# The public prime estimate

Exports Weil’s classical bound and the equivalent coefficient ordering used in Harcos
(2015), Theorem 1.
-/

namespace RML.ExpSum.Weil

/-- Fully proved prime nondegenerate Kloosterman-Weil bound, using the Stepanov–Carlitz development. -/
theorem prime_bound : PrimeNondegenerateWeil :=
  RML.ExpSum.Stepanov.primeNondegenerateWeil_proved

/-- Conventional Weil (1948) coefficient order and normalization. -/
theorem weil1948_bound : Weil1948PrimeKloostermanBound :=
  primeNondegenerateWeil_iff_weil1948.mp prime_bound

#print axioms prime_bound
#print axioms weil1948_bound
end RML.ExpSum.Weil
