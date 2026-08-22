# Supplementary-only functions, constants, and pre-computations
# Loaded by supplementary.qmd and manuscript_clean.qmd.
# Requires: R/packages.R, R/colors.R, R/helpers.R, R/plots.R sourced first.

# ============================================================
# PILOT STUDY 1 (P1) AND PILOT STUDY 2 (P2)
# ============================================================

if (exists("P1") && exists("P2")) {
  pilot_cor_p1 <- cor.test(P1$Religiosity, P1$Moral.Source._13)
  pilot_cor_p2 <- cor.test(P2$Religiosity, P2$Q115_15)

  pilot_reg_p1_simple <- lm(Moral.Source._13 ~ Religiosity, data = P1)
  pilot_reg_p1_adj    <- lm(Moral.Source._13 ~ Religiosity + Political_overall + Age + Income + Education + SES, data = P1)

  pilot_reg_p2_simple <- lm(Q115_15 ~ Religiosity, data = P2)
  pilot_reg_p2_adj    <- lm(Q115_15 ~ Religiosity + Political_overall + Age + Income + Education + SES, data = P2)

  reg_rows_pilot <- list(
    "Pilot 1" = c(apa_lm_summary(pilot_reg_p1_simple, "Religiosity"), apa_lm_summary(pilot_reg_p1_adj, "Religiosity")),
    "Pilot 2" = c(apa_lm_summary(pilot_reg_p2_simple, "Religiosity"), apa_lm_summary(pilot_reg_p2_adj, "Religiosity"))
  )
}


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
