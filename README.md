# BadranSeq JOSS Paper

Manuscript for the [Journal of Open Source Software](https://joss.theoj.org/) describing [BadranSeq](https://github.com/wolf5996/BadranSeq), an R package for publication-ready single-cell RNA-seq visualisation and tidy data extraction.

## Building

Requires [Quarto](https://quarto.org/) (>= 1.7.29) with typst support:

```bash
quarto render paper.qmd
```

## Figures

All 7 figures are pre-generated SVGs in `badranseq_joss_figures/write/figures/`. The generation code is in `badranseq_joss_figures/scripts/generate_figures.qmd` and requires the BadranSeq package to be installed.

## Citation

> Elshenawy, B. (2025). BadranSeq: Publication-Ready Visualisation for Single-Cell RNA Sequencing Data in R. *Journal of Open Source Software* (submitted).
