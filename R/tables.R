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
    if (display %in% c("b", "p", "SE")) {
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
    "Study", "b", "SE", "95% CI LL", "95% CI UL", "p",
    "b", "SE", "95% CI LL", "95% CI UL", "p"
  )
  spanner <- c(" " = 1, "Model 1" = 5, "Model 2" = 5)

  make_apa_flextable(reg_df, col_names = sub_hdr, spanner = spanner)
}


# --- Regression table: X predicting mediators ---
regression_table <- function(
  data,
  x_var,
  mediator_list,
  mediator_names = NULL,
  adjustment_vars = c("Political", "Age", "Income", "Education", "SES")
) {
  if (is.null(mediator_names)) mediator_names <- names(mediator_list)
  if (is.list(mediator_names)) mediator_names <- unlist(mediator_names, use.names = FALSE)
  stopifnot(length(mediator_names) == length(mediator_list))

  table_rows <- list()
  for (i in seq_along(mediator_list)) {
    m       <- names(mediator_list)[i]
    display <- mediator_names[i]
    mod1    <- lm(as.formula(paste0(m, " ~ ", x_var)), data = data)
    row1    <- apa_lm_summary(mod1, x_var)
    names(row1) <- paste("Model1", names(row1), sep = "_")
    adj_f   <- paste(m, "~", x_var, "+", paste(adjustment_vars, collapse = " + "))
    mod2    <- lm(as.formula(adj_f), data = data)
    row2    <- apa_lm_summary(mod2, x_var)
    names(row2) <- paste("Model2", names(row2), sep = "_")
    table_rows[[display]] <- c(row1, row2)
  }

  results <- as.data.frame(do.call(rbind, table_rows))
  results <- data.frame(
    Mediator = rownames(results), results,
    row.names = NULL, stringsAsFactors = FALSE
  )

  sub_hdr <- c(
    "Study", "b", "SE", "95% CI LL", "95% CI UL", "p",
    "b", "SE", "95% CI LL", "95% CI UL", "p"
  )

  spanner <- c(" " = 1, "Model 1" = 5, "Model 2" = 5)

  make_apa_flextable(results, col_names = sub_hdr, spanner = spanner)
}


# --- Individual mediation table ---
mediation_table <- function(
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
    Mediators = character(), path_a = character(), path_b = character(),
    indirect_ab = character(), LL = character(), UL = character(),
    direct_c = character(), prop.med = character(),
    stringsAsFactors = FALSE
  )

  for (i in seq_along(mediator_list)) {
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
      Mediators   = mediator_names[i],
      path_a      = sprintf("%.2f%s", path_a,  add_stars(path_a_p)),
      path_b      = sprintf("%.2f%s", path_b,  add_stars(path_b_p)),
      indirect_ab = sprintf("%.2f%s", ie,      add_stars(ie_p)),
      LL          = sprintf("%.2f",   ci_l),
      UL          = sprintf("%.2f",   ci_u),
      direct_c    = sprintf("%.2f%s", path_cp, add_stars(path_cp_p)),
      prop.med    = sprintf("%.2f%%", pm),
      stringsAsFactors = FALSE
    ))
  }

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

  make_apa_flextable(results_df, col_names = sub_hdr, spanner = spanner)
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


# --- Filter mediators significantly predicted by a given predictor ---
# Used in question3.qmd and supplementary.qmd.
# Returns list(mediators = df_subset, names = character_subset)
filter_sig_mediators <- function(data, predictor, mediator_df, mediator_names,
                                 adj_vars = c(
                                   "Political", "Age", "Income",
                                   "Education", "SES"
                                 )) {
  # Drop any column whose name matches the predictor itself
  not_self      <- names(mediator_df) != predictor
  mediator_df   <- mediator_df[, not_self, drop = FALSE]
  mediator_names <- mediator_names[not_self]

  keep <- vapply(seq_along(mediator_df), function(i) {
    m    <- names(mediator_df)[i]
    mod1 <- lm(as.formula(paste0(m, " ~ ", predictor)), data = data)
    p1   <- coef(summary(mod1))[predictor, "Pr(>|t|)"]
    f2   <- paste0(m, " ~ ", predictor, " + ", paste(adj_vars, collapse = " + "))
    mod2 <- lm(as.formula(f2), data = data)
    p2   <- coef(summary(mod2))[predictor, "Pr(>|t|)"]
    p1 < .05 | p2 < .05
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
