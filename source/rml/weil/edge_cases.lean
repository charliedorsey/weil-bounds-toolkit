import rml.weil.contracts

/-! # Boundary checks for the exported estimates -/
namespace RML.ExpSum.Weil

example : ¬ IsUnit (0 : ZMod 7) := by decide
example : reducedModulus 0 7 = 1 := by decide
example : reducedModulus 0 6 = 1 := by decide

#check squarefreeUnitNumerator_bound
#check reducedModulusSum_bound
#check centeredReducedIntervalSum_bound
#check weightedCenteredReducedIntervalSum_bound

end RML.ExpSum.Weil
