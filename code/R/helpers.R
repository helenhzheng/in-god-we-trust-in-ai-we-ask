# APA formatting helpers and shared ggplot theme
# Requires: R/colors.R, R/packages.R sourced first

# --- Global bootstrap simulation setting ---
# Default for publication: 5000. Set BOOTSTRAP_SIMS <- 50 for fast testing.
if (!exists("BOOTSTRAP_SIMS")) {
  BOOTSTRAP_SIMS <- 5000
}

# --- Strip leading zero for APA 7 (bounded by 1) ---
fmt_no_zero <- function(val, digits = 2) {
  if (is.numeric(val)) {
    str_val <- sprintf(paste0("%.", digits, "f"), val)
  } else {
    str_val <- as.character(val)
  }
  sub("^(-?)0\\.", "\\1.", str_val)
}

# --- APA p-value formatting ---
apa_p <- function(x, eq = TRUE) {
  ifelse(x < .001, "< .001",
    if (eq) paste0("= ", fmt_no_zero(x, 3)) else fmt_no_zero(x, 3)
  )
}

# --- Calculate and format post-hoc correlation power ---
calc_cor_power <- function(cor_test_obj, sig_level = 0.05) {
  n <- cor_test_obj$parameter + 2
  r <- cor_test_obj$estimate
  pwr_val <- pwr::pwr.r.test(n = n, r = r, sig.level = sig_level)$power
  if (pwr_val > 0.99) {
    ">99%"
  } else if (pwr_val > 0.95) {
    ">95%"
  } else {
    sprintf(">%.0f%%", floor(pwr_val * 100))
  }
}

# --- Significance stars ---
add_stars <- function(p) {
  ifelse(is.na(p), "",
    ifelse(p < 0.001, "***",
      ifelse(p < 0.01, "**",
        ifelse(p < 0.05, "*", "")
      )
    )
  )
}

# --- Format correlation test result for inline APA text ---
fmt_cor_apa <- function(cor_test, power_val = NULL) {
  r_str <- fmt_no_zero(cor_test$estimate, 3)
  t_stat <- sprintf("%.2f", cor_test$statistic)
  df <- cor_test$parameter
  p_str <- apa_p(cor_test$p.value)

  res <- paste0("*r* = ", r_str, ", *t* (", df, ") = ", t_stat, ", *p* ", p_str)
  if (!is.null(power_val)) {
    res <- paste0(res, ", ", power_val, " power")
  }
  res
}

# --- Format individual mediation indirect effect for inline text ---
fmt_ind_raw <- function(df, mediator_name, include_ci = TRUE) {
  row <- df[df$Mediator == mediator_name, ]
  if (nrow(row) == 0) {
    return("")
  }
  ci_str <- if (include_ci) {
    paste0(", 95% CI [",
           fmt_no_zero(row$LL, 3), ", ",
           fmt_no_zero(row$UL, 3), "]")
  } else {
    ""
  }
  paste0(
    "*β* = ", fmt_no_zero(row$indirect_ab, 3), ci_str
  )
}

# --- Format specific parallel mediation indirect effect for inline text ---
fmt_para_raw <- function(fit, mediator_index, include_ci = TRUE) {
  pe <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  std <- standardizedSolution(fit)
  lbl <- paste0("ind", mediator_index)

  row_pe <- pe[pe$lhs == lbl & pe$op == ":=", ]
  row_std <- std[std$lhs == lbl & std$op == ":=", ]
  if (nrow(row_pe) == 0 || nrow(row_std) == 0) {
    return("")
  }

  b_val <- sprintf("%.3f", row_pe$est[1])
  beta_val <- fmt_no_zero(row_std$est.std[1], 3)

  ci_str <- if (include_ci) {
    paste0(", 95% CI [",
           sprintf("%.3f", row_pe$ci.lower[1]), ", ",
           sprintf("%.3f", row_pe$ci.upper[1]), "]")
  } else {
    ""
  }
  p_val <- row_pe$pvalue[1]
  p_str <- apa_p(p_val, eq = FALSE)
  p_text <- if (startsWith(p_str, "<") || startsWith(p_str, "=")) paste0("p ", p_str) else paste0("p = ", p_str)

  paste0(
    "*b* = ", b_val, ", *β* = ", beta_val, ci_str, ", *", p_text, "*"
  )
}

# --- Extract parallel mediation model summary statistics ---
extract_parallel_model_summary <- function(fit, x_var, y_var) {
  pe <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95)
  std <- standardizedSolution(fit)

  tie_pe <- pe[pe$lhs == "total_indirect" & pe$op == ":=", ]
  tie_std <- std[std$lhs == "total_indirect" & std$op == ":=", ]
  
  tie_unstd_b <- sprintf("%.3f", tie_pe$est[1])
  tie_beta    <- fmt_no_zero(tie_std$est.std[1], 3)
  tie_ci_l    <- sprintf("%.3f", tie_pe$ci.lower[1])
  tie_ci_u    <- sprintf("%.3f", tie_pe$ci.upper[1])
  tie_p       <- apa_p(tie_pe$pvalue[1], eq = FALSE)

  r2_val <- inspect(fit, "r2")[y_var]
  r2 <- fmt_no_zero(r2_val, 3)
  r2_pct <- formatC(round(r2_val * 100, 1), format = "f", digits = 1)

  cp_pe <- pe[pe$lhs == y_var & pe$rhs == x_var & pe$op == "~", ]
  cp_std <- std[std$lhs == y_var & std$rhs == x_var & std$op == "~", ]
  
  cp_unstd_b <- sprintf("%.3f", cp_pe$est[1])
  cp_beta    <- fmt_no_zero(cp_std$est.std[1], 3)
  cp_ci_l    <- sprintf("%.3f", cp_pe$ci.lower[1])
  cp_ci_u    <- sprintf("%.3f", cp_pe$ci.upper[1])
  cp_p       <- apa_p(cp_pe$pvalue[1], eq = FALSE)

  list(
    r2 = r2, r2_pct = r2_pct,
    tie_b = tie_unstd_b, tie_beta = tie_beta, tie_lo = tie_ci_l, tie_hi = tie_ci_u, tie_p = tie_p,
    cp_b = cp_unstd_b, cp_beta = cp_beta, cp_lo = cp_ci_l, cp_hi = cp_ci_u, cp_p = cp_p
  )
}

# --- Format parallel SEM model fit summary for inline text ---
fmt_parallel_summary_apa <- function(summary_obj, outcome_label = NULL, full = TRUE, include_indirect_ci = TRUE, include_direct_ci = TRUE) {
  var_text <- if (!is.null(outcome_label)) {
    paste0("the variance in ", outcome_label, " ")
  } else {
    "the variance "
  }

  res <- paste0(
    "explained ",
    summary_obj$r2_pct, "% of ", var_text, "(*R²* = ", summary_obj$r2, ")"
  )

  if (full) {
    tie_p_val <- summary_obj$tie_p
    tie_p_str <- if (startsWith(tie_p_val, "<") || startsWith(tie_p_val, "=")) paste0("p ", tie_p_val) else paste0("p = ", tie_p_val)
    
    cp_p_val <- summary_obj$cp_p
    cp_p_str <- if (startsWith(cp_p_val, "<") || startsWith(cp_p_val, "=")) paste0("p ", cp_p_val) else paste0("p = ", cp_p_val)

    tie_ci <- if (include_indirect_ci) {
      paste0(", 95% CI [", summary_obj$tie_lo, ", ", summary_obj$tie_hi, "]")
    } else {
      ""
    }
    
    cp_ci <- if (include_direct_ci) {
      paste0(", 95% CI [", summary_obj$cp_lo, ", ", summary_obj$cp_hi, "]")
    } else {
      ""
    }

    tie_text <- paste0(
      "*b* = ", summary_obj$tie_b,
      ", *β* = ", summary_obj$tie_beta,
      tie_ci,
      ", *", tie_p_str, "*"
    )
    
    cp_text <- paste0(
      "*b* = ", summary_obj$cp_b,
      ", *β* = ", summary_obj$cp_beta,
      cp_ci,
      ", *", cp_p_str, "*"
    )

    res <- paste0(
      res, ", ",
      "with a total indirect effect of ", tie_text,
      " and a direct association of ", cp_text
    )
  }

  res
}

# --- Extract APA-formatted lm coefficients ---
apa_lm_summary <- function(model, predictor, standardized = TRUE) {
  coef_sum <- summary(model)$coefficients
  est <- coef_sum[predictor, "Estimate"]
  se <- coef_sum[predictor, "Std. Error"]
  p_val <- coef_sum[predictor, "Pr(>|t|)"]
  ci <- confint(model)[predictor, ]

  if (standardized) {
    mm <- model.matrix(model)
    sd_y <- sd(model.frame(model)[[1]], na.rm = TRUE)
    if (predictor %in% colnames(mm)) {
      sd_x <- sd(mm[, predictor], na.rm = TRUE)
    } else {
      sd_x <- NA
    }
    if (!is.na(sd_x) && !is.na(sd_y) && sd_y > 0) {
      est <- est * (sd_x / sd_y)
      se <- se * (sd_x / sd_y)
      ci <- ci * (sd_x / sd_y)
    }
  }

  fmt_num <- function(val, d = 3) {
    if (standardized) fmt_no_zero(val, d) else sprintf(paste0("%.", d, "f"), val)
  }

  c(
    Estimate = fmt_num(est, 3),
    SE       = fmt_num(se, 3),
    LL       = fmt_num(ci[1], 3),
    UL       = fmt_num(ci[2], 3),
    p        = apa_p(p_val, eq = FALSE)
  )
}

# --- Format regression model predictor results for inline APA text ---
fmt_lm_apa <- function(model, predictor, standardized = TRUE, include_r2 = TRUE, include_ci = TRUE) {
  sum_info <- apa_lm_summary(model, predictor, standardized = standardized)
  b_label <- if (standardized) "\\beta" else "b"

  p_val <- sum_info["p"]
  p_str <- if (startsWith(p_val, "<")) paste0("p ", p_val) else paste0("p = ", p_val)

  ci_str <- if (include_ci) {
    paste0("$95\\% \\text{ CI } [", sum_info["LL"], ", ", sum_info["UL"], "]$, ")
  } else {
    ""
  }

  res <- paste0(
    "$", b_label, " = ", sum_info["Estimate"], "$, ",
    "$SE = ", sum_info["SE"], "$, ",
    ci_str,
    "$", p_str, "$"
  )

  if (include_r2) {
    adj_r2 <- fmt_no_zero(summary(model)$adj.r.squared, 3)
    res <- paste0(res, ", $\\text{Adjusted } R^2 = ", adj_r2, "$")
  }

  res
}

# --- APA correlation label for ggplot annotations (parsed expression) ---
apa_cor_label <- function(x, y) {
  ct <- cor.test(x, y, method = "pearson")
  r <- sprintf("%.2f", ct$estimate)
  df <- ct$parameter
  p <- apa_p(ct$p.value)
  paste0(
    "italic('r') == ", r,
    " ~ (", df, ") * ', ' * ",
    "italic('p') ~ '", p, "'"
  )
}

# --- Shared APA ggplot theme ---
apa_theme <- theme_classic(base_size = 12) +
  theme(
    text = element_text(family = "serif"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 12),
    strip.text = element_text(size = 12),
    strip.background = element_blank(),
    plot.title = element_text(size = 12, hjust = 0, face = "bold"),
    plot.caption = element_text(size = 12, hjust = 0),
    panel.border = element_blank(),
    axis.text.x = element_text(hjust = 1),
    legend.position = "bottom",
    legend.direction = "horizontal",
    plot.title.position = "plot",
    plot.caption.position = "plot"
  )
