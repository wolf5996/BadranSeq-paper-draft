# BadranSeq — Manuscript

> **BadranSeq: Publication-Ready Visualisation for Single-Cell RNA Sequencing Data in R**
>
> Badran Elshenawy · [Nuffield Department of Medicine](https://www.ndm.ox.ac.uk/), University of Oxford

This repository contains the manuscript describing [BadranSeq](https://github.com/wolf5996/BadranSeq), an R package that turns Seurat objects into publication-ready figures with zero boilerplate.

For agent-facing repo context, see [AGENTS.md](AGENTS.md).

<p align="center">
  <img src="badranseq_joss_figures/write/figures/fig1_comparison.png" width="85%" alt="Seurat default vs BadranSeq UMAP comparison"/>
</p>
<p align="center"><em>Seurat's default UMAP (left) vs BadranSeq's <code>do_UmapPlot()</code> (right) — cell borders, cluster labels, and a publication theme out of the box.</em></p>

## Figures at a Glance

All figures are generated from a single script using the bundled PBMC 3k dataset.

| | |
|:---:|:---:|
| ![PCA variance](badranseq_joss_figures/write/figures/fig2_pca_variance.png) | ![Split silhouette](badranseq_joss_figures/write/figures/fig3_split_silhouette.png) |
| **PCA** — automatic variance-explained labels | **Split silhouette** — spatial context preserved across conditions |
| ![Feature plot](badranseq_joss_figures/write/figures/fig4_featureplot.png) | ![Elbow + colours](badranseq_joss_figures/write/figures/fig5_elbow_colors.png) |
| **Feature plot** — viridis scale with cell borders | **Elbow plot** + colour palette demo |
| ![Stats violin](badranseq_joss_figures/write/figures/fig6_stats_violin.png) | ![Sankey](badranseq_joss_figures/write/figures/fig7_sankey.png) |
| **Statistical violin** — Kruskal-Wallis + Dunn's pairwise | **Sankey diagram** — cluster-to-annotation mapping |

## Building the Manuscript

Requires [Quarto](https://quarto.org/) with LaTeX support:

```bash
quarto render paper.qmd
```

## Repository Structure

```
paper/
├── paper.qmd                          # Main manuscript (Quarto + LaTeX PDF)
├── paper.pdf                          # Rendered output
├── references.bib                     # BibTeX bibliography (14 entries)
├── apa.csl                            # APA citation style
└── badranseq_joss_figures/
    ├── scripts/generate_figures.qmd   # R code for all 8 figures
    └── write/figures/                 # Output figures (SVG + PNG, plus fig8 as SVG)
```

## Working Baseline

- This is a standalone git repo nested inside the package repo's `paper/` directory
- `main` is the last merged baseline
- `comparison-rewrite` is the active manuscript branch and is currently 20 commits ahead of `main`
- Generated or local-only paths include `.quarto/`, `paper_files/`, `paper.pdf`, and `context/`

## Regenerating Figures

Figures are **pre-generated** — the manuscript itself contains no executable code. To regenerate them:

1. Install [BadranSeq](https://github.com/wolf5996/BadranSeq)
2. Open `badranseq_joss_figures/scripts/generate_figures.qmd` in RStudio
3. Run chunks interactively (code evaluation is disabled by default)

## Links

- **Package repo**: [github.com/wolf5996/BadranSeq](https://github.com/wolf5996/BadranSeq)
- **Documentation**: [wolf5996.github.io/BadranSeq](https://wolf5996.github.io/BadranSeq/)

## Citation

> Elshenawy, B. (2025). BadranSeq: Publication-Ready Visualisation for Single-Cell RNA Sequencing Data in R. *Preprint*.
