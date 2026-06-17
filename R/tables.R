# Table-generating functions for regression, mediation, and correlation
# Requires: R/helpers.R and flextable loaded first
#
# NOTE: filter_sig_indirect, pick_cluster_reps, and build_parallel_model are
#       supplementary-only and live in R/supplementary.R.

# --- Shared APA flextable builder ---
# Takes a data frame, column display names, and an optional spanner spec.
# spanner: named integer vector passed to flextable::add_header_row()
#   names  = spanner label ("" for a blank cell)
#   values = number of columns that spanner covers (left-to-right)
make_apa_flextable <- function(df, col_names = NULL, spanner = NULL) {
  ft <- flextable::flextable(df)

  # Rename columns for display
  if (!is.null(col_names)) {
    ft <- flextable::set_header_labels(ft,
      values = setNames(as.list(col_names), names(df))
    )
  }

  # Add spanner row above the column headers
  if (!is.null(spanner)) {
    ft <- flextable::add_header_row(
      ft,
      values = names(spanner),
      colwidths = unname(spanner),
      top = TRUE
    )
  }

  # Italicise APA-standard column headers where present
  # Target only the column-name row (row 2 when a spanner exists, row 1 otherwise)
  hdr_row <- if (!is.null(spanner)) 2 else 1
  header_labels <- if (!is.null(col_names)) col_names else names(df)
  for (idx in seq_along(names(df))) {
    display <- header_labels[idx]
    if (display %in% c("b", "p", "SE", "\u03b2", "r", "t", "d", "df")) {
      ft <- flextable::compose(
        ft, i = hdr_row, j = names(df)[idx], part = "header",
        value = flextable::as_paragraph(flextable::as_i(display))
      )
    }
  }

  # APA-style formatting
  ft <- flextable::align(ft, part = "header", align = "center")
  ft <- flextable::align(ft, j = 1, part = "body", align = "left")
  ft <- flextable::align(ft, j = seq_along(df)[-1], part = "body", align = "center")
  ft <- flextable::border_remove(ft) # remove inner borders first
  ft <- flextable::hline_top(ft,
    part = "header",
    border = officer::fp_border(width = 1.5)
  )
  ft <- flextable::hline_bottom(ft,
    part = "header",
    border = officer::fp_border(width = 1)
  )
  ft <- flextable::hline_bottom(ft,
    part = "body",
    border = officer::fp_border(width = 1.5)
  )

  # Stretch to full page width
  ft <- flextable::set_table_properties(ft, layout = "autofit", width = 1)

  ft
}


# --- Correlation table helper ---
# Takes a data frame with columns: Study, N, r, t, df, p
# Returns an APA-formatted flextable with italicised r / t / p headers.
make_cor_flextable <- function(df) {
  flextable::flextable(df) |>
    flextable::compose(
      j = "r", part = "header",
      value = flextable::as_paragraph(flextable::as_i("r"))
    ) |>
    flextable::compose(
      j = "t", part = "header",
      value = flextable::as_paragraph(flextable::as_i("t"))
    ) |>
    flextable::compose(
      j = "p", part = "header",
      value = flextable::as_paragraph(flextable::as_i("p"))
    ) |>
    flextable::align(j = 1, part = "body", align = "left") |>
    flextable::align(j = 2:6, part = "body", align = "center") |>
    flextable::align(part = "header", align = "center") |>
    flextable::border_remove() |>
    flextable::hline_top(part = "header", border = officer::fp_border(width = 1.5)) |>
    flextable::hline_bottom(part = "header", border = officer::fp_border(width = 1)) |>
    flextable::hline_bottom(part = "body", border = officer::fp_border(width = 1.5)) |>
    flextable::set_table_properties(layout = "autofit", width = 1)
}


# --- Study-level regression table (Model 1 + Model 2 side-by-side) ---
# rows_list : named list where each element is the concatenated output of two
#             apa_lm_summary() calls.
# study_names: character vector of row labels (default: names(rows_list)).
make_study_reg_table <- function(rows_list, study_names = names(rows_list)) {
  reg_df <- data.frame(
    Study = study_names,
    do.call(rbind, rows_list),
    stringsAsFactors = FALSE
  )

  sub_hdr <- c(
    "Study", "\u03b2", "SE", "95% CI LL", "95% CI UL", "p",
    "\u03b2", "SE", "95% CI LL", "95% CI UL", "p"
  )
  spanner <- c(" " = 1, "Model 1" = 5, "Model 2" = 5)

  make_apa_flextable(reg_df, col_names = sub_hdr, spanner = spanner)
}


# --- Study-level adjusted regression table (Model 2 only, for main text) ---
make_study_reg_adj_table <- function(rows_list, study_names = names(rows_list), model_name = "Demographic-Adjusted Model") {
  reg_df <- data.frame(
    Study = study_names,
    do.call(rbind, rows_list),
    stringsAsFactors = FALSE
  )

  sub_hdr <- c(
    "Study", "\u03b2", "SE", "95% CI LL", "95% CI UL", "p"
  )
  spanner <- c(" " = 1, model_name = 5)

  make_apa_flextable(reg_df, col_names = sub_hdr, spanner = spanner)
}# --- Regression table: X predicting mediators ---
regression_table <- function(
  data,
  x_var,
  mediator_list,
  mediator_names = NULL,
  adjustment_vars = c("Political", "Age", "Income", "Education", "SES")
) {
  # Scale all continuous variables (x_var, mediators, adjustment_vars)
  scale_vars <- c(x_var, names(mediator_list), adjustment_vars)
  for (v in scale_vars) {
    if (v %in% names(data) && is.numeric(data[[v]])) {
      data[[v]] <- as.numeric(scale(data[[v]]))
    }
  }

  if (is.null(mediator_names)) mediator_names <- names(mediator_list)
  if (is.list(mediator_names)) mediator_names <- unlist(mediator_names, use.names = FALSE)
  stopifnot(length(mediator_names) == length(mediator_list))

  threshold <- 0.05 / length(mediator_list)

  table_rows <- list()
  for (i in seq_along(mediator_list)) {
    m       <- names(mediator_list)[i]
    display <- mediator_names[i]
    
    mod1    <- lm(as.formula(paste0(m, " ~ ", x_var)), data = data)
    p_val1  <- summary(mod1)$coefficients[x_var, "Pr(>|t|)"]
    sig1    <- ifelse(p_val1 < threshold, "Yes", "No")
    row1    <- c(apa_lm_summary(mod1, x_var), sig = sig1)
    names(row1) <- paste("Model1", names(row1), sep = "_")
    
    adj_f   <- paste(m, "~", x_var, "+", paste(adjustment_vars, collapse = " + "))
    mod2    <- lm(as.formula(adj_f), data = data)
    p_val2  <- summary(mod2)$coefficients[x_var, "Pr(>|t|)"]
    sig2    <- ifelse(p_val2 < threshold, "Yes", "No")
    row2    <- c(apa_lm_summary(mod2, x_var), sig = sig2)
    names(row2) <- paste("Model2", names(row2), sep = "_")
    
    table_rows[[display]] <- c(row1, row2)
  }

  results <- as.data.frame(do.call(rbind, table_rows))
  results <- data.frame(
    Mediator = rownames(results), results,
    row.names = NULL, stringsAsFactors = FALSE
  )

  sub_hdr <- c(
    "Mediator", 
    "\u03b2", "SE", "95% CI LL", "95% CI UL", "p", "Sig (Corrected)",
    "\u03b2", "SE", "95% CI LL", "95% CI UL", "p", "Sig (Corrected)"
  )

  spanner <- c(" " = 1, "Model 1" = 6, "Model 2" = 6)

  make_apa_flextable(results, col_names = sub_hdr, spanner = spanner)
}


# --- Run raw mediation analyses (once) ---
run_mediation_analyses <- function(
  data,
  x_var,
  y_var,
  mediator_list,
  mediator_names = NULL,
  sims = 5000
) {
  if (is.null(mediator_names)) mediator_names <- names(mediator_list)
  if (is.list(mediator_names)) mediator_names <- unlist(mediator_names, use.names = FALSE)
  stopifnot(length(mediator_names) == length(mediator_list))

  results_df <- data.frame(
    ColumnName    = character(),
    Mediator      = character(),
    path_a        = numeric(),
    path_a_p      = numeric(),
    path_b        = numeric(),
    path_b_p      = numeric(),
    indirect_ab   = numeric(),
    indirect_ab_p = numeric(),
    LL            = numeric(),
    UL            = numeric(),
    direct_c      = numeric(),
    direct_c_p    = numeric(),
    prop.med      = numeric(),
    stringsAsFactors = FALSE
  )

  for (i in seq_along(mediator_list)) {
    m_col   <- names(mediator_list)[i]
    temp    <- data.frame(Y = data[[y_var]], X = data[[x_var]], M = mediator_list[[i]])
    temp    <- na.omit(temp)
    model_m <- lm(M ~ X, data = temp)
    model_y <- lm(Y ~ X + M, data = temp)

    path_a    <- coef(summary(model_m))["X", "Estimate"]
    path_a_p  <- coef(summary(model_m))["X", "Pr(>|t|)"]
    path_b    <- coef(summary(model_y))["M", "Estimate"]
    path_b_p  <- coef(summary(model_y))["M", "Pr(>|t|)"]
    path_cp   <- coef(summary(model_y))["X", "Estimate"]
    path_cp_p <- coef(summary(model_y))["X", "Pr(>|t|)"]

    med_out <- mediate(model_m, model_y,
      treat = "X", mediator = "M",
      boot = TRUE, sims = sims
    )

    ie    <- med_out$d0
    ie_p  <- med_out$d0.p
    ci_l  <- med_out$d0.ci[1]
    ci_u  <- med_out$d0.ci[2]
    pm    <- ie / med_out$tau.coef * 100

    results_df <- rbind(results_df, data.frame(
      ColumnName    = m_col,
      Mediator      = mediator_names[i],
      path_a        = path_a,
      path_a_p      = path_a_p,
      path_b        = path_b,
      path_b_p      = path_b_p,
      indirect_ab   = ie,
      indirect_ab_p = ie_p,
      LL            = ci_l,
      UL            = ci_u,
      direct_c      = path_cp,
      direct_c_p    = path_cp_p,
      prop.med      = pm,
      stringsAsFactors = FALSE
    ))
  }

  results_df
}# --- Format raw mediation results as an APA flextable ---
mediation_table_from_results <- function(results_df, selected_mediators = NULL) {
  formatted_df <- data.frame(
    Mediators   = results_df$Mediator,
    path_a      = sprintf("%.2f%s", results_df$path_a,  add_stars(results_df$path_a_p)),
    path_b      = sprintf("%.2f%s", results_df$path_b,  add_stars(results_df$path_b_p)),
    indirect_ab = sprintf("%.2f%s", results_df$indirect_ab, add_stars(results_df$indirect_ab_p)),
    LL          = sprintf("%.2f",   results_df$LL),
    UL          = sprintf("%.2f",   results_df$UL),
    direct_c    = sprintf("%.2f%s", results_df$direct_c, add_stars(results_df$direct_c_p)),
    prop.med    = sprintf("%.2f%%", results_df$prop.med),
    stringsAsFactors = FALSE
  )

  sub_hdr <- c(
    "Mediators",
    "X -> M", "M -> Y\n(given X)",
    "Effect", "95% CI LL", "95% CI UL",
    "X -> Y\n(given M)", "Proportion\nMediated"
  )

  spanner <- c(
    " " = 1, "Path a" = 1, "Path b" = 1,
    "Indirect (ab)" = 3, "Direct c'" = 1, "Full Model" = 1
  )

  if (!is.null(selected_mediators)) {
    formatted_df$Selected <- ifelse(results_df$ColumnName %in% selected_mediators, "Yes", "No")
    sub_hdr <- c(sub_hdr, "Selected for SEM")
    spanner <- c(spanner, " " = 1)
  }

  make_apa_flextable(formatted_df, col_names = sub_hdr, spanner = spanner)
}


# --- Individual mediation table (Backwards-compatible wrapper) ---
mediation_table <- function(
  data,
  x_var,
  y_var,
  mediator_list,
  mediator_names = NULL,
  sims = 5000,
  selected_mediators = NULL
) {
  raw_results <- run_mediation_analyses(data, x_var, y_var, mediator_list, mediator_names, sims)
  mediation_table_from_results(raw_results, selected_mediators = selected_mediators)
}


# --- Select one representative mediator per cluster from pre-computed raw mediation results ---
# results_df: data frame output from run_mediation_analyses()
# data      : the data frame containing the raw core variables (e.g. s1_core)
# exclude   : optional vector of column names to exclude
# Returns a list: list(mediators = data[, selected_cols], names = selected_display_names)
select_representatives <- function(results_df, data, exclude = NULL) {
  # 1. Filter for significant bootstrap indirect effect (indirect_ab_p < 0.05)
  sig_res <- results_df[results_df$indirect_ab_p < 0.05, ]

  if (!is.null(exclude)) {
    sig_res <- sig_res[!(sig_res$ColumnName %in% exclude), ]
  }

  if (nrow(sig_res) == 0) {
    return(list(
      mediators = data[, character(0), drop = FALSE],
      names     = character(0)
    ))
  }

  # 2. Map ColumnName to clusters (using MEDIATOR_CLUSTERS)
  sig_res$Cluster <- MEDIATOR_CLUSTERS[sig_res$ColumnName]

  # 3. For each cluster, pick the one with highest absolute proportion mediated
  selected_rows <- do.call(rbind, lapply(split(sig_res, sig_res$Cluster), function(sub_df) {
    sub_df[which.max(abs(sub_df$prop.med)), ]
  }))

  # Sort by cluster for consistency
  selected_rows <- selected_rows[order(selected_rows$Cluster), ]

  list(
    mediators = data[, selected_rows$ColumnName, drop = FALSE],
    names     = selected_rows$Mediator
  )
}


# --- APA correlation matrix (lower triangle) ---
apa_cor_table <- function(data, var_names = NULL) {
  is_num   <- sapply(data, is.numeric)
  num_data <- data[, is_num, drop = FALSE]
  n_vars   <- ncol(num_data)

  if (is.null(var_names)) {
    var_names <- names(num_data)
  } else {
    stopifnot(length(var_names) == ncol(data))
    var_names <- var_names[is_num]
  }

  mat <- matrix("", nrow = n_vars, ncol = n_vars)
  rownames(mat) <- var_names
  colnames(mat) <- var_names

  for (i in 1:n_vars) {
    for (j in 1:n_vars) {
      if (i == j) {
        mat[i, j] <- "\u2014"
      } else if (i > j) {
        ct <- cor.test(num_data[[i]], num_data[[j]], method = "pearson")
        r  <- sprintf("%.2f", ct$estimate)
        cl <- sprintf("%.2f", ct$conf.int[1])
        cu <- sprintf("%.2f", ct$conf.int[2])
        mat[i, j] <- paste0(r, add_stars(ct$p.value), " [", cl, ", ", cu, "]")
      }
    }
  }

  df <- as.data.frame(mat, stringsAsFactors = FALSE)
  df <- data.frame(
    Variable = var_names, df, row.names = NULL,
    check.names = FALSE
  )

  make_apa_flextable(df)
}


filter_sig_mediators <- function(data, predictor, mediator_df, mediator_names,
                                 adj_vars = c(
                                   "Political", "Age", "Income",
                                   "Education", "SES"
                                 )) {
  # Drop any column whose name matches the predictor itself
  not_self      <- names(mediator_df) != predictor
  mediator_df   <- mediator_df[, not_self, drop = FALSE]
  mediator_names <- mediator_names[not_self]

  n_tests <- ncol(mediator_df)
  threshold <- 0.05 / n_tests

  keep <- vapply(seq_along(mediator_df), function(i) {
    m    <- names(mediator_df)[i]
    mod1 <- lm(as.formula(paste0(m, " ~ ", predictor)), data = data)
    p1   <- coef(summary(mod1))[predictor, "Pr(>|t|)"]
    f2   <- paste0(m, " ~ ", predictor, " + ", paste(adj_vars, collapse = " + "))
    mod2 <- lm(as.formula(f2), data = data)
    p2   <- coef(summary(mod2))[predictor, "Pr(>|t|)"]
    p1 < threshold | p2 < threshold
  }, logical(1))

  list(
    mediators = mediator_df[, keep, drop = FALSE],
    names     = mediator_names[keep]
  )
}


# ── Extract ALL parameter estimates from a fitted lavaan parallel model ───────
# Returns a tidy data frame with every relationship in the model:
#   - a paths  (predictor → mediators)
#   - b paths  (mediators → outcome)
#   - direct effect  (c')
#   - mediator covariances  (M_i ~~ M_j)
#   - defined indirect effects  (ind1, ind2, …, total_indirect)
#
# Arguments:
#   fit            : fitted lavaan sem object
#   mediator_names : character vector of display names for mediators
#                    (same order as a1…an in the model)
#   predictor_name : display name for predictor variable
#   outcome_name   : display name for outcome variable
#
# Returns: data frame with columns
#   Path, b, beta, SE, CI_Lower, CI_Upper, p
extract_all_estimates <- function(fit, mediator_names,
                                   predictor_name = "Predictor",
                                   outcome_name   = "Outcome") {
  pe  <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  std <- standardizedSolution(fit)
  pe$beta <- std$est.std[match(
    paste(pe$lhs, pe$op, pe$rhs),
    paste(std$lhs, std$op, std$rhs)
  )]

  n <- length(mediator_names)
  med_vars <- character(n)
  for (i in seq_len(n)) {
    row_i <- pe[pe$label == paste0("a", i), ]
    if (nrow(row_i) > 0) med_vars[i] <- row_i$lhs[1]
  }

  fmt <- function(x, d = 3) formatC(round(x, d), format = "f", digits = d)

  rows <- list()

  # ── a paths ──
  for (i in seq_len(n)) {
    r <- pe[pe$label == paste0("a", i), ]
    if (nrow(r) == 0) next
    rows[[length(rows) + 1]] <- data.frame(
      Path     = paste0(predictor_name, " \u2192 ", mediator_names[i]),
      Label    = paste0("a", i),
      b        = fmt(r$est[1]),
      beta     = fmt(r$beta[1]),
      SE       = fmt(r$se[1]),
      CI_Lower = fmt(r$ci.lower[1]),
      CI_Upper = fmt(r$ci.upper[1]),
      p        = apa_p(r$pvalue[1], eq = FALSE),
      stringsAsFactors = FALSE
    )
  }

  # ── b paths ──
  for (i in seq_len(n)) {
    r <- pe[pe$label == paste0("b", i), ]
    if (nrow(r) == 0) next
    rows[[length(rows) + 1]] <- data.frame(
      Path     = paste0(mediator_names[i], " \u2192 ", outcome_name),
      Label    = paste0("b", i),
      b        = fmt(r$est[1]),
      beta     = fmt(r$beta[1]),
      SE       = fmt(r$se[1]),
      CI_Lower = fmt(r$ci.lower[1]),
      CI_Upper = fmt(r$ci.upper[1]),
      p        = apa_p(r$pvalue[1], eq = FALSE),
      stringsAsFactors = FALSE
    )
  }

  # ── direct effect (c') ──
  r <- pe[pe$label == "c_prime", ]
  if (nrow(r) > 0) {
    rows[[length(rows) + 1]] <- data.frame(
      Path     = paste0(predictor_name, " \u2192 ", outcome_name, " (direct)"),
      Label    = "c'",
      b        = fmt(r$est[1]),
      beta     = fmt(r$beta[1]),
      SE       = fmt(r$se[1]),
      CI_Lower = fmt(r$ci.lower[1]),
      CI_Upper = fmt(r$ci.upper[1]),
      p        = apa_p(r$pvalue[1], eq = FALSE),
      stringsAsFactors = FALSE
    )
  }

  # ── mediator covariances ──
  cov_rows <- pe[pe$op == "~~" &
                   pe$lhs %in% med_vars &
                   pe$rhs %in% med_vars &
                   pe$lhs != pe$rhs, ]
  if (nrow(cov_rows) > 0) {
    for (k in seq_len(nrow(cov_rows))) {
      cr  <- cov_rows[k, ]
      lbl <- mediator_names[match(cr$lhs, med_vars)]
      rbl <- mediator_names[match(cr$rhs, med_vars)]
      rows[[length(rows) + 1]] <- data.frame(
        Path     = paste0(lbl, " ~~ ", rbl),
        Label    = paste0(cr$lhs, " ~~ ", cr$rhs),
        b        = fmt(cr$est),
        beta     = fmt(cr$beta),
        SE       = fmt(cr$se),
        CI_Lower = fmt(cr$ci.lower),
        CI_Upper = fmt(cr$ci.upper),
        p        = apa_p(cr$pvalue, eq = FALSE),
        stringsAsFactors = FALSE
      )
    }
  }

  # ── indirect effects ──
  for (i in seq_len(n)) {
    lbl <- paste0("ind", i)
    r <- pe[pe$lhs == lbl & pe$op == ":=", ]
    if (nrow(r) == 0) next
    rows[[length(rows) + 1]] <- data.frame(
      Path     = paste0("Indirect via ", mediator_names[i]),
      Label    = lbl,
      b        = fmt(r$est[1]),
      beta     = fmt(r$beta[1]),
      SE       = fmt(r$se[1]),
      CI_Lower = fmt(r$ci.lower[1]),
      CI_Upper = fmt(r$ci.upper[1]),
      p        = apa_p(r$pvalue[1], eq = FALSE),
      stringsAsFactors = FALSE
    )
  }

  # ── total indirect ──
  r <- pe[pe$lhs == "total_indirect" & pe$op == ":=", ]
  if (nrow(r) > 0) {
    rows[[length(rows) + 1]] <- data.frame(
      Path     = "Total indirect effect",
      Label    = "total",
      b        = fmt(r$est[1]),
      beta     = fmt(r$beta[1]),
      SE       = fmt(r$se[1]),
      CI_Lower = fmt(r$ci.lower[1]),
      CI_Upper = fmt(r$ci.upper[1]),
      p        = apa_p(r$pvalue[1], eq = FALSE),
      stringsAsFactors = FALSE
    )
  }

  do.call(rbind, rows)
}


# ── Format extract_all_estimates() output as an APA flextable ─────────────────
fmt_all_estimates_table <- function(est_df) {
  out <- est_df[, c("Path", "b", "beta", "SE", "CI_Lower", "CI_Upper", "p")]
  names(out) <- c("Path", "b", "\u03b2", "SE", "95% CI LL", "95% CI UL", "p")

  flextable::flextable(out) |>
    flextable::compose(
      j = "b", part = "header",
      value = flextable::as_paragraph(flextable::as_i("b"))
    ) |>
    flextable::compose(
      j = "\u03b2", part = "header",
      value = flextable::as_paragraph(flextable::as_i("\u03b2"))
    ) |>
    flextable::compose(
      j = "p", part = "header",
      value = flextable::as_paragraph(flextable::as_i("p"))
    ) |>
    flextable::align(j = 1, part = "body", align = "left") |>
    flextable::align(j = 2:7, part = "body", align = "center") |>
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


# ── Shared SEM/lavaan model building & extraction helpers ─────────────────────

# --- Build a lavaan parallel mediation model string ---
# predictor     : name of the X variable (string)
# outcome       : name of the Y variable (string)
# mediator_names: character vector of mediator column names
# Returns a lavaan model string ready for sem().
build_parallel_model <- function(predictor, outcome, mediator_names) {
  n  <- length(mediator_names)
  ms <- mediator_names

  # a paths: predictor -> each mediator
  a_lines <- paste0("  ", ms, " ~ a", seq_len(n), " * ", predictor)

  # b paths: each mediator -> outcome, plus direct path
  b_terms <- paste0("b", seq_len(n), " * ", ms, collapse = " +\n                       ")
  b_line  <- paste0(
    "  ", outcome, " ~ ", b_terms,
    " +\n                       c_prime * ", predictor
  )

  # mediator covariances (all pairs)
  cov_lines <- character(0)
  if (n > 1) {
    for (i in 1:(n - 1)) {
      for (j in (i + 1):n) {
        cov_lines <- c(cov_lines, paste0("  ", ms[i], " ~~ ", ms[j]))
      }
    }
  }

  # defined indirect effects and total
  ind_lines  <- paste0("  ind", seq_len(n), " := a", seq_len(n), " * b", seq_len(n))
  total_line <- paste0(
    "  total_indirect := ",
    paste0("ind", seq_len(n), collapse = " + ")
  )

  paste(c(a_lines, b_line, cov_lines, ind_lines, total_line), collapse = "\n")
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
extract_path_coefs <- function(fit, n) {
  pe  <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  std <- standardizedSolution(fit)
  pe$beta <- std$est.std[match(
    paste(pe$lhs, pe$op, pe$rhs),
    paste(std$lhs, std$op, std$rhs)
  )]

  fn <- function(x, d = 2) {
    if (length(x) == 0 || all(is.na(x))) return("--")
    formatC(round(x[1], d), format = "f", digits = d)
  }

  get_by_label <- function(lbl) {
    row <- pe[pe$label == lbl, ]
    if (nrow(row) == 0) return(list(b = "?", beta = "?", lo = "?", hi = "?"))
    list(
      b    = fn(row$est[1]),
      beta = fn(row$beta[1]),
      lo   = fn(row$ci.lower[1]),
      hi   = fn(row$ci.upper[1])
    )
  }

  c(
    setNames(lapply(seq_len(n), function(i) get_by_label(paste0("a", i))),
             paste0("a", seq_len(n))),
    setNames(lapply(seq_len(n), function(i) get_by_label(paste0("b", i))),
             paste0("b", seq_len(n))),
    list(cp = get_by_label("c_prime"))
  )
}


# --- Filter to mediators with a significant bootstrap indirect effect ---
# Takes the output of filter_sig_mediators() (defined in tables.R) and keeps
# only mediators where the bootstrap indirect effect p < alpha (default .05).
# Returns list(mediators, names) with the same structure.
filter_sig_indirect <- function(sig_list, predictor, outcome, data,
                                sims = 5000, alpha = 0.05) {
  med_df  <- sig_list$mediators
  med_nms <- sig_list$names

  keep <- vapply(seq_along(med_df), function(i) {
    tmp <- data.frame(
      Y = data[[outcome]], X = data[[predictor]],
      M = med_df[[i]]
    )
    tmp   <- na.omit(tmp)
    mod_m <- lm(M ~ X, data = tmp)
    mod_y <- lm(Y ~ X + M, data = tmp)
    med   <- mediate(mod_m, mod_y,
      treat = "X", mediator = "M",
      boot = TRUE, sims = sims
    )
    med$d0.p < alpha
  }, logical(1))

  list(
    mediators = med_df[, keep, drop = FALSE],
    names     = med_nms[keep]
  )
}


# --- Select one representative mediator per cluster ---
# Uses MEDIATOR_CLUSTERS (defined in data-loading.R) to map columns to clusters.
# Within each cluster, selects the mediator with the highest proportion mediated
# (|indirect / total|) from mediate() — consistent with filter_sig_indirect().
# Optional exclude: character vector of column names to drop before selection.
# Returns list(mediators, names).
pick_cluster_reps <- function(ind_list, predictor, outcome, data,
                              exclude = NULL, sims = 5000) {
  med_df  <- ind_list$mediators
  med_nms <- ind_list$names

  if (!is.null(exclude)) {
    keep_idx <- !(names(med_df) %in% exclude)
    med_df   <- med_df[, keep_idx, drop = FALSE]
    med_nms  <- med_nms[keep_idx]
  }

  col_names <- names(med_df)
  clusters  <- MEDIATOR_CLUSTERS[col_names] # named vector from data-loading.R

  selected <- c()
  for (cl in unique(clusters)) {
    idx <- which(clusters == cl)
    if (length(idx) == 1L) {
      selected <- c(selected, idx)
    } else {
      pms <- sapply(idx, function(i) {
        tmp <- data.frame(
          Y = data[[outcome]], X = data[[predictor]],
          M = med_df[[i]]
        )
        tmp   <- na.omit(tmp)
        mod_m <- lm(M ~ X, data = tmp)
        mod_y <- lm(Y ~ X + M, data = tmp)
        med   <- mediate(mod_m, mod_y,
          treat = "X", mediator = "M",
          boot = TRUE, sims = sims
        )
        abs(med$d0 / med$tau.coef) # proportion mediated
      })
      selected <- c(selected, idx[which.max(pms)])
    }
  }

  list(
    mediators = med_df[, selected, drop = FALSE],
    names     = med_nms[selected]
  )
}
