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
  ft <- flextable::flextable(df)
  if ("Predictor" %in% names(df)) {
    ft <- flextable::merge_v(ft, j = "Predictor")
  }
  left_cols <- if ("Predictor" %in% names(df)) 1:2 else 1
  center_cols <- if ("Predictor" %in% names(df)) 3:ncol(df) else 2:ncol(df)

  ft |>
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
    flextable::align(j = left_cols, part = "body", align = "left") |>
    flextable::align(j = center_cols, part = "body", align = "center") |>
    flextable::align(part = "header", align = "center") |>
    flextable::border_remove() |>
    flextable::hline_top(part = "header", border = officer::fp_border(width = 1.5)) |>
    flextable::hline_bottom(part = "header", border = officer::fp_border(width = 1)) |>
    flextable::hline_bottom(part = "body", border = officer::fp_border(width = 1.5)) |>
    flextable::set_table_properties(layout = "autofit", width = 1)
}

# --- Build standard correlation summary data frame ---
build_cor_table <- function(cor_rs_s1, cor_rs_s2, cor_rel_s1, cor_rel_s2, s1_data, s2_data) {
  data.frame(
    Predictor = c("Self-Reported Religiosity", "Self-Reported Religiosity", "Religious Behavior Score", "Religious Behavior Score"),
    Study = c("Study 1", "Study 2", "Study 1", "Study 2"),
    N     = c(nrow(s1_data), nrow(s2_data), nrow(s1_data), nrow(s2_data)),
    r     = fmt_no_zero(c(cor_rel_s1$estimate, cor_rel_s2$estimate,
                          cor_rs_s1$estimate,  cor_rs_s2$estimate), 3),
    t     = sprintf("%.3f", c(cor_rel_s1$statistic, cor_rel_s2$statistic,
                              cor_rs_s1$statistic,  cor_rs_s2$statistic)),
    df    = c(cor_rel_s1$parameter, cor_rel_s2$parameter,
              cor_rs_s1$parameter,  cor_rs_s2$parameter),
    p     = c(apa_p(cor_rel_s1$p.value), apa_p(cor_rel_s2$p.value),
              apa_p(cor_rs_s1$p.value),  apa_p(cor_rs_s2$p.value)),
    check.names = FALSE
  )
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


# --- Regression table: X predicting mediators ---
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
  sims = BOOTSTRAP_SIMS,
  standardize = TRUE
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

    if (standardize) {
      if (is.numeric(temp$Y)) temp$Y <- as.numeric(scale(temp$Y))
      if (is.numeric(temp$X)) temp$X <- as.numeric(scale(temp$X))
      if (is.numeric(temp$M)) temp$M <- as.numeric(scale(temp$M))
    }

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
    path_a      = paste0(fmt_no_zero(results_df$path_a, 3),   add_stars(results_df$path_a_p)),
    path_b      = paste0(fmt_no_zero(results_df$path_b, 3),   add_stars(results_df$path_b_p)),
    indirect_ab = paste0(fmt_no_zero(results_df$indirect_ab, 3), add_stars(results_df$indirect_ab_p)),
    LL          = fmt_no_zero(results_df$LL, 3),
    UL          = fmt_no_zero(results_df$UL, 3),
    direct_c    = paste0(fmt_no_zero(results_df$direct_c, 3), add_stars(results_df$direct_c_p)),
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
  sims = BOOTSTRAP_SIMS,
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


# --- Demographic Summary Table Builder ---
create_demo_summary <- function(dataset, dataset_name) {
  sl <- list()

  # Date, N, Age
  sl$`Data Collection Date` <- get_date_range(dataset)
  sl$`Sample Size (N)` <- nrow(dataset)
  sl$`Age (Mean +/- SD)` <- paste0(
    round(mean(dataset$Age, na.rm = TRUE), 2), " +/- ",
    round(sd(dataset$Age, na.rm = TRUE), 2)
  )

  # Gender
  gc <- dataset %>% group_by(Gender) %>%
    summarise(Count = n(), .groups = "drop") %>%
    mutate(Pct = round((Count / sum(Count)) * 100, 2))
  for (g in c("Woman", "Man", "Other", "Prefer not to disclose")) {
    row <- gc %>% filter(Gender == g)
    sl[[paste0("Gender - ", g)]] <- if (nrow(row) > 0) paste0(row$Count, " (", row$Pct, "%)") else "0 (0%)"
  }

  # SES
  sl$`SES (1-10) (Mean +/- SD)` <- paste0(
    round(mean(dataset$SES, na.rm = TRUE), 2), " +/- ",
    round(sd(dataset$SES, na.rm = TRUE), 2)
  )

  # Political
  sl$`Political Leaning (1-7) (Mean +/- SD)` <- paste0(
    round(mean(dataset$Political_overall, na.rm = TRUE), 2), " +/- ",
    round(sd(dataset$Political_overall, na.rm = TRUE), 2)
  )

  # Race/Ethnicity
  race_cols <- dataset %>% dplyr::select(matches("^Race_Ethnicity_\\d+$")) %>% names()
  if (length(race_cols) > 0) {
    rs <- dataset %>%
      dplyr::select(all_of(race_cols)) %>%
      rowwise() %>%
      mutate(
        race_count = sum(c_across(all_of(race_cols)) == 1, na.rm = TRUE),
        Race = case_when(
          race_count == 0 ~ "Did not answer",
          race_count > 1 ~ "Multirace",
          TRUE ~ {
            idx <- which(c_across(all_of(race_cols)) == 1)
            if (length(idx) == 1) RACE_MAP[idx] else "Did not answer"
          }
        )
      ) %>%
      ungroup() %>%
      dplyr::select(Race) %>%
      group_by(Race) %>%
      summarize(Count = n(), .groups = "drop") %>%
      mutate(Pct = round((Count / sum(Count)) * 100, 2))

    for (r in c(RACE_MAP, "Multirace", "Did not answer")) {
      row <- rs %>% filter(Race == r)
      sl[[paste0("Race - ", r)]] <- if (nrow(row) > 0) paste0(row$Count, " (", row$Pct, "%)") else "0 (0%)"
    }
  }

  # Faith
  faith_cols <- dataset %>% dplyr::select(matches("^Faith_\\d+$")) %>% names()
  if (length(faith_cols) > 0) {
    fs <- dataset %>%
      dplyr::select(all_of(faith_cols)) %>%
      rowwise() %>%
      mutate(
        faith_count = sum(c_across(all_of(faith_cols)) == 1, na.rm = TRUE),
        Faith = case_when(
          faith_count == 0 ~ "Did not answer",
          faith_count > 1 ~ "Multifaith",
          TRUE ~ {
            idx <- which(c_across(all_of(faith_cols)) == 1)
            if (length(idx) == 1) FAITH_MAP[idx] else "Did not answer"
          }
        )
      ) %>%
      ungroup() %>%
      dplyr::select(Faith) %>%
      group_by(Faith) %>%
      summarize(Count = n(), .groups = "drop") %>%
      mutate(Pct = round((Count / sum(Count)) * 100, 2))

    for (f in c(FAITH_MAP, "Multifaith", "Did not answer")) {
      row <- fs %>% filter(Faith == f)
      sl[[paste0("Faith - ", f)]] <- if (nrow(row) > 0) paste0(row$Count, " (", row$Pct, "%)") else "0 (0%)"
    }
  }

  result <- data.frame(Characteristic = names(sl), Value = unlist(sl), row.names = NULL)
  names(result)[2] <- dataset_name
  return(result)
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

  fmt_std   <- function(x, d = 3) fmt_no_zero(x, d)
  fmt_unstd <- function(x, d = 3) {
    if (length(x) == 0 || is.na(x[1])) return("")
    sprintf("%.3f", x[1])
  }

  rows <- list()

  # ── a paths ──
  for (i in seq_len(n)) {
    r <- pe[pe$label == paste0("a", i), ]
    if (nrow(r) == 0) next
    rows[[length(rows) + 1]] <- data.frame(
      Path     = paste0(predictor_name, " \u2192 ", mediator_names[i]),
      Label    = paste0("a", i),
      b        = fmt_unstd(r$est[1]),
      beta     = fmt_std(r$beta[1]),
      SE       = fmt_unstd(r$se[1]),
      CI_Lower = fmt_unstd(r$ci.lower[1]),
      CI_Upper = fmt_unstd(r$ci.upper[1]),
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
      b        = fmt_unstd(r$est[1]),
      beta     = fmt_std(r$beta[1]),
      SE       = fmt_unstd(r$se[1]),
      CI_Lower = fmt_unstd(r$ci.lower[1]),
      CI_Upper = fmt_unstd(r$ci.upper[1]),
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
      b        = fmt_unstd(r$est[1]),
      beta     = fmt_std(r$beta[1]),
      SE       = fmt_unstd(r$se[1]),
      CI_Lower = fmt_unstd(r$ci.lower[1]),
      CI_Upper = fmt_unstd(r$ci.upper[1]),
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
        b        = fmt_unstd(cr$est),
        beta     = fmt_std(cr$beta),
        SE       = fmt_unstd(cr$se),
        CI_Lower = fmt_unstd(cr$ci.lower),
        CI_Upper = fmt_unstd(cr$ci.upper),
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
      b        = fmt_unstd(r$est[1]),
      beta     = fmt_std(r$beta[1]),
      SE       = fmt_unstd(r$se[1]),
      CI_Lower = fmt_unstd(r$ci.lower[1]),
      CI_Upper = fmt_unstd(r$ci.upper[1]),
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
      b        = fmt_unstd(r$est[1]),
      beta     = fmt_std(r$beta[1]),
      SE       = fmt_unstd(r$se[1]),
      CI_Lower = fmt_unstd(r$ci.lower[1]),
      CI_Upper = fmt_unstd(r$ci.upper[1]),
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

  fmt_std   <- function(x, d = 3) fmt_no_zero(x, d)
  fmt_unstd <- function(x, d = 3) {
    if (length(x) == 0 || all(is.na(x))) return("--")
    sprintf("%.3f", x[1])
  }

  get_by_label <- function(lbl) {
    row <- pe[pe$label == lbl, ]
    if (nrow(row) == 0) return(list(b = "?", beta = "?", lo = "?", hi = "?"))
    list(
      b    = fmt_unstd(row$est[1]),
      beta = fmt_std(row$beta[1]),
      lo   = fmt_unstd(row$ci.lower[1]),
      hi   = fmt_unstd(row$ci.upper[1])
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


# --- Standardised Moderation Table Helper ---
make_moderation_table <- function(mod1, mod2, pred_name, mod1_name, mod2_name, note_label = "Study 2 only.") {
  mod_sum1 <- summary(mod1)
  mod_sum2 <- summary(mod2)
  ci1 <- confint(mod1)
  ci2 <- confint(mod2)

  get_coef_row <- function(coefs, ci, label, term_name) {
    data.frame(
      Parameter = term_name,
      b = sprintf("%.3f", coefs[label, "Estimate"]),
      SE = sprintf("%.3f", coefs[label, "Std. Error"]),
      CI_Lower = sprintf("%.3f", ci[label, 1]),
      CI_Upper = sprintf("%.3f", ci[label, 2]),
      t = sprintf("%.3f", coefs[label, "t value"]),
      p = apa_p(coefs[label, "Pr(>|t|)"], eq = FALSE),
      stringsAsFactors = FALSE
    )
  }
  
  coef_names1 <- rownames(coef(mod_sum1))
  coef_names2 <- rownames(coef(mod_sum2))
  
  pred_var1 <- coef_names1[2]
  mod_var1  <- coef_names1[3]
  int_var1  <- coef_names1[4]
  
  pred_var2 <- coef_names2[2]
  mod_var2  <- coef_names2[3]
  int_var2  <- coef_names2[4]
  
  tbl_mod1 <- rbind(
    get_coef_row(coef(mod_sum1), ci1, "(Intercept)", "Constant"),
    get_coef_row(coef(mod_sum1), ci1, pred_var1, paste0(pred_name, " (X)")),
    get_coef_row(coef(mod_sum1), ci1, mod_var1, paste0(mod1_name, " (W)")),
    get_coef_row(coef(mod_sum1), ci1, int_var1, "X × W")
  )
  
  tbl_mod1 <- rbind(
    tbl_mod1,
    data.frame(Parameter = "R²", b = sprintf("%.3f", mod_sum1$r.squared), SE = "", CI_Lower = "", CI_Upper = "", t = "", p = "", stringsAsFactors = FALSE),
    data.frame(Parameter = "Adjusted R²", b = sprintf("%.3f", mod_sum1$adj.r.squared), SE = "", CI_Lower = "", CI_Upper = "", t = "", p = "", stringsAsFactors = FALSE)
  )
  
  tbl_mod2 <- rbind(
    get_coef_row(coef(mod_sum2), ci2, "(Intercept)", "Constant"),
    get_coef_row(coef(mod_sum2), ci2, pred_var2, paste0(pred_name, " (X)")),
    get_coef_row(coef(mod_sum2), ci2, mod_var2, paste0(mod2_name, " (W)")),
    get_coef_row(coef(mod_sum2), ci2, int_var2, "X × W")
  )
  
  tbl_mod2 <- rbind(
    tbl_mod2,
    data.frame(Parameter = "R²", b = sprintf("%.3f", mod_sum2$r.squared), SE = "", CI_Lower = "", CI_Upper = "", t = "", p = "", stringsAsFactors = FALSE),
    data.frame(Parameter = "Adjusted R²", b = sprintf("%.3f", mod_sum2$adj.r.squared), SE = "", CI_Lower = "", CI_Upper = "", t = "", p = "", stringsAsFactors = FALSE)
  )
  
  q4_tbl <- rbind(
    data.frame(Model = paste0("Model 1: Moderator = ", mod1_name), tbl_mod1, stringsAsFactors = FALSE),
    data.frame(Model = paste0("Model 2: Moderator = ", mod2_name), tbl_mod2, stringsAsFactors = FALSE)
  )
  
  f_stat1 <- mod_sum1$fstatistic
  f_p1 <- pf(f_stat1[1], f_stat1[2], f_stat1[3], lower.tail = FALSE)
  f_stat2 <- mod_sum2$fstatistic
  f_p2 <- pf(f_stat2[1], f_stat2[2], f_stat2[3], lower.tail = FALSE)
  
  n_obs <- sum(mod_sum1$df[1:2]) + 1
  
  note_text <- sprintf(
    "Model 1: R² = %.3f, Adj. R² = %.3f, F(%.0f, %.0f) = %.3f, p %s. Model 2: R² = %.3f, Adj. R² = %.3f, F(%.0f, %.0f) = %.3f, p %s. %s (N = %.0f).",
    mod_sum1$r.squared, mod_sum1$adj.r.squared, f_stat1[2], f_stat1[3], f_stat1[1], apa_p(f_p1),
    mod_sum2$r.squared, mod_sum2$adj.r.squared, f_stat2[2], f_stat2[3], f_stat2[1], apa_p(f_p2),
    note_label, n_obs
  )
  
  ft <- flextable::as_grouped_data(q4_tbl, groups = "Model") |>
    flextable::as_flextable() |>
    flextable::compose(j = "b", part = "header", value = flextable::as_paragraph(flextable::as_i("b"))) |>
    flextable::compose(j = "SE", part = "header", value = flextable::as_paragraph(flextable::as_i("SE"))) |>
    flextable::compose(j = "CI_Lower", part = "header", value = flextable::as_paragraph("95% CI LL")) |>
    flextable::compose(j = "CI_Upper", part = "header", value = flextable::as_paragraph("95% CI UL")) |>
    flextable::compose(j = "t", part = "header", value = flextable::as_paragraph(flextable::as_i("t"))) |>
    flextable::compose(j = "p", part = "header", value = flextable::as_paragraph(flextable::as_i("p"))) |>
    flextable::align(j = 1, part = "body", align = "left") |>
    flextable::align(j = 2:7, part = "body", align = "center") |>
    flextable::align(part = "header", align = "center") |>
    flextable::border_remove() |>
    flextable::hline_top(part = "header", border = officer::fp_border(width = 1.5)) |>
    flextable::hline_bottom(part = "header", border = officer::fp_border(width = 1)) |>
    flextable::hline_bottom(part = "body", border = officer::fp_border(width = 1.5)) |>
    flextable::add_footer_lines(note_text) |>
    flextable::set_table_properties(layout = "autofit", width = 1)
  
  ft
}

