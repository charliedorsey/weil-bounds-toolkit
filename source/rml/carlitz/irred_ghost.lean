import rml.carlitz.relevant_irred

/-!
# Irreducible-class ghost sums

Expresses the extension sum using irreducible polynomial classes, in the Carlitz
(1969) recurrence framework.
-/

namespace RML.ExpSum.Carlitz

open Polynomial

noncomputable def irredGhost
    (p n : ℕ) [Fact p.Prime] [NeZero n] (t : Fp p) : ℂ := by
  classical
  letI : Finite (ConjRootClass (Fp p) (Ext p n)) := by
    unfold ConjRootClass
    infer_instance
  letI := Fintype.ofFinite (ConjRootClass (Fp p) (Ext p n))
  letI : Fintype (RelevantIrred p n) :=
    Fintype.ofEquiv
      (ConjRootClass (Fp p) (Ext p n))
      (classRelevantEquiv p n)
  exact ∑ P : RelevantIrred p n,
    (P.1.natDegree : ℂ) *
      RML.ExpSum.Dickson.etaPoly p t P.1 ^
        (n / P.1.natDegree)

lemma minpoly_zero_class_eq_X
    (p n : ℕ) [Fact p.Prime] [NeZero n] :
    (0 : ConjRootClass (Fp p) (Ext p n)).minpoly =
      (X : Polynomial (Fp p)) := by
  change minpoly (Fp p) (0 : Ext p n) = X
  simpa using
    (minpoly.eq_X_sub_C (Ext p n) (0 : Fp p))

theorem classGhost_eq_irredGhost
    (p n : ℕ) [Fact p.Prime] [NeZero n] (t : Fp p) :
    classGhost p n t = irredGhost p n t := by
  classical
  letI : Finite (ConjRootClass (Fp p) (Ext p n)) := by
    unfold ConjRootClass
    infer_instance
  letI := Fintype.ofFinite (ConjRootClass (Fp p) (Ext p n))
  let e := classRelevantEquiv p n
  letI : Fintype (RelevantIrred p n) :=
    Fintype.ofEquiv
      (ConjRootClass (Fp p) (Ext p n)) e
  unfold classGhost irredGhost
  refine Fintype.sum_equiv e
    (fun c : ConjRootClass (Fp p) (Ext p n) =>
      if c = 0 then (0 : ℂ)
      else (c.minpoly.natDegree : ℂ) *
        RML.ExpSum.Dickson.etaPoly p t c.minpoly ^
          (n / c.minpoly.natDegree))
    (fun P : RelevantIrred p n =>
      (P.1.natDegree : ℂ) *
        RML.ExpSum.Dickson.etaPoly p t P.1 ^
          (n / P.1.natDegree)) ?_
  intro c
  change
    (if c = 0 then (0 : ℂ)
      else (c.minpoly.natDegree : ℂ) *
        RML.ExpSum.Dickson.etaPoly p t c.minpoly ^
          (n / c.minpoly.natDegree)) =
      (c.minpoly.natDegree : ℂ) *
        RML.ExpSum.Dickson.etaPoly p t c.minpoly ^
          (n / c.minpoly.natDegree)
  by_cases hc : c = 0
  · subst c
    rw [if_pos rfl, minpoly_zero_class_eq_X p n]
    simp [RML.ExpSum.Dickson.etaPoly]
    rw [zero_pow (NeZero.ne n)]
  · rw [if_neg hc]

theorem Kext_eq_irredGhost
    (p n : ℕ) [Fact p.Prime] [NeZero n] (t : Fp p) :
    Kext p n t = irredGhost p n t := by
  rw [Kext_eq_classGhost, classGhost_eq_irredGhost]

#print axioms classGhost_eq_irredGhost
#print axioms Kext_eq_irredGhost

end RML.ExpSum.Carlitz
