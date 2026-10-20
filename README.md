# Weil Bounds Toolkit

**Version:** v0.1.0  
**Source repository:** [https://github.com/charliedorsey/weil-bounds-toolkit](https://github.com/charliedorsey/weil-bounds-toolkit)

A Lean 4 formalization of the classical prime-modulus Kloosterman–Weil bound, together with exact Chinese-remainder identities and several explicitly scoped composite-modulus and incomplete-sum estimates.

## Main theorem

For a prime \(p\) and nonzero \(a,b\in\mathbf F_p\), the library proves

\[
\left|\sum_{x\in\mathbf F_p^\times}e_p(ax+bx^{-1})\right|\le 2\sqrt p.
\]

The proof follows the exposition of [Harcos (2015)](https://users.renyi.hu/~gharcos/weil.pdf). Its two main ingredients are:

1. **Carlitz's extension-field construction:** generating identities give a quadratic recurrence and two spectral roots.
2. **Stepanov's method:** auxiliary polynomials and curve-point estimates bound the associated power sums.

Combining the two arguments places both spectral roots on the circle of radius \(\sqrt p\). The case \(p=2\), outside Harcos's stated theorem, is handled separately.

### Coefficient conventions

The displayed formula is in the conventional order \(S_p(m,n)=\sum_{x\ne0}e_p(mx+nx^{-1})\). The internal source-normalized definition is \(K_p(a,b)=\sum_{x\ne0}e_p(bx+ax^{-1})\). In particular,

\[
K_p(a,b)=S_p(b,a).
\]

This equality is the exact Lean theorem `kloostermanSumPrime_eq_weilKloostermanPrime`. The public `weil1948_bound` is stated in conventional coefficient order; `prime_bound` is stated in source-normalized order. The bounds require **both** coefficients to be nonzero. Zero-coefficient cases are handled separately by elementary identities.

### Precise scope of the extensions

The squarefree composite estimate requires a nonzero squarefree modulus and a **unit first coefficient**; it is not a general gcd-sensitive composite bound. The reduced-modulus theorem bounds a sum *defined at* \(q/\gcd(A,q)\); it does not identify that sum with an original-modulus sum.

For incomplete sums, the library uses the **centered reciprocal phase**

\[
 f_{N,a}(x)-\frac1N\sum_{y\bmod N}f_{N,a}(y),
\qquad f_{N,a}(x)=\begin{cases}e_N(ax^{-1})&x\text{ is a unit},\\0&\text{otherwise}.\end{cases}
\]

Its complete sum is exactly zero, eliminating the zero Fourier mode. The interval-length-uniform and weighted bounds concern **this centered phase** at the reduced modulus; they are not unrestricted uncentered incomplete-sum bounds. See [theorem contracts](docs/theorems.md) and [scope](docs/scope.md).

## Build and verify

The project pins Lean 4.34.0 and Mathlib in `lean-toolchain` and `lake-manifest.json`.

```sh
python3 docs/verify.py
lake exe cache get
lake build
lake env lean examples/Use.lean
python3 docs/check_axioms.py
```

The first command checks file hashes and source layout. The cache step downloads precompiled Mathlib artifacts. `lake build` checks all distributed `rml` modules, while the next command checks the [worked Lean consumers](examples/Use.lean). The last command audits the axioms of eleven selected declarations. The same sequence is configured in [GitHub Actions](.github/workflows/lean.yml).

## Use in Lean

```lean
import rml

#check RML.ExpSum.Weil.prime_bound
#check RML.ExpSum.Weil.weil1948_bound
#check RML.ExpSum.Weil.kloostermanUnitSum_crt
#check RML.ExpSum.Weil.squarefreeUnitNumerator_bound
#check RML.ExpSum.Weil.reducedModulusSum_bound
#check RML.ExpSum.Weil.centeredReducedIntervalSum_bound
#check RML.ExpSum.Weil.weightedCenteredReducedIntervalSum_bound
```

The last four bounds are proved from the prime theorem and require no external `PrimeNondegenerateWeil` argument. Their underlying reusable lemmas also have versions parameterized by such a proof.

**Scope matters:** the displayed squarefree composite bound assumes a **unit first coefficient**. The reduced-modulus theorem concerns a sum defined at the reduced modulus; it is not a theorem identifying that sum with the original-modulus sum. See [theorem statements](docs/theorems.md) and [limitations](docs/scope.md).

The examples file includes direct applications of the conventional prime theorem, the squarefree unit-numerator theorem, and centered completion, all under their explicit hypotheses. It is compiled by the command above; the examples do not add new mathematical claims.

## Repository guide

| Path | Contents |
| --- | --- |
| `source/rml/carlitz/` | Extension fields, generating series, Newton sums, recurrence and spectral roots |
| `source/rml/stepanov/` | Auxiliary polynomials, Hasse derivatives, point counts and spectral bounds |
| `source/rml/weil/` | Prime normalization, CRT identities, incomplete-sum bounds and public theorems |
| `docs/proof_guide.md` | Proof outline and correspondence with published mathematics |
| `docs/references.md` / `.bib` | Bibliography and citation keys |
| `docs/module_provenance.csv` | Per-module source map |
| `docs/verification.md` | Build, axiom audit and release integrity checks |
| `examples/Use.lean` | Compiled applications of the public theorems |

## Citation

**Software:** Charlie Dorsey (Raccoon Labs), *Weil Bounds Toolkit*, v0.1.0; see [CITATION.cff](CITATION.cff).

**Mathematics:** the prime estimate is due to [Weil (1948)](https://doi.org/10.1073/pnas.34.5.204). The proof draws on [Carlitz (1969)](https://doi.org/10.4064/aa-16-2-179-194), Stepanov's [1971](https://doi.org/10.1070/IM1971v005n02ABEH001049) and [1972](https://doi.org/10.1016/0022-314X(72)90059-5) papers, and Harcos's exposition. See [attribution](docs/attribution.md) for the precise distinctions. No mathematical priority claim is made for this formalization.

Licensed under [Apache-2.0](LICENSE). AI participation and human publication responsibility are described in [attribution](docs/attribution.md). Please consult the [scope limitations](docs/scope.md) and [reproducibility record](docs/verification.md) when reusing theorems.
