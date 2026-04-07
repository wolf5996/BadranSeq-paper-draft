#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(BadranSeq)
  library(Seurat)
  library(ggplot2)
  library(patchwork)
})

fig_dir <- normalizePath("../write/figures", winslash = "/", mustWork = TRUE)

save_plot <- function(filename, plot, width, height) {
  ggsave(
    filename = file.path(fig_dir, filename),
    plot = plot,
    width = width,
    height = height,
    bg = "white"
  )
}

figure_1 <- function() {
  data(pbmc3k)

  p_seurat_default <- Seurat::DimPlot(pbmc3k, reduction = "umap") +
    ggtitle("Seurat: Default") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_seurat_labels <- Seurat::DimPlot(pbmc3k, reduction = "umap", label = TRUE) +
    ggtitle("Seurat: With Labels") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_badran_default <- BadranSeq::do_UmapPlot(pbmc3k) +
    ggtitle("BadranSeq: Default") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_badran_enhanced <- BadranSeq::do_UmapPlot(
    pbmc3k,
    label = TRUE,
    plot_cell_borders = TRUE
  ) +
    ggtitle("BadranSeq: Enhanced") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_combined <- (p_seurat_default + p_seurat_labels) /
    (p_badran_default + p_badran_enhanced) +
    plot_annotation(
      title = "UMAP Visualisation Comparison",
      subtitle = paste(
        "Seurat (top) requires manual styling for publication;",
        "BadranSeq (bottom) produces publication-ready output by default"
      ),
      theme = theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 11, hjust = 0.5, colour = "grey40")
      )
    )

  save_plot("fig1_comparison.svg", p_combined, 14, 10)
}

figure_2 <- function() {
  data(pbmc3k)

  p_pc12 <- BadranSeq::do_PcaPlot(pbmc3k, dims = c(1, 2)) +
    ggtitle("PC1 vs PC2")

  p_pc23 <- BadranSeq::do_PcaPlot(pbmc3k, dims = c(2, 3)) +
    ggtitle("PC2 vs PC3")

  p_combined <- p_pc12 + p_pc23 +
    plot_annotation(
      title = "PCA with Automatic Variance Labels",
      theme = theme(plot.title = element_text(face = "bold", size = 16, hjust = 0.5))
    )

  save_plot("fig2_pca_variance.svg", p_combined, 14, 7)
}

figure_3 <- function() {
  data(pbmc3k)
  set.seed(42)
  pbmc3k$condition <- sample(c("Control", "Treatment"), ncol(pbmc3k), replace = TRUE)

  p_seurat_split <- Seurat::DimPlot(pbmc3k, reduction = "umap", split.by = "condition") +
    ggtitle("Seurat: split.by faceting") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_badran_split <- BadranSeq::do_UmapPlot(pbmc3k, split.by = "condition") +
    plot_annotation(
      title = "BadranSeq: silhouette approach",
      theme = theme(plot.title = element_text(face = "bold", size = 12))
    )

  p_combined <- p_seurat_split / p_badran_split +
    plot_annotation(
      title = "Split-Panel Comparison: Context Preservation",
      subtitle = paste(
        "Seurat (top) isolates each group, destroying spatial context.",
        "BadranSeq (bottom) preserves full embedding geometry via grey silhouettes."
      ),
      theme = theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 11, hjust = 0.5, colour = "grey40")
      )
    )

  save_plot("fig3_split_silhouette.svg", p_combined, 14, 12)
}

figure_4 <- function() {
  data(pbmc3k)

  p_seurat_features <- Seurat::FeaturePlot(
    pbmc3k,
    features = c("CD3D", "CD8A", "CD14"),
    reduction = "umap",
    ncol = 3
  ) +
    plot_annotation(
      title = "Seurat: FeaturePlot()",
      theme = theme(plot.title = element_text(face = "bold", size = 12))
    )

  p_badran_features <- BadranSeq::do_FeaturePlot(
    pbmc3k,
    features = c("CD3D", "CD8A", "CD14"),
    reduction = "umap",
    ncol = 3
  ) +
    plot_annotation(
      title = "BadranSeq: do_FeaturePlot()",
      theme = theme(plot.title = element_text(face = "bold", size = 12))
    )

  p_combined <- p_seurat_features / p_badran_features +
    plot_annotation(
      title = "Feature Expression Visualisation Comparison",
      subtitle = paste(
        "Seurat (top) uses default colour scales.",
        "BadranSeq (bottom) applies viridis scales, cell borders for legibility, and consistent publication styling."
      ),
      theme = theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 11, hjust = 0.5, colour = "grey40")
      )
    )

  save_plot("fig4_featureplot.svg", p_combined, 14, 10)
}

figure_5 <- function() {
  data(pbmc3k)

  p_seurat_elbow <- Seurat::ElbowPlot(pbmc3k, ndims = 30) +
    ggtitle("Seurat: ElbowPlot()") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_badran_elbow <- BadranSeq::EnhancedElbowPlot(pbmc3k, ndims = 30, cutoff_pc = 10) +
    ggtitle("BadranSeq: EnhancedElbowPlot()") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_combined <- p_seurat_elbow / p_badran_elbow +
    plot_annotation(
      title = "Elbow Plot Comparison",
      subtitle = paste(
        "Seurat (top) shows standard deviation by PC.",
        "BadranSeq (bottom) adds variance explained and cutoff annotation."
      ),
      theme = theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 11, hjust = 0.5, colour = "grey40")
      )
    )

  save_plot("fig5_elbow_colors.svg", p_combined, 10, 10)
}

figure_6 <- function() {
  data(pbmc3k)
  selected_annotations <- c("Naive CD4 T", "Memory CD4 T", "CD8 T")
  pbmc3k_subset <- subset(pbmc3k, subset = seurat_annotations %in% selected_annotations)
  pbmc3k_subset$seurat_annotations <- factor(
    pbmc3k_subset$seurat_annotations,
    levels = selected_annotations
  )

  p_seurat_vln <- Seurat::VlnPlot(
    pbmc3k_subset,
    features = "CD3D",
    group.by = "seurat_annotations",
    pt.size = 0
  ) +
    ggtitle("Seurat: VlnPlot()") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_badran_vln <- BadranSeq::do_StatsViolinPlot(
    pbmc3k,
    features = "CD3D",
    group.by = "seurat_annotations",
    group.levels = selected_annotations
  ) +
    ggtitle("BadranSeq: do_StatsViolinPlot()") +
    theme(plot.title = element_text(face = "bold", size = 12))

  p_combined <- p_seurat_vln + p_badran_vln +
    plot_annotation(
      title = "Distribution Comparison with Statistical Testing",
      subtitle = paste(
        "Seurat (left) shows expression distributions.",
        "BadranSeq (right) integrates Kruskal-Wallis testing and Dunn's pairwise comparisons with automatic formatting."
      ),
      theme = theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 11, hjust = 0.5, colour = "grey40")
      )
    )

  save_plot("fig6_stats_violin.svg", p_combined, 14, 8)
}

figure_7 <- function() {
  data(pbmc3k)

  p_sankey <- BadranSeq::do_SankeyPlot(
    pbmc3k,
    columns = c("seurat_clusters", "seurat_annotations")
  )

  save_plot("fig7_sankey.svg", p_sankey, 9, 6)
}

figure_8 <- function() {
  dependency_data <- data.frame(
    Package = c("BadranSeq", "SCpubr"),
    Dependencies = c(19, 56),
    stringsAsFactors = FALSE
  )

  p_deps <- ggplot(dependency_data, aes(x = Dependencies, y = reorder(Package, Dependencies))) +
    geom_col(aes(fill = Package), width = 0.6, show.legend = FALSE) +
    geom_text(aes(label = Dependencies), hjust = -0.3, size = 5, fontface = "bold") +
    scale_fill_manual(values = c("BadranSeq" = "#2E86AB", "SCpubr" = "#A23B72")) +
    scale_x_continuous(limits = c(0, 70), breaks = seq(0, 70, by = 10), expand = c(0, 0)) +
    labs(
      title = "Dependency Footprint Comparison",
      subtitle = "BadranSeq maintains a 66% smaller dependency tree than SCpubr (19 vs 56 direct dependencies)",
      x = "Number of Direct Dependencies",
      y = NULL
    ) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
      plot.subtitle = element_text(size = 11, hjust = 0.5, colour = "grey40"),
      axis.text.y = element_text(face = "bold", size = 12),
      axis.text.x = element_text(colour = "grey40"),
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.margin = margin(20, 20, 20, 20)
    )

  save_plot("fig8_dependency_comparison.png", p_deps, 10, 5)
}

figures <- list(
  fig1 = figure_1,
  fig2 = figure_2,
  fig3 = figure_3,
  fig4 = figure_4,
  fig5 = figure_5,
  fig6 = figure_6,
  fig7 = figure_7,
  fig8 = figure_8
)

for (name in names(figures)) {
  message("Running ", name, "...")
  tryCatch(
    {
      figures[[name]]()
      message("OK: ", name)
    },
    error = function(err) {
      message("FAILED: ", name)
      stop(err)
    }
  )
}

message("All figure scripts completed successfully.")
