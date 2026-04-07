# Reusable plot functions
# Requires: R/colors.R, R/helpers.R sourced first
#
# NOTE: Supplementary-only functions (source ranking plots, Likert labels,
#       parallel mediation table formatter) live in R/supplementary.R.

# --- Scatter plot with correlation annotation ---
plot_scatter_cor <- function(data, x_var, y_var, x_label = NULL, y_label = NULL) {
  x_vals <- data[[x_var]]
  y_vals <- data[[y_var]]
  cor_lab <- apa_cor_label(x_vals, y_vals)

  p <- ggplot(data, aes(x = .data[[x_var]], y = .data[[y_var]])) +
    geom_point(
      alpha = 0.6,
      position = position_jitter(width = 0.1, height = 0.1),
      color = CLR_PRIMARY
    ) +
    geom_smooth(
      method = "loess", color = CLR_SECONDARY, se = TRUE,
      fill = CLR_SECONDARY_FILL, linetype = "dashed"
    ) +
    geom_smooth(
      method = "lm", color = CLR_ACCENT, se = TRUE,
      fill = CLR_ACCENT_FILL, linetype = "dashed"
    ) +
    annotate("text",
      x = min(x_vals, na.rm = TRUE) + diff(range(x_vals, na.rm = TRUE)) * 0.15,
      y = max(y_vals, na.rm = TRUE) - diff(range(y_vals, na.rm = TRUE)) * 0.08,
      label = cor_lab, parse = TRUE, size = 4, family = "serif"
    ) +
    labs(x = x_label, y = y_label) +
    apa_theme

  if (!is.null(x_label)) p <- p + scale_x_continuous(name = x_label, breaks = pretty_breaks(n = 5))
  if (!is.null(y_label)) p <- p + scale_y_continuous(name = y_label, breaks = pretty_breaks(n = 5))

  return(p)
}

# --- Extract indirect effects from a lavaan parallel mediation fit ---
extract_indirect <- function(fit, labels, study_label) {
  pe <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  inds <- pe[pe$op == ":=" & grepl("^ind", pe$lhs), ]
  df <- data.frame(
    Study = study_label, Mediator = labels,
    est = inds$est, lwr = inds$ci.lower,
    upr = inds$ci.upper, sig = inds$pvalue < .05
  )
  df
}

# --- Coefficient extractor for path diagram labels ---
get_edge_coefs <- function(fit) {
  pe  <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  std <- standardizedSolution(fit)
  pe$beta <- std$est.std[match(
    paste(pe$lhs, pe$op, pe$rhs),
    paste(std$lhs, std$op, std$rhs)
  )]
  # Return "--" for NA/missing values instead of crashing
  fn <- function(x, d = 2) {
    if (length(x) == 0 || all(is.na(x))) {
      return("--")
    }
    formatC(round(x[1], d), format = "f", digits = d)
  }
  function(lhs_val, rhs_val) {
    row <- pe[pe$lhs == lhs_val & pe$op == "~" & pe$rhs == rhs_val, ]
    if (nrow(row) == 0) {
      return(list(b = "?", beta = "?", lo = "?", hi = "?"))
    }
    row <- row[1, ] # guard against duplicate rows
    list(
      b    = fn(row$est),
      beta = fn(row$beta),
      lo   = fn(row$ci.lower),
      hi   = fn(row$ci.upper)
    )
  }
}

# --- ggplot2 parallel mediation path diagram (3-color, coef labels) ---
# predictor_label / outcome_label: display names for the X and Y nodes
make_path_diagram <- function(mediator_labels, coefs,
                              predictor_label = "Religious\nBehavior Score",
                              outcome_label = "Frequency of Seeking\nMoral Advice from\nAI Chatbots") {
  # Auto-wrap long mediator labels to fit inside node boxes
  mediator_labels <- sapply(mediator_labels, function(s) {
    paste(strwrap(s, width = 20), collapse = "\n")
  }, USE.NAMES = FALSE)

  n    <- length(mediator_labels)
  y_c  <- (n + 1) / 2
  y_m  <- seq(n, 1, by = -1)
  x_X  <- 0
  x_M  <- 7
  x_Y  <- 14
  bw   <- 2.2
  # Scale box height with the number of lines in the longest wrapped label
  max_lines <- max(sapply(mediator_labels, function(s) length(strsplit(s, "\n")[[1]])))
  bh <- max(0.28, 0.12 * max_lines)

  fmt_lbl <- function(e) {
    sprintf("%s (%s)\n[%s, %s]", e$b, e$beta, e$lo, e$hi)
  }

  nodes <- data.frame(
    x    = c(x_X, rep(x_M, n), x_Y),
    y    = c(y_c, y_m, y_c),
    xmin = c(x_X, rep(x_M, n), x_Y) - bw,
    xmax = c(x_X, rep(x_M, n), x_Y) + bw,
    ymin = c(y_c, y_m, y_c) - bh,
    ymax = c(y_c, y_m, y_c) + bh,
    label = c(predictor_label, mediator_labels, outcome_label),
    fill  = c(CLR_PRIMARY, rep(CLR_ACCENT, n), CLR_SECONDARY),
    stringsAsFactors = FALSE
  )

  a_df <- data.frame(
    x = x_X + bw, xend = x_M - bw, y = y_c, yend = y_m,
    lbl = sapply(seq_len(n), function(i) fmt_lbl(coefs[[paste0("a", i)]])),
    lx = (x_X + bw + x_M - bw) / 2,
    ly = (y_c + y_m) / 2,
    stringsAsFactors = FALSE
  )

  b_df <- data.frame(
    x = x_M + bw, xend = x_Y - bw, y = y_m, yend = y_c,
    lbl = sapply(seq_len(n), function(i) fmt_lbl(coefs[[paste0("b", i)]])),
    lx = (x_M + bw + x_Y - bw) / 2,
    ly = (y_m + y_c) / 2,
    stringsAsFactors = FALSE
  )

  cp_y <- min(y_m) - bh - 0.5

  ggplot() +
    geom_segment(
      data = a_df,
      aes(x = x, y = y, xend = xend, yend = yend),
      arrow = arrow(length = unit(0.22, "cm"), type = "closed"),
      color = "grey45", linewidth = 0.6
    ) +
    geom_segment(
      data = b_df,
      aes(x = x, y = y, xend = xend, yend = yend),
      arrow = arrow(length = unit(0.22, "cm"), type = "closed"),
      color = "grey45", linewidth = 0.6
    ) +
    annotate("segment",
      color = "red", linetype = "dashed", linewidth = 0.55,
      x = x_X + bw, xend = x_X + bw, y = y_c - bh, yend = cp_y
    ) +
    annotate("segment",
      color = "red", linetype = "dashed", linewidth = 0.55,
      x = x_X + bw, xend = x_Y - bw, y = cp_y, yend = cp_y
    ) +
    annotate("segment",
      color = "red", linetype = "dashed", linewidth = 0.55,
      x = x_Y - bw, xend = x_Y - bw, y = cp_y, yend = y_c - bh,
      arrow = arrow(length = unit(0.22, "cm"), type = "closed")
    ) +
    geom_label(
      data = a_df, aes(x = lx, y = ly, label = lbl),
      size = 3.8, lineheight = 0.9, fill = "white",
      label.size = 0, label.r = unit(0, "pt"),
      label.padding = unit(0, "lines"), family = "serif"
    ) +
    geom_label(
      data = b_df, aes(x = lx, y = ly, label = lbl),
      size = 3.8, lineheight = 0.9, fill = "white",
      label.size = 0, label.r = unit(0, "pt"),
      label.padding = unit(0, "lines"), family = "serif"
    ) +
    geom_label(
      data = data.frame(
        x = (x_X + x_Y) / 2, y = cp_y,
        lbl = paste0(fmt_lbl(coefs$cp), "\nDirect Effect")
      ),
      aes(x = x, y = y, label = lbl),
      size = 3.8, lineheight = 0.9, fill = "white",
      label.size = 0, label.r = unit(0, "pt"),
      label.padding = unit(0, "lines"), family = "serif"
    ) +
    geom_rect(
      data = nodes,
      aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = fill),
      color = "white", linewidth = 0.9
    ) +
    scale_fill_identity() +
    geom_text(
      data = nodes, aes(x = x, y = y, label = label),
      size = 3.8, lineheight = 0.9, color = "white", fontface = "bold",
      family = "serif"
    ) +
    theme_void() +
    theme(
      legend.position = "none",
      plot.margin = margin(0, 0, 30, 0)
    )
}

# --- Interaction (moderation) plot: predicted lines at low/med/high moderator ---
# model        : fitted lm with R_Score * moderator_var interaction
# moderator_var: string name of the moderator column in the data
# mod_vals     : named numeric vector of three moderator quantiles (low/med/high)
# mod_label    : legend title for the moderator
make_mod_plot <- function(model, moderator_var, mod_vals, mod_label,
                          x_var = "R_Score",
                          x_label = "Religious Behavior Score",
                          y_label = "Frequency of Seeking Moral Advice from AI Chatbots") {
  x_range <- seq(min(model$model[[x_var]], na.rm = TRUE),
    max(model$model[[x_var]], na.rm = TRUE),
    length.out = 50
  )
  grid <- expand.grid(x = x_range, mod = mod_vals) |>
    setNames(c(x_var, moderator_var))
  ci <- predict(model, newdata = grid, interval = "confidence")
  grid$fit <- ci[, "fit"]
  grid$lwr <- ci[, "lwr"]
  grid$upr <- ci[, "upr"]
  grid$Access_Level <- factor(
    rep(c("Low", "Medium", "High"), each = length(x_range)),
    levels = c("Low", "Medium", "High")
  )
  ggplot(grid, aes(
    x = .data[[x_var]], y = fit,
    color = Access_Level, fill = Access_Level,
    group = Access_Level
  )) +
    geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.15, color = NA) +
    geom_line(linewidth = 1) +
    labs(x = x_label, y = y_label, color = mod_label, fill = mod_label) +
    scale_color_manual(values = c(CLR_PRIMARY, CLR_ACCENT, CLR_SECONDARY)) +
    scale_fill_manual(values = c(CLR_PRIMARY, CLR_ACCENT, CLR_SECONDARY)) +
    apa_theme
}
