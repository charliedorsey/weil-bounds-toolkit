module

public import Mathlib

@[expose] public section

/-!
# Weil Bounds Toolkit: advertised statements

This is the trusted statement surface for Palomar. It imports only Mathlib.

Every definition body and theorem statement below is copied verbatim from the
toolkit source (`source/rml/weil/*.lean`); only docstrings were added and proofs
replaced by `sorry`. Comparator requires each definition reached from a compared
statement to be identical in `Solution.lean`, which imports the full toolkit.

Scope (see `docs/scope.md`): the prime bound needs **both** coefficients nonzero;
the squarefree bound needs a **unit first coefficient**; the reduced-modulus
results concern sums *defined at* `q / gcd(A, q)`; the incomplete-sum bounds are
for the **centered** reciprocal phase.
-/

namespace RML.ExpSum.Weil


/-! ## Prime-modulus Kloosterman sums -/

/-- Source-normalized prime Kloosterman sum: `K_p(a,b) = ∑_{x ≠ 0} e_p(b·x + a·x⁻¹)`, with `e_p = ZMod.stdAddChar`. Note the coefficient order (`b` multiplies `x`). -/
noncomputable def kloostermanSumPrime (p : ℕ) [Fact p.Prime]
    (a b : ZMod p) : ℂ :=
  ∑ x : ZMod p, if x = 0 then 0 else ZMod.stdAddChar (b * x + a * x⁻¹)

/-- Classical prime Kloosterman sum in conventional order: `S_p(m,n) = ∑_{x ≠ 0} e_p(m·x + n·x⁻¹)`. -/
noncomputable def weilKloostermanPrime
    (p : ℕ) [Fact p.Prime] (m n : ZMod p) : ℂ :=
  ∑ x : ZMod p,
    if x = 0 then 0 else ZMod.stdAddChar (m * x + n * x⁻¹)

/-- Convention bridge: `K_p(a,b) = S_p(b,a)`. -/
theorem kloostermanSumPrime_eq_weilKloostermanPrime
    (p : ℕ) [Fact p.Prime] (a b : ZMod p) :
    kloostermanSumPrime p a b = weilKloostermanPrime p b a := by
  sorry

/-- The nondegenerate prime bound in source order: for every prime `p` and nonzero `a b : ZMod p`, `‖K_p(a,b)‖ ≤ 2√p`. -/
def PrimeNondegenerateWeil : Prop :=
  ∀ (p : ℕ) [Fact p.Prime] (a b : ZMod p),
    a ≠ 0 → b ≠ 0 →
      ‖kloostermanSumPrime p a b‖ ≤ 2 * Real.sqrt p

/-- Weil's bound (1948) in conventional order: for every prime `p` and nonzero `m n : ZMod p`, `‖S_p(m,n)‖ ≤ 2√p`. -/
def Weil1948PrimeKloostermanBound : Prop :=
  ∀ (p : ℕ) [Fact p.Prime] (m n : ZMod p),
    m ≠ 0 → n ≠ 0 →
      ‖weilKloostermanPrime p m n‖ ≤ 2 * Real.sqrt p

/-- **Main theorem (source order).** The nondegenerate prime Kloosterman–Weil bound, proved by the Carlitz–Stepanov method. -/
theorem prime_bound : PrimeNondegenerateWeil := by
  sorry

/-- **Main theorem (conventional order).** Weil's bound `‖S_p(m,n)‖ ≤ 2√p` for nonzero `m, n`. -/
theorem weil1948_bound : Weil1948PrimeKloostermanBound := by
  sorry


/-! ## Chinese-remainder factorization -/

/-- Bézout coefficient for the left factor (Mathlib's `Nat.gcdA`, argument order `n.gcdA m`). -/
def crtLeftCoeff (m n : ℕ) : ℤ := n.gcdA m

/-- Bézout coefficient for the right factor (Mathlib's `Nat.gcdB`, argument order `n.gcdB m`). -/
def crtRightCoeff (m n : ℕ) : ℤ := n.gcdB m

/-- Kloosterman sum over the unit group of `ZMod N`: `∑_{x ∈ (ZMod N)ˣ} e_N(b·x + a·x⁻¹)`. -/
noncomputable def kloostermanUnitSum
    (N : ℕ) [NeZero N] (a b : ZMod N) : ℂ :=
  ∑ x : (ZMod N)ˣ,
    ZMod.stdAddChar
      (b * (x : ZMod N) + a * ((x⁻¹ : (ZMod N)ˣ) : ZMod N))

/-- Exact CRT factorization of the unit Kloosterman sum for coprime moduli, with Bézout-normalized coefficients. -/
theorem kloostermanUnitSum_crt
    {m n : ℕ} [NeZero m] [NeZero n] [NeZero (m * n)]
    (hcop : m.Coprime n) (a b : ZMod (m * n)) :
    kloostermanUnitSum (m * n) a b =
      kloostermanUnitSum m
          (((crtLeftCoeff m n : ℤ) : ZMod m) *
            (ZMod.chineseRemainder hcop a).1)
          (((crtLeftCoeff m n : ℤ) : ZMod m) *
            (ZMod.chineseRemainder hcop b).1) *
        kloostermanUnitSum n
          (((crtRightCoeff m n : ℤ) : ZMod n) *
            (ZMod.chineseRemainder hcop a).2)
          (((crtRightCoeff m n : ℤ) : ZMod n) *
            (ZMod.chineseRemainder hcop b).2) := by
  sorry


/-! ## Squarefree moduli and reduced moduli -/

/-- Squarefree modulus, **unit first coefficient**: `‖K_q(a,b)‖ ≤ 2^{ω(q)} √q`. This is not a general gcd-sensitive composite bound. -/
theorem squarefreeUnitNumerator_bound
    {q : ℕ} [NeZero q] (hsq : Squarefree q)
    (a b : ZMod q) (ha : IsUnit a) :
    ‖kloostermanUnitSum q a b‖ ≤
      (2 : ℝ) ^ q.primeFactors.card * Real.sqrt q := by
  sorry

/-- `gcd(A, q)`. -/
def reducedDivisor (A q : ℕ) : ℕ := Nat.gcd A q

/-- The reduced modulus `q / gcd(A, q)`. -/
def reducedModulus (A q : ℕ) : ℕ := q / reducedDivisor A q

/-- The reduced numerator `A / gcd(A, q)`. -/
def reducedNumerator (A q : ℕ) : ℕ := A / reducedDivisor A q

/-- Positivity of the reduced modulus (used to supply the `NeZero` instance in the statements below). -/
lemma reducedModulus_pos
    {A q : ℕ} (hq : 0 < q) :
    0 < reducedModulus A q := by
  sorry

/-- Bound for the sum **defined at the reduced modulus** `q / gcd(A,q)` with reduced numerator. No identification with an original-modulus sum is claimed. -/
theorem reducedModulusSum_bound
    {A q : ℕ} (hq : 0 < q) (hsq : Squarefree q)
    (b : ZMod (reducedModulus A q)) :
    letI : NeZero (reducedModulus A q) :=
      ⟨Nat.ne_of_gt (reducedModulus_pos hq)⟩
    ‖kloostermanUnitSum (reducedModulus A q)
       (reducedNumerator A q : ZMod (reducedModulus A q)) b‖ ≤
       (2 : ℝ) ^ (reducedModulus A q).primeFactors.card *
       Real.sqrt (reducedModulus A q) := by
  sorry


/-! ## Centered incomplete sums -/

/-- Reciprocal phase: `e_N(a·x⁻¹)` if `x` is a unit, else `0`. -/
noncomputable def reciprocalPhase
    (N : ℕ) [NeZero N] (a x : ZMod N) : ℂ :=
  if IsUnit x then ZMod.stdAddChar (a * x⁻¹) else 0

/-- Mean of the reciprocal phase over `ZMod N`. -/
noncomputable def reciprocalMean
    (N : ℕ) [NeZero N] (a : ZMod N) : ℂ :=
  (N : ℂ)⁻¹ * ∑ x : ZMod N, reciprocalPhase N a x

/-- Centered reciprocal phase (mean subtracted); its complete sum is zero. -/
noncomputable def centeredReciprocalPhase
    (N : ℕ) [NeZero N] (a x : ZMod N) : ℂ :=
  reciprocalPhase N a x - reciprocalMean N a

/-- Sum of the **centered** reciprocal phase over `L` consecutive residues starting at `x`. -/
noncomputable def centeredIntervalSum
    (N : ℕ) [NeZero N] (a x : ZMod N) (L : ℕ) : ℂ :=
  ∑ j ∈ Finset.range L,
    centeredReciprocalPhase N a (x + (j : ZMod N))

/-- Interval-length-uniform bound for the centered incomplete sum at the reduced squarefree modulus. -/
theorem centeredReducedIntervalSum_bound
    {A q : ℕ} (hq : 0 < q) (hsq : Squarefree q)
    (x : ZMod (reducedModulus A q)) (L : ℕ) :
    letI : NeZero (reducedModulus A q) :=
      ⟨Nat.ne_of_gt (reducedModulus_pos hq)⟩
    ‖centeredIntervalSum
        (reducedModulus A q)
        (reducedNumerator A q : ZMod (reducedModulus A q))
        x L‖ ≤
      ((2 : ℝ) ^ (reducedModulus A q).primeFactors.card *
          Real.sqrt (reducedModulus A q)) *
        (1 + Real.log (reducedModulus A q)) := by
  sorry

/-- Reciprocal weight `1/(Y + i)` as a complex number. -/
noncomputable def reciprocalNatWeight (Y i : ℕ) : ℂ :=
  ((((Y + i : ℕ) : ℝ)⁻¹ : ℝ) : ℂ)

/-- Centered incomplete sum weighted by `1/(Y + j)`. -/
noncomputable def weightedCenteredIntervalSum
    (N : ℕ) [NeZero N] (a x : ZMod N) (Y L : ℕ) : ℂ :=
  ∑ j ∈ Finset.range L,
    centeredReciprocalPhase N a (x + (j : ZMod N)) *
      reciprocalNatWeight Y j

/-- Weighted centered bound for positive initial weight `Y`. -/
theorem weightedCenteredReducedIntervalSum_bound
    {A q : ℕ} (hq : 0 < q) (hsq : Squarefree q)
    (x : ZMod (reducedModulus A q))
    (Y L : ℕ) (hY : 0 < Y) :
    letI : NeZero (reducedModulus A q) :=
      ⟨Nat.ne_of_gt (reducedModulus_pos hq)⟩
    ‖weightedCenteredIntervalSum
        (reducedModulus A q)
        (reducedNumerator A q : ZMod (reducedModulus A q))
        x Y L‖ ≤
      2 *
        (((2 : ℝ) ^ (reducedModulus A q).primeFactors.card *
            Real.sqrt (reducedModulus A q)) *
          (1 + Real.log (reducedModulus A q))) / Y := by
  sorry

end RML.ExpSum.Weil
