# BadranSeq Paper

Manuscript for the BadranSeq R package — an arxiv preprint describing publication-ready scRNA-seq visualisation tools.

## Repos

| Repo | URL | Purpose |
|------|-----|---------|
| **Package** | https://github.com/wolf5996/BadranSeq | R package source (v1.3.1) |
| **Paper** | https://github.com/wolf5996/BadranSeq-paper-draft | This repo — manuscript |

These are **separate git repos**. This paper repo lives inside the package's `paper/` directory but has its own independent git history.

## Building

```bash
quarto render paper.qmd          # produces paper.pdf via LaTeX
```

- Output format: PDF via LaTeX (Palatino, line numbers, DarkSlateBlue headings)
- No executable R code — all code chunks have `execute: echo: false`
- Figures are **pre-generated** in `badranseq_joss_figures/write/figures/`

## Repo Structure

```
paper.qmd                              # Main manuscript (Quarto → LaTeX → PDF)
references.bib                         # BibTeX bibliography (14 entries)
apa.csl                                # APA citation style
badranseq_joss_figures/
  scripts/generate_figures.qmd         # R code to regenerate all 7 figures
  write/figures/                       # Pre-generated figures (SVG + PNG)
context/                               # Personal files (CV) — gitignored
paper_files/                           # Quarto build intermediates — gitignored
```

## Figures

7 figures (fig1–fig7), each available as SVG and PNG:
1. `fig1_comparison` — Seurat vs BadranSeq UMAP
2. `fig2_pca_variance` — PCA with variance labels
3. `fig3_split_silhouette` — Split-panel silhouette
4. `fig4_featureplot` — Gene expression overlay
5. `fig5_elbow_colors` — Elbow plot + colour palette
6. `fig6_stats_violin` — Statistical violin plot
7. `fig7_sankey` — Sankey diagram

To regenerate: open `badranseq_joss_figures/scripts/generate_figures.qmd` in RStudio and run chunks interactively (requires BadranSeq installed).

## Writing Conventions

- British English spelling (visualisation, colour, behaviour)
- Citations use `@key` syntax referencing `references.bib`
- Cross-references: `@fig-name` for figures, `@tbl-name` for tables
- Inline code rendered with grey background via LaTeX `\texttt` override
- Section headings numbered and coloured DarkSlateBlue

## Branching

- `main` — current working branch
- `paper/arxiv-polish` — formatting polish branch (merged)

## Parent Package Context

BadranSeq (wolf5996/BadranSeq) is an R package with:
- 17 exported functions for scRNA-seq visualisation (UMAP, PCA, feature plots, violin, sankey, data extraction, interactive selection)
- Built on Seurat + ggplot2, MIT licence
- Bundled PBMC 3k dataset
- pkgdown docs at https://wolf5996.github.io/BadranSeq/
- CI via GitHub Actions (R-CMD-check)
