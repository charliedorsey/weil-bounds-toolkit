# References

Citation keys correspond to the machine-readable [BibTeX file](references.bib). Mathematical roles and theorem-level correspondences are described in [proof_guide.md](proof_guide.md). For citing the *software*, use [CITATION.cff](../CITATION.cff).

## Main mathematical sources

- **[Weil1948Exponential]** André Weil, “On Some Exponential Sums,” *Proceedings of the National Academy of Sciences of the United States of America* **34**(5) (1948), 204–207. [doi:10.1073/pnas.34.5.204](https://doi.org/10.1073/pnas.34.5.204). Original theorem.
- **[Carlitz1969]** L. Carlitz, “Kloosterman Sums and Finite Field Extensions,” *Acta Arithmetica* **16**(2) (1969), 179–194. [doi:10.4064/aa-16-2-179-194](https://doi.org/10.4064/aa-16-2-179-194). Extension-field sums and recurrence method. Definitions around (2.8)–(2.13) provide a comparison point; the toolkit's exact generating-series normalization has not been matched equation by equation to the original article.
- **[Stepanov1971Kloosterman]** S. A. Stepanov, “An Estimation of Kloosterman Sums,” *Mathematics of the USSR-Izvestiya* **5**(2) (1971), 319–336. [doi:10.1070/IM1971v005n02ABEH001049](https://doi.org/10.1070/IM1971v005n02ABEH001049). Historical elementary Kloosterman estimate.
- **[Stepanov1972Hyperelliptic]** S. A. Stepanov, “An Elementary Proof of the Hasse–Weil Theorem for Hyperelliptic Curves,” *Journal of Number Theory* **4**(2) (1972), 118–143. [doi:10.1016/0022-314X(72)90059-5](https://doi.org/10.1016/0022-314X(72)90059-5). Auxiliary-polynomial and curve-point methods.
- **[Harcos2015Notes]** Gergely Harcos, *Weil's Bound for Kloosterman Sums*, expository notes (2015). [Author PDF](https://users.renyi.hu/~gharcos/weil.pdf); [author's notes index](https://www.renyi.hu/~gharcos/notes.htm). Main followed exposition, especially Theorem 1, equations (1)–(3), §§3–5, and equations (11)–(22). Its main theorem assumes odd prime \(p\).

## Background references

- **[IwaniecKowalski2004]** Henryk Iwaniec and Emmanuel Kowalski, *Analytic Number Theory*, AMS Colloquium Publications **53** (2004). [Publisher](https://bookstore.ams.org/coll-53). Chapters 11–12 for exponential sums and completion methods.
- **[Schmidt2004]** Wolfgang M. Schmidt, *Equations over Finite Fields: An Elementary Approach*, 2nd ed., Kendrick Press (2004). [Publisher](https://kendrick.press/Wolfgang-M-Schmidt-Equations-Over-Finite-Fields-An-Elementary-Approach.htm). Finite-field and elementary Weil-estimate background.
- **[LidlNiederreiter1996]** Rudolf Lidl and Harald Niederreiter, *Finite Fields*, 2nd ed., Cambridge University Press (1996), ISBN 9780521392310. [Publisher/DOI](https://doi.org/10.1017/CBO9780511525926). Cambridge dates the second-edition printing to 24 October 1996; some library catalogs list it under 1997. We follow the publisher's print date.

These references identify origin, followed exposition or standard technique; they are not citations to identical Lean code. The [provenance review](provenance_review.md) records the remaining correspondence checks.

## Formal dependencies

- [Lean 4](https://github.com/leanprover/lean4), version `v4.34.0`.
- [Mathlib](https://github.com/leanprover-community/mathlib4), pinned at commit `5ed2965256430c3649e86755f9576b54eca72435` in `lake-manifest.json`.
