# Theorem reference

Import `rml`. All public declarations listed here are in `RML.ExpSum.Weil`.

## Prime bound and exact factorization

| Declaration | Result | Hypotheses |
| --- | --- | --- |
| `prime_bound` | \(\lVert K_p(a,b)\rVert\le 2\sqrt p\), where \(K_p(a,b)=\sum_{x\ne0}e_p(bx+ax^{-1})\) | `p` prime; `a ≠ 0`, `b ≠ 0` |
| `weil1948_bound` | \(\lVert S_p(m,n)\rVert\le 2\sqrt p\), where \(S_p(m,n)=\sum_{x\ne0}e_p(mx+nx^{-1})\) | `p` prime; `m ≠ 0`, `n ≠ 0` |
| `kloostermanUnitSum_crt` | Exact CRT decomposition with Bézout-normalized coefficients | Coprime, nonzero moduli |

The exact normalization bridge is `kloostermanSumPrime_eq_weilKloostermanPrime`: \(K_p(a,b)=S_p(b,a)\). No unrecorded coefficient swap is used.

## Composite and incomplete-sum bounds

| Declaration | Result | Essential condition |
| --- | --- | --- |
| `squarefreeUnitNumerator_bound` | Squarefree estimate with factor \(2^{\omega(q)}\sqrt q\) | `Squarefree q`; `IsUnit a` |
| `reducedModulusSum_bound` | Bound for a sum *defined at the reduced modulus* | `0 < q`; `Squarefree q` |
| `centeredReducedIntervalSum_bound` | Centered completion on a sharp interval of arbitrary length | Same modulus conditions |
| `weightedCenteredReducedIntervalSum_bound` | Weighted centered completion | Same modulus conditions; `0 < Y` |

The final two results are for the **mean-centered** reciprocal phase on the reduced modulus; their length-independent estimates do not apply unchanged to uncentered sums. These four declarations use the proved `prime_bound` internally. Their more general counterparts — `kloostermanUnitSum_squarefree_unit_le`, `kloostermanUnitSum_reduced_le`, `centeredReducedIntervalSum_le` and `weightedCenteredReducedIntervalSum_le` — accept an explicit `hWeil : PrimeNondegenerateWeil` hypothesis. This is a theorem parameter, not a new axiom.

To inspect the elaborated propositions:

```lean
import rml
#check RML.ExpSum.Weil.prime_bound
#check RML.ExpSum.Weil.squarefreeUnitNumerator_bound
#check RML.ExpSum.Weil.reducedModulusSum_bound
#check RML.ExpSum.Weil.centeredReducedIntervalSum_bound
#check RML.ExpSum.Weil.weightedCenteredReducedIntervalSum_bound
```

See [scope.md](scope.md) for limits and [proof_guide.md](proof_guide.md) for references.
