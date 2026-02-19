# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Context

This is the `paper/` subdirectory of the [BadranSeq](https://github.com/wolf5996/BadranSeq) R package. It contains a JOSS (Journal of Open Source Software) manuscript describing the package. The parent repo at `../` is the R package itself — see `../docs/CLAUDE.md` for package development guidance.

## Build Commands

```bash
# Render the paper to PDF (requires Quarto + typst)
quarto render paper.qmd

# Regenerate figures (run from paper/ directory, requires BadranSeq installed)
# Open badranseq_joss_figures/scripts/generate_figures.qmd in RStudio and run chunks manually
# (execute: eval is set to false — figures are generated interactively, not on render)
```

## File Layout

| File/Dir | Purpose |
|----------|---------|
| `paper.qmd` | Main manuscript (Quarto, typst backend via `preprint-typst` format) |
| `paper.pdf` | Rendered output |
| `references.bib` | BibTeX bibliography (14 entries) |
| `apa.csl` | APA citation style |
| `_extensions/mvuorre/preprint/` | Quarto typst extension (preprint template v1.4.3) |
| `badranseq_joss_figures/scripts/generate_figures.qmd` | R code that produces all 7 figures |
| `badranseq_joss_figures/write/figures/` | Output figures in SVG, PDF, and PNG formats |

## Manuscript Structure

`paper.qmd` follows JOSS conventions: Summary, Statement of Need, State of the Field, Software Design (with subsections for each major feature), Research Impact Statement, AI Usage Disclosure, Acknowledgements, References.

Figures are **pre-generated SVGs** included via markdown image syntax (`![caption](path){#fig-label}`), not computed during render. The `execute: echo: false` block suppresses any code output; there are no executable code chunks in `paper.qmd` itself.

## Figures

7 figures, all generated from `badranseq_joss_figures/scripts/generate_figures.qmd` using the bundled `pbmc3k` dataset:

| Fig | File | Shows |
|-----|------|-------|
| 1 | `fig1_comparison` | Seurat default vs BadranSeq UMAP side-by-side |
| 2 | `fig2_pca_variance` | PCA with automatic variance-explained labels |
| 3 | `fig3_split_silhouette` | Split-panel silhouette visualisation |
| 4 | `fig4_featureplot` | Gene expression overlay (CD3D, CD8A, CD14) |
| 5 | `fig5_elbow_colors` | Elbow plot + colour palette demo |
| 6 | `fig6_stats_violin` | Statistical violin with Kruskal-Wallis + Dunn's |
| 7 | `fig7_sankey` | Sankey diagram (clusters → annotations) |

The paper references SVG versions. Each figure also exists as PDF and PNG.

## Citation Keys

All `@cite-key` references in `paper.qmd` must have a matching entry in `references.bib`. Current keys: `hao2024`, `stuart2019`, `butler2018`, `blancocarmona2022`, `mcinnes2018`, `wickham2016`, `zeileis2020`, `ovchinnikova2020`, `heumos2023`, `luecken2019`, `rcore2024`, `garnier2023`, `patil2021`, `brunson2020`.

## Relationship to Parent Package

- The manuscript describes BadranSeq's exported functions — any function renames, parameter changes, or new features in `../R/` may require updates here
- Figures are generated using `BadranSeq::` calls on the bundled `pbmc3k` dataset from `../data/`
- The paper is excluded from the R package build (listed in `../.Rbuildignore`) and from git tracking (listed in `../.gitignore`)
