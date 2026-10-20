# Authorship and mathematical attribution

## Software

**Charlie Dorsey (Raccoon Labs)** is the credited software author of *Weil Bounds Toolkit*, v0.1.0. The machine-readable record is [CITATION.cff](../CITATION.cff). The source forms part of the Raccoon Math Library (RML) development. The source repository is [https://github.com/charliedorsey/weil-bounds-toolkit](https://github.com/charliedorsey/weil-bounds-toolkit). No DOI, ORCID or release publication date is claimed by this source archive.

Suggested citation: **Dorsey, Charlie (Raccoon Labs). *Weil Bounds Toolkit*, v0.1.0. Lean 4 software.** Repository: [https://github.com/charliedorsey/weil-bounds-toolkit](https://github.com/charliedorsey/weil-bounds-toolkit). Cite a version-specific release URL or DOI if subsequently assigned.

## AI contributions and human responsibility

Charlie Dorsey recognized recurring needs for the Kloosterman–Weil machinery across research projects and specifically directed its extraction into a reusable, externally understandable Lean toolkit. He steered its scope, requested checks and revisions, critically reviewed presentations and mathematical claims, and retains responsibility for licensing, publication decisions, and the accuracy of public claims.

Generative AI systems made **substantive intellectual and technical contributions** to designing the toolkit and its interfaces, mathematical development and proof exploration, writing the Lean formalization, review and checking, documentation, and release preparation. The formal claims are supported by Lean checking under the stated hypotheses and axioms; this should not be mistaken for an independent human rederivation of every proof. Individual AI instances are not listed as human authors. The mathematical sources and classical theorems are credited separately below.

## Mathematics

The prime exponential-sum estimate originates with **Weil (1948)**. The extension-field generating identity and recurrence follow the **Carlitz (1969)** tradition. The auxiliary-polynomial and hyperelliptic counting method develops ideas of **Stepanov (1971, 1972)**; the proof here closely follows **Harcos's 2015 exposition**. The exact citations and their roles are documented in [references.md](references.md), [proof_guide.md](proof_guide.md) and the [module-by-module map](module_provenance.csv).

The implementation also proves its particular CRT normalizations, interval completion lemmas, edge cases and interfaces. These are not presented as verbatim transcriptions of the publications. The library claims neither the discovery of the classical theorem nor priority among formalizations.

The source is licensed under [Apache-2.0](../LICENSE); referenced articles and textbooks are not redistributed.
