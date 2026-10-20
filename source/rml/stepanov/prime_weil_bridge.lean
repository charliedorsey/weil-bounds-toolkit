import rml.stepanov.prime_weil
import rml.weil.prime_foundation

/-!
# Prime-bound normalization

Transfers the proved prime estimate to the coefficient convention of Harcos (2015),
equation (1), and Weil’s classical statement.
-/

namespace RML.ExpSum.Stepanov

open RML.ExpSum.Weil

/-- Prime nondegenerate Weil bound proved using the Stepanov–Carlitz route. -/
theorem primeNondegenerateWeil_proved :
    PrimeNondegenerateWeil :=
  (primeNondegenerateWeil_iff_oneParameter).2
    oneParameterPrimeWeil_proved

/-- The classical Weil statement follows from the normalization equivalence. -/
theorem weil1948PrimeKloostermanBound_proved :
    Weil1948PrimeKloostermanBound :=
  (primeNondegenerateWeil_iff_weil1948).1
    primeNondegenerateWeil_proved

#print axioms primeNondegenerateWeil_proved
#print axioms weil1948PrimeKloostermanBound_proved

end RML.ExpSum.Stepanov
