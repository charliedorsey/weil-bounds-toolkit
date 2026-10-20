# Source-correspondence notes

This page records how far the bibliographic checks support the mathematical claims. The detailed module map is in [module_provenance.csv](module_provenance.csv).

| Source | Checked publication details | Role in the formalization |
| --- | --- | --- |
| Weil (1948) | *PNAS* 34(5), 204–207; [DOI](https://doi.org/10.1073/pnas.34.5.204) | Historical origin of the prime bound |
| Carlitz (1969) | *Acta Arithmetica* 16(2), 179–194; [journal record](https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/16/2/96945/kloosterman-sums-and-finite-field-extensions) | Extension-field and recurrence construction; exact generating-series normalization remains unchecked against the printed formulas |
| Stepanov (1971) | *Mathematics of the USSR-Izvestiya* 5(2), 319–336; [DOI](https://doi.org/10.1070/IM1971v005n02ABEH001049) | Historical elementary Kloosterman proof |
| Stepanov (1972) | *Journal of Number Theory* 4(2), 118–143; [DOI](https://doi.org/10.1016/0022-314X(72)90059-5) | Auxiliary-polynomial and hyperelliptic point-counting technique |
| Harcos (2015) | [Author's notes](https://users.renyi.hu/~gharcos/weil.pdf) | Followed exposition: Theorem 1, (1)–(3), (11)–(22), §§3–5 |
| Iwaniec–Kowalski (2004) | AMS Colloquium Publications 53 | Standard exponential-sum and completion methods, not the exact printed source of each Lean lemma |
| Schmidt (2004) | Kendrick Press, second edition | Finite-field and elementary-method background |
| Lidl–Niederreiter | Cambridge second edition; [publisher record](https://doi.org/10.1017/CBO9780511525926) | Finite-field background; Cambridge's 1996 print date differs from some catalogs' 1997 listing |

## Outstanding bibliographic check

The full equation-by-equation comparison between Carlitz (1969) and `carlitz/generating_identity.lean` — especially coefficient, sign and trace conventions — has not been completed. The source family and historical reference are sound, but the release does not assert that its Lean identity is a verbatim numbered formula from Carlitz.

No study of priority among Lean formalizations has been undertaken. The library makes no claim of being the first such formalization. The source repository is [https://github.com/charliedorsey/weil-bounds-toolkit](https://github.com/charliedorsey/weil-bounds-toolkit); no release DOI or ORCID is claimed.

## Verification record

All 40 distributed Lean library files and the consumer example are byte-identical to the independently compiled and axiom-audited source described in the [release verification record](release_verification.json). The published-source documentation and citation changes do not alter the Lean files, toolchain or dependency pin. The packaged integrity check and the full Lean compiler/axiom checks are distinct; see [verification.md](verification.md) for their evidence scopes.

The original paper sources are cited, not redistributed.
