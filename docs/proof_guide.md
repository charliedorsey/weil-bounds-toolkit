# Proof outline and source guide

The formalization combines Carlitz's extension-field recurrence with Stepanov's point-count argument, following Harcos's exposition. Citation keys refer to [references.md](references.md); the [module map](module_provenance.csv) covers every distributed source module.

## How the proof works

1. **Carlitz recurrence.** Extension-field additive characters and factorization identities lead to a generating-series relation, Newton sums, a quadratic recurrence, and two spectral roots. See [Carlitz1969] for the historical method and [Harcos2015Notes], introduction (2), for the two-root formulation.
2. **Stepanov point counts.** Hasse derivatives and an auxiliary polynomial control the number of points on an Artin–Schreier/hyperelliptic curve. The resulting estimates bound power sums attached to those roots. The main followed reference is [Harcos2015Notes], §§3–5, especially equations (11)–(22); see also [Stepanov1972Hyperelliptic].
3. **Spectral conclusion.** The recurrence and the bounded power sums imply that both roots have absolute value \(\sqrt p\), yielding \(2\sqrt p\) for the prime Kloosterman sum. See [Weil1948Exponential] for the original theorem. Harcos's Theorem 1 covers odd primes; characteristic two is handled separately here.

## Main source correspondences

| Modules or declarations | Mathematical reference | Relation |
| --- | --- | --- |
| `carlitz/extension_defs`, `class_value`, `class_ghost`, `irred_ghost` | [Carlitz1969], (2.8)–(2.13) | Extension sums, characters and trace setup; formal field identifications are local |
| `carlitz/generating_identity`, `formal_algebra`, `newton_sum`, `recurrence_package` | [Carlitz1969]; [Harcos2015Notes], (2) | Generating-series and recurrence method; exact Carlitz signs/normalization still require comparison |
| `carlitz/dickson_finite_algebra`, `newton_index`, `factor_data` | [Carlitz1969]; standard Newton identities | Polynomial and coefficient constructions |
| `stepanov/algebra` | [Harcos2015Notes], §4, (14)–(15), Lemmas 8–10; [Stepanov1972Hyperelliptic] | Multiplicity and Hasse-derivative arguments |
| `stepanov/auxiliary`, `parameters`, `defect` | [Harcos2015Notes], §5, (18)–(22); [Stepanov1972Hyperelliptic] | Auxiliary polynomial, dimension count and error bounds |
| `stepanov/artin_schreier`, `specialized_curve`, `curve_trace` | [Harcos2015Notes], (3), §§3–5 | Trace fibers and curve parametrization |
| `stepanov/curve_count`, `point_count_bridge` | [Harcos2015Notes], (11)–(12), (3) | Curve points and character sums |
| `stepanov/power_sum_spectral`, `spectral_bound`, `carlitz_roots` | [Harcos2015Notes], (2)–(3), §3; [Carlitz1969] | From power sums to spectral-root bounds |
| `stepanov/prime_weil`, `prime_weil_bridge` | [Weil1948Exponential]; [Harcos2015Notes], Theorem 1 | Main bound and the separate \(p=2\) case |
| `weil/prime_foundation`, `prime_kloosterman` | [Harcos2015Notes], (1); [Weil1948Exponential] | Coefficient order and prime-sum normalization |
| `weil/crt_and_completion` | Standard CRT, Fourier orthogonality and partial summation; [IwaniecKowalski2004], Ch. 12 §12.2 | Specific CRT coefficients and exact completion estimates are proved here |
| `weil/contracts`, `axioms`, `edge_cases`; `rml` root | Library interfaces and checks | No independent historical theorem attached |

## The CRT and completion module

The file `source/rml/weil/crt_and_completion.lean` combines four consecutive developments:

- **CRT:** `crtLeftCoeff`, `crtRightCoeff`, `crt_bezout` and the exact Kloosterman factorization.
- **Reduction:** `reducedModulus`, `reducedNumerator` and the estimate for the *reduced* sum; no lift to the original modulus.
- **Finite Fourier completion:** centered reciprocal sums, Fourier coefficients and sharp-interval bounds.
- **Weighted completion:** `reciprocalNatWeight` and partial summation for the weighted interval bound.

The squarefree-modulus estimate retains a **unit numerator** condition. The completion results use the hypotheses in their Lean declarations; they are not asserted for arbitrary composite moduli.

The main unresolved bibliographic comparison is the precise sign and trace normalization of the toolkit's Carlitz generating-series identity relative to the 1969 paper. This is stated as a *methodological correspondence*, not an equation-level identification. Further notes appear in [provenance_review.md](provenance_review.md).
