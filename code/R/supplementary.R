# Supplementary-only functions and constants
# Loaded only by supplementary.qmd (standalone) and supplementary_clean.qmd.
# Requires: R/packages.R, R/colors.R, R/helpers.R, R/plots.R sourced first.
#
# Functions shared with the main manuscript (plot_scatter_cor, get_edge_coefs,
# make_path_diagram, extract_indirect, filter_sig_mediators) live in
# R/plots.R and R/tables.R respectively.

# ============================================================
# PILOT STUDY 1 (P1) AND PILOT STUDY 2 (P2)
# ============================================================
# Note: P1 and P2 data loading has been moved to data-loading.R
# to ensure it's available alongside Study 1 and Study 2 data.


# ── Source ranking ─────────────────────────────────────────────────────────────

# --- Summarise source data for ranking plots ---
summarise_sources <- function(source_df) {
  psych::describe(source_df) %>%
    as.data.frame() %>%
    rownames_to_column(var = "Source") %>%
    dplyr::select(Source, mean, sd, median, skew, kurtosis, se) %>%
    arrange(desc(mean))
}

# --- Source ranking dot plot ---
plot_source_ranking <- function(summary_df, y_labels, highlight_source = "Chatbots/AI Assistants") {
  summary_df <- summary_df %>%
    mutate(highlight = if_else(Source == highlight_source, "Highlight", "Normal"))

  ext_mean <- mean(
    summary_df$mean[!summary_df$Source %in% c(highlight_source, "Yourself", RELIGIOUS_SOURCES)],
    na.rm = TRUE
  )

  ggplot(summary_df, aes(x = reorder(Source, mean), y = mean)) +
    geom_point(aes(color = highlight), size = 3) +
    geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2, color = "black") +
    geom_hline(yintercept = ext_mean, linetype = "dashed", color = CLR_ACCENT, linewidth = 0.8) +
    coord_flip() +
    apa_theme +
    theme(axis.text.x = element_text(angle = 45)) +
    labs(x = NULL, y = NULL) +
    scale_y_continuous(limits = c(1, 7), breaks = 1:7, labels = y_labels) +
    scale_color_manual(values = c("Highlight" = CLR_SECONDARY, "Normal" = CLR_PRIMARY), guide = "none")
}

# --- Frequency axis labels (1-7 Likert) ---
FREQ_LABELS <- c(
  "1\nNever", "2\nOnce a year\nor less", "3\nA few times\na year",
  "4\nA few times\na month", "5\nOnce a week",
  "6\nA few times\na week", "7\nOnce a day\nor more"
)

INTEREST_LABELS <- c(
  "1\nNot at all", "2\nSlightly", "3\nSomewhat",
  "4\nNeutral", "5\nModerately", "6\nVery", "7\nExtremely"
)

ACCESS_LABELS <- c(
  "1\nNot at all accessible", "2\nVery difficult to access",
  "3\nDifficult to access", "4\nSomewhat accessible",
  "5\nAccessible", "6\nVery accessible", "7\nCompletely accessible"
)

# --- Generic correlation heatmap ---
# data      : data frame (sources or core study variables)
# var_names : optional named/unnamed character vector of display names;
#             when provided, only numeric columns are kept and renamed.
#             When NULL (default), all columns are used as-is.
# title     : optional plot title (e.g. "Study 1")
# text_size : cell label size (default 3; reduce for large matrices)
#
# Returns a lower-triangle ggplot heatmap with significance stars,
# ordered by hierarchical clustering.
plot_cor_heatmap <- function(data, var_names = NULL, title = NULL,
                             text_size = 3) {
  if (!is.null(var_names)) {
    is_num <- sapply(data, is.numeric)
    data   <- data[, is_num, drop = FALSE]
    var_names <- var_names[is_num]
    colnames(data) <- var_names
  }

  ct    <- psych::corr.test(data, use = "pairwise", method = "pearson",
                            adjust = "none")
  r_mat <- ct$r
  p_mat <- ct$p

  # Order by hierarchical clustering
  hc  <- hclust(as.dist(1 - abs(r_mat)))
  ord <- colnames(r_mat)[hc$order]

  r_mat <- r_mat[ord, ord]
  p_mat <- p_mat[ord, ord]

  # Keep lower triangle only
  r_mat[upper.tri(r_mat, diag = TRUE)] <- NA
  p_mat[upper.tri(p_mat, diag = TRUE)] <- NA

  r_df <- as.data.frame(as.table(r_mat))
  p_df <- as.data.frame(as.table(p_mat))
  names(r_df) <- c("Source1", "Source2", "value")
  names(p_df) <- c("Source1", "Source2", "pval")
  df <- merge(r_df, p_df)
  df <- df[!is.na(df$value), ]

  # Significance stars
  df$stars <- ifelse(df$pval < .001, "***",
              ifelse(df$pval < .01,  "**",
              ifelse(df$pval < .05,  "*", "")))
  df$label <- paste0(formatC(round(df$value, 2), format = "f", digits = 2),
                     df$stars)

  df$Source1 <- factor(df$Source1, levels = ord)
  df$Source2 <- factor(df$Source2, levels = ord)

  ggplot(df, aes(x = Source2, y = Source1, fill = value)) +
    geom_tile(color = "white", linewidth = 0.4) +
    geom_text(aes(label = label), size = text_size, family = "serif") +
    scale_fill_gradient2(low = CLR_SECONDARY, mid = "white", high = CLR_PRIMARY,
                         midpoint = 0, limits = c(-1, 1),
                         name = expression(italic(r))) +
    scale_x_discrete(drop = FALSE) +
    scale_y_discrete(limits = rev(ord), drop = FALSE) +
    { if (!is.null(title)) ggtitle(title) } +
    apa_theme +
    theme(
      axis.text.x     = element_text(angle = 45, hjust = 1, size = 9),
      axis.text.y     = element_text(size = 9),
      panel.grid      = element_blank(),
      plot.title      = element_text(face = "bold", size = 12, hjust = 0.5),
      legend.position = "bottom"
    ) +
    labs(x = NULL, y = NULL)
}


# ── Parallel mediation table ──────────────────────────────────────────────────

# --- Format a combined parallel indirect-effects flextable ---
fmt_parallel_table <- function(df) {
  df$sig_flag <- ifelse(df$sig, "\u2020", "")
  out <- data.frame(
    Study    = df$Study,
    Mediator = paste0(df$Mediator, df$sig_flag),
    b        = round(df$est, 3),
    CI       = paste0("[", round(df$lwr, 3), ", ", round(df$upr, 3), "]")
  )
  names(out) <- c("Study", "Mediator", "b", "95% CI")
  flextable::flextable(out) |>
    flextable::merge_v(j = "Study") |>
    flextable::compose(
      j = "b", part = "header",
      value = flextable::as_paragraph(flextable::as_i("b"))
    ) |>
    flextable::align(j = 1:2, part = "body", align = "left") |>
    flextable::align(j = 3:4, part = "body", align = "center") |>
    flextable::align(part = "header", align = "center") |>
    flextable::border_remove() |>
    flextable::hline_top(
      part = "header",
      border = officer::fp_border(width = 1.5)
    ) |>
    flextable::hline_bottom(
      part = "header",
      border = officer::fp_border(width = 1)
    ) |>
    flextable::hline_bottom(
      part = "body",
      border = officer::fp_border(width = 1.5)
    ) |>
    flextable::set_table_properties(layout = "autofit", width = 1)
}

# --- Extract model evaluation stats from a fitted lavaan parallel model ---
# Returns a list matching the inline values used in question3.qmd:
#   r2, r2_pct   : R² for outcome variable and as a percentage
#   tie_b/lo/hi  : total indirect effect estimate and 95% bootstrap CI
#   cp_b, cp_p   : direct effect estimate and APA-formatted p-value
extract_model_stats <- function(fit, outcome_var) {
  pe  <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  tie <- pe[pe$lhs == "total_indirect" & pe$op == ":=", ]
  cp  <- pe[pe$label == "c_prime", ]
  r2  <- round(inspect(fit, "r2")[outcome_var], 3)
  list(
    r2      = r2,
    r2_pct  = round(r2 * 100, 1),
    tie_b   = round(tie$est,      3),
    tie_lo  = round(tie$ci.lower, 3),
    tie_hi  = round(tie$ci.upper, 3),
    cp_b    = round(cp$est[1],    3),
    cp_p    = apa_p(cp$pvalue[1])
  )
}

# ── Label-based coefficient extractor for supplementary path diagrams ────────
# Unlike get_edge_coefs() (which looks up by lhs/rhs variable name and can
# return "?" if names don't match exactly), this function looks up coefficients
# by the parameter *label* (a1, b1, c_prime) that build_parallel_model()
# writes explicitly — guaranteeing a match every time.
#
# Arguments:
#   fit : fitted lavaan sem object
#   n   : number of mediators in the model
#
# Returns a named list ready to pass directly as `coefs` to make_path_diagram():
#   a1 ... an  (predictor → mediator paths)
#   b1 ... bn  (mediator → outcome paths)
#   cp         (direct path)
# Note: extract_path_coefs, filter_sig_indirect, pick_cluster_reps, and build_parallel_model
# have been moved to R/tables.R to make them available in both question3.qmd and supplementary.qmd.

