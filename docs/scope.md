# Scope and limitations

## Included

- The nondegenerate prime Kloosterman–Weil bound for two nonzero coefficients in `ZMod p`, including a separate proof of the \(p=2\) case.
- Prime-sum normalization, symmetry, scaling and zero-coefficient identities.
- Exact CRT factorization for coprime moduli, with Bézout-normalized coefficients.
- A squarefree-modulus estimate when the first coefficient is a **unit**.
- A bound for the explicitly defined sum at modulus \(q/\gcd(A,q)\), with reduced numerator \(A/\gcd(A,q)\).
- Centered completion for sharp intervals, with a reciprocal-weight version for positive initial weight \(Y\). Specifically, the summand is `centeredReciprocalPhase N a x = reciprocalPhase N a x - (1/N) * Σ_y reciprocalPhase N a y`, whose complete sum is zero. Arbitrary interval lengths apply only to that **centered** phase.

## Not included

- A general gcd-sensitive composite Weil bound for arbitrary numerators. The squarefree estimate requires `IsUnit a`.
- An identity relating the original modulus-\(q\) sum to the reduced-modulus sum. In particular, the reduced-modulus theorem does not provide such a lift; when \(A=0\), its modulus is \(1\).
- Composite estimates without the hypotheses stated in Lean, or an arbitrary-modulus extension of the squarefree result.
- A nondegenerate prime estimate with either coefficient zero. Elementary degenerate cases are handled by separate identities.
- A general analytic distribution theorem or a theorem about arbitrary shifted sums.
- An arbitrary-length bound for the uncentered reciprocal phase with its accumulating mean term omitted.

## Hypotheses and axioms

The reusable CRT/completion lemmas accept `hWeil : PrimeNondegenerateWeil`; the library supplies this proof as `prime_bound` and exports the four unconditional consequences listed in [theorems.md](theorems.md).

A Lean build verifies the formal statements with their actual hypotheses. Consult the declarations before applying a bound to a different modulus or coefficient regime. The library formalizes classical mathematics and makes no claim of mathematical novelty.
