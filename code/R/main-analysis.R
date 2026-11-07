# Main Analysis Calculations for Religiosity and AI Moral Advice Project
# Sourced by manuscript_clean.qmd. Assumes other helper files (helpers.R, tables.R, plots.R, etc.) are sourced first.

# --- Caching Mechanism ---
cache_file <- "R/main-analysis.RData"
analysis_deps <- c(
  "R/main-analysis.R",
  "R/data-loading.R",
  "R/helpers.R",
  "R/tables.R",
  "R/plots.R",
  "R/supplementary.R",
  "Data Collection/P1.csv",
  "Data Collection/P2.csv",
  "Data Collection/Study1.csv",
  "Data Collection/Study2.csv"
)

is_cache_valid <- function(cache_file, deps, target_sims) {
  if (!file.exists(cache_file)) {
    return(FALSE)
  }
  cache_time <- file.mtime(cache_file)
  for (dep in deps) {
    if (file.exists(dep) && file.mtime(dep) > cache_time) {
      return(FALSE)
    }
  }
  temp_env <- new.env()
  tryCatch(
    {
      load(cache_file, envir = temp_env)
      if (is.null(temp_env$CACHED_BOOTSTRAP_SIMS) || temp_env$CACHED_BOOTSTRAP_SIMS != target_sims) {
        return(FALSE)
      }
      return(TRUE)
    },
    error = function(e) {
      return(FALSE)
    }
  )
}

if (!exists("BOOTSTRAP_SIMS")) {
  BOOTSTRAP_SIMS <- 5000
}

if (is_cache_valid(cache_file, analysis_deps, BOOTSTRAP_SIMS)) {
  message("Loading main analysis from cache (", cache_file, ")...")
  load(cache_file, envir = .GlobalEnv)
} else {
  message("Running main analysis (this may take a few minutes)...")
  set.seed(42)

  # ── 1. Bivariate Correlations ────────────────────────────────────────────────
  # Standardized Order: rel_freq, rs_freq, rel_int, rs_int
  correlation_rel_freq_s1 <- cor.test(s1_core$Religiosity, s1_core$AI_Moral_Frequency)
  correlation_rel_freq_s2 <- cor.test(s2_core$Religiosity, s2_core$AI_Moral_Frequency)

  correlation_rs_freq_s1 <- cor.test(s1_core$R_Score, s1_core$AI_Moral_Frequency)
  correlation_rs_freq_s2 <- cor.test(s2_core$R_Score, s2_core$AI_Moral_Frequency)

  correlation_rel_int_s1 <- cor.test(s1_core$Religiosity, s1_core$AI_Moral_Interest)
  correlation_rel_int_s2 <- cor.test(s2_core$Religiosity, s2_core$AI_Moral_Interest)

  correlation_rs_int_s1 <- cor.test(s1_core$R_Score, s1_core$AI_Moral_Interest)
  correlation_rs_int_s2 <- cor.test(s2_core$R_Score, s2_core$AI_Moral_Interest)

  # Pre-computed correlation summary data frames for tables
  table_correlation_freq <- build_cor_table(
    correlation_rs_freq_s1, correlation_rs_freq_s2,
    correlation_rel_freq_s1, correlation_rel_freq_s2,
    s1_core, s2_core
  )

  table_correlation_int <- build_cor_table(
    correlation_rs_int_s1, correlation_rs_int_s2,
    correlation_rel_int_s1, correlation_rel_int_s2,
    s1_core, s2_core
  )

  # Post-hoc correlation power calculations for inline prose
  power_correlation_rel_freq_s1 <- calc_cor_power(correlation_rel_freq_s1)
  power_correlation_rel_freq_s2 <- calc_cor_power(correlation_rel_freq_s2)
  power_correlation_rs_freq_s1 <- calc_cor_power(correlation_rs_freq_s1)
  power_correlation_rs_freq_s2 <- calc_cor_power(correlation_rs_freq_s2)

  # ── 2. Direct Regressions (Model 1 Simple & Model 2 Multiple Paired) ─────────
  # Standardized Order: rel_freq, rs_freq, rel_int, rs_int

  # 1. rel_freq
  regression_rel_freq_s1_simple <- lm(AI_Moral_Frequency ~ Religiosity, data = s1_core)
  regression_rel_freq_s1 <- lm(AI_Moral_Frequency ~ Religiosity + Political + Age + Income + Education + SES, data = s1_core)

  regression_rel_freq_s2_simple <- lm(AI_Moral_Frequency ~ Religiosity, data = s2_core)
  regression_rel_freq_s2 <- lm(AI_Moral_Frequency ~ Religiosity + Political + Age + Income + Education + SES, data = s2_core)

  # 2. rs_freq
  regression_rs_freq_s1_simple <- lm(AI_Moral_Frequency ~ R_Score, data = s1_core)
  regression_rs_freq_s1 <- lm(AI_Moral_Frequency ~ R_Score + Political + Age + Income + Education + SES, data = s1_core)

  regression_rs_freq_s2_simple <- lm(AI_Moral_Frequency ~ R_Score, data = s2_core)
  regression_rs_freq_s2 <- lm(AI_Moral_Frequency ~ R_Score + Political + Age + Income + Education + SES, data = s2_core)

  # 3. rel_int
  regression_rel_int_s1_simple <- lm(AI_Moral_Interest ~ Religiosity, data = s1_core)
  regression_rel_int_s1 <- lm(AI_Moral_Interest ~ Religiosity + Political + Age + Income + Education + SES, data = s1_core)

  regression_rel_int_s2_simple <- lm(AI_Moral_Interest ~ Religiosity, data = s2_core)
  regression_rel_int_s2 <- lm(AI_Moral_Interest ~ Religiosity + Political + Age + Income + Education + SES, data = s2_core)

  # 4. rs_int
  regression_rs_int_s1_simple <- lm(AI_Moral_Interest ~ R_Score, data = s1_core)
  regression_rs_int_s1 <- lm(AI_Moral_Interest ~ R_Score + Political + Age + Income + Education + SES, data = s1_core)

  regression_rs_int_s2_simple <- lm(AI_Moral_Interest ~ R_Score, data = s2_core)
  regression_rs_int_s2 <- lm(AI_Moral_Interest ~ R_Score + Political + Age + Income + Education + SES, data = s2_core)

  # Pairs formatted for make_study_reg_table() (Model 1 & Model 2 side-by-side)
  reg_rows_rel_freq <- list(
    "Study 1" = c(apa_lm_summary(regression_rel_freq_s1_simple, "Religiosity"), apa_lm_summary(regression_rel_freq_s1, "Religiosity")),
    "Study 2" = c(apa_lm_summary(regression_rel_freq_s2_simple, "Religiosity"), apa_lm_summary(regression_rel_freq_s2, "Religiosity"))
  )

  reg_rows_rs_freq <- list(
    "Study 1" = c(apa_lm_summary(regression_rs_freq_s1_simple, "R_Score"), apa_lm_summary(regression_rs_freq_s1, "R_Score")),
    "Study 2" = c(apa_lm_summary(regression_rs_freq_s2_simple, "R_Score"), apa_lm_summary(regression_rs_freq_s2, "R_Score"))
  )

  reg_rows_rel_int <- list(
    "Study 1" = c(apa_lm_summary(regression_rel_int_s1_simple, "Religiosity"), apa_lm_summary(regression_rel_int_s1, "Religiosity")),
    "Study 2" = c(apa_lm_summary(regression_rel_int_s2_simple, "Religiosity"), apa_lm_summary(regression_rel_int_s2, "Religiosity"))
  )

  reg_rows_rs_int <- list(
    "Study 1" = c(apa_lm_summary(regression_rs_int_s1_simple, "R_Score"), apa_lm_summary(regression_rs_int_s1, "R_Score")),
    "Study 2" = c(apa_lm_summary(regression_rs_int_s2_simple, "R_Score"), apa_lm_summary(regression_rs_int_s2, "R_Score"))
  )

  # ── 3. Candidate Mediator Regressions (Path-A Screening Results) ─────────────
  path_a_table_rel_s1 <- regression_table(s1_core, "Religiosity", s1_mediators, S1_MEDIATOR_NAMES)
  path_a_table_rel_s2 <- regression_table(s2_core, "Religiosity", s2_mediators, S2_MEDIATOR_NAMES)

  path_a_table_rs_s1 <- regression_table(s1_core, "R_Score", s1_mediators, S1_MEDIATOR_NAMES)
  path_a_table_rs_s2 <- regression_table(s2_core, "R_Score", s2_mediators, S2_MEDIATOR_NAMES)

  # ── 4. Individual Mediations (Bootstrapped with Internal Standardization) ─────
  # Step 1: Filter mediators significant on Path A under Bonferroni correction
  path_a_sig_rel_s1 <- filter_sig_mediators(s1_core, "Religiosity", s1_mediators, S1_MEDIATOR_NAMES)
  path_a_sig_rel_s2 <- filter_sig_mediators(s2_core, "Religiosity", s2_mediators, S2_MEDIATOR_NAMES)

  path_a_sig_rs_s1 <- filter_sig_mediators(s1_core, "R_Score", s1_mediators, S1_MEDIATOR_NAMES)
  path_a_sig_rs_s2 <- filter_sig_mediators(s2_core, "R_Score", s2_mediators, S2_MEDIATOR_NAMES)

  # Step 2: 5,000 bootstrap individual mediations (standardize = TRUE internally)
  # Standardized Order: rel_freq, rs_freq, rel_int, rs_int

  # 1. rel_freq
  ind_mediation_rel_freq_s1 <- run_mediation_analyses(s1_core, "Religiosity", "AI_Moral_Frequency", as.list(path_a_sig_rel_s1$mediators), path_a_sig_rel_s1$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  ind_mediation_rel_freq_s2 <- run_mediation_analyses(s2_core, "Religiosity", "AI_Moral_Frequency", as.list(path_a_sig_rel_s2$mediators), path_a_sig_rel_s2$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  rep_mediators_rel_freq_s1 <- select_representatives(ind_mediation_rel_freq_s1, s1_core)
  rep_mediators_rel_freq_s2 <- select_representatives(ind_mediation_rel_freq_s2, s2_core)

  # 2. rs_freq
  ind_mediation_rs_freq_s1 <- run_mediation_analyses(s1_core, "R_Score", "AI_Moral_Frequency", as.list(path_a_sig_rs_s1$mediators), path_a_sig_rs_s1$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  ind_mediation_rs_freq_s2 <- run_mediation_analyses(s2_core, "R_Score", "AI_Moral_Frequency", as.list(path_a_sig_rs_s2$mediators), path_a_sig_rs_s2$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  rep_mediators_rs_freq_s1 <- select_representatives(ind_mediation_rs_freq_s1, s1_core)
  rep_mediators_rs_freq_s2 <- select_representatives(ind_mediation_rs_freq_s2, s2_core)

  # 3. rel_int
  ind_mediation_rel_int_s1 <- run_mediation_analyses(s1_core, "Religiosity", "AI_Moral_Interest", as.list(path_a_sig_rel_s1$mediators), path_a_sig_rel_s1$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  ind_mediation_rel_int_s2 <- run_mediation_analyses(s2_core, "Religiosity", "AI_Moral_Interest", as.list(path_a_sig_rel_s2$mediators), path_a_sig_rel_s2$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  rep_mediators_rel_int_s1 <- select_representatives(ind_mediation_rel_int_s1, s1_core)
  rep_mediators_rel_int_s2 <- select_representatives(ind_mediation_rel_int_s2, s2_core)

  # 4. rs_int
  ind_mediation_rs_int_s1 <- run_mediation_analyses(s1_core, "R_Score", "AI_Moral_Interest", as.list(path_a_sig_rs_s1$mediators), path_a_sig_rs_s1$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  ind_mediation_rs_int_s2 <- run_mediation_analyses(s2_core, "R_Score", "AI_Moral_Interest", as.list(path_a_sig_rs_s2$mediators), path_a_sig_rs_s2$names, sims = BOOTSTRAP_SIMS, standardize = TRUE)
  rep_mediators_rs_int_s1 <- select_representatives(ind_mediation_rs_int_s1, s1_core)
  rep_mediators_rs_int_s2 <- select_representatives(ind_mediation_rs_int_s2, s2_core)

  # Pre-computed individual mediation inline text variables for Question 3
  indirect_ind_rs_freq_sources_s1 <- fmt_ind_raw(ind_mediation_rs_freq_s1, "Overall Frequency of Seeking Moral Advice")
  indirect_ind_rs_freq_authority_s1 <- fmt_ind_raw(ind_mediation_rs_freq_s1, "Perceived Authority of AI Chatbots as Moral Advisors")
  indirect_ind_rs_freq_openness_s1 <- fmt_ind_raw(ind_mediation_rs_freq_s1, "Open-Mindedness on Moral Issues")

  indirect_ind_rs_freq_sources_s2 <- fmt_ind_raw(ind_mediation_rs_freq_s2, "Overall Frequency of Seeking Moral Advice")
  indirect_ind_rs_freq_authority_s2 <- fmt_ind_raw(ind_mediation_rs_freq_s2, "Perceived Authority of AI Chatbots as Moral Advisors")
  indirect_ind_rs_freq_anthro_s2 <- fmt_ind_raw(ind_mediation_rs_freq_s2, "Tendency to Anthropomorphize AI Chatbots")
  indirect_ind_rs_freq_mfq_s2 <- fmt_ind_raw(ind_mediation_rs_freq_s2, "Deference to Authority (MFQ-2)")
  indirect_ind_rs_freq_mac_s2 <- fmt_ind_raw(ind_mediation_rs_freq_s2, "Deference to Authority (MAC-Q)")

  # ── 5. Parallel SEM Fits (Bootstrapped) ───────────────────────────────────────
  # Standardized Order: rel_freq, rs_freq, rel_int, rs_int

  # 1. rel_freq
  model_rel_freq_s1 <- build_parallel_model("Religiosity", "AI_Moral_Frequency", names(rep_mediators_rel_freq_s1$mediators))
  model_rel_freq_s2 <- build_parallel_model("Religiosity", "AI_Moral_Frequency", names(rep_mediators_rel_freq_s2$mediators))
  parallel_rel_freq_s1 <- sem(model_rel_freq_s1, data = s1_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")
  parallel_rel_freq_s2 <- sem(model_rel_freq_s2, data = s2_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")

  # 2. rs_freq
  model_rs_freq_s1 <- build_parallel_model("R_Score", "AI_Moral_Frequency", names(rep_mediators_rs_freq_s1$mediators))
  model_rs_freq_s2 <- build_parallel_model("R_Score", "AI_Moral_Frequency", names(rep_mediators_rs_freq_s2$mediators))
  parallel_rs_freq_s1 <- sem(model_rs_freq_s1, data = s1_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")
  parallel_rs_freq_s2 <- sem(model_rs_freq_s2, data = s2_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")

  # 3. rel_int
  model_rel_int_s1 <- build_parallel_model("Religiosity", "AI_Moral_Interest", names(rep_mediators_rel_int_s1$mediators))
  model_rel_int_s2 <- build_parallel_model("Religiosity", "AI_Moral_Interest", names(rep_mediators_rel_int_s2$mediators))
  parallel_rel_int_s1 <- sem(model_rel_int_s1, data = s1_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")
  parallel_rel_int_s2 <- sem(model_rel_int_s2, data = s2_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")

  # 4. rs_int
  model_rs_int_s1 <- build_parallel_model("R_Score", "AI_Moral_Interest", names(rep_mediators_rs_int_s1$mediators))
  model_rs_int_s2 <- build_parallel_model("R_Score", "AI_Moral_Interest", names(rep_mediators_rs_int_s2$mediators))
  parallel_rs_int_s1 <- sem(model_rs_int_s1, data = s1_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")
  parallel_rs_int_s2 <- sem(model_rs_int_s2, data = s2_core, se = "bootstrap", bootstrap = BOOTSTRAP_SIMS, missing = "listwise")

  # Pre-extracted parameter estimates for parallel SEM tables
  estimates_parallel_rel_freq_s1 <- extract_all_estimates(
    parallel_rel_freq_s1,
    mediator_names = rep_mediators_rel_freq_s1$names,
    predictor_name = "Self-Reported Religiosity", outcome_name = "AI Moral Frequency"
  )

  estimates_parallel_rel_freq_s2 <- extract_all_estimates(
    parallel_rel_freq_s2,
    mediator_names = rep_mediators_rel_freq_s2$names,
    predictor_name = "Self-Reported Religiosity", outcome_name = "AI Moral Frequency"
  )

  estimates_parallel_rs_freq_s1 <- extract_all_estimates(
    parallel_rs_freq_s1,
    mediator_names = rep_mediators_rs_freq_s1$names,
    predictor_name = "Religious Behavior Score", outcome_name = "AI Moral Frequency"
  )

  estimates_parallel_rs_freq_s2 <- extract_all_estimates(
    parallel_rs_freq_s2,
    mediator_names = rep_mediators_rs_freq_s2$names,
    predictor_name = "Religious Behavior Score", outcome_name = "AI Moral Frequency"
  )

  estimates_parallel_rel_int_s1 <- extract_all_estimates(
    parallel_rel_int_s1,
    mediator_names = rep_mediators_rel_int_s1$names,
    predictor_name = "Self-Reported Religiosity", outcome_name = "AI Moral Interest"
  )

  estimates_parallel_rel_int_s2 <- extract_all_estimates(
    parallel_rel_int_s2,
    mediator_names = rep_mediators_rel_int_s2$names,
    predictor_name = "Self-Reported Religiosity", outcome_name = "AI Moral Interest"
  )

  estimates_parallel_rs_int_s1 <- extract_all_estimates(
    parallel_rs_int_s1,
    mediator_names = rep_mediators_rs_int_s1$names,
    predictor_name = "Religious Behavior Score", outcome_name = "AI Moral Interest"
  )

  estimates_parallel_rs_int_s2 <- extract_all_estimates(
    parallel_rs_int_s2,
    mediator_names = rep_mediators_rs_int_s2$names,
    predictor_name = "Religious Behavior Score", outcome_name = "AI Moral Interest"
  )

  # Pre-computed model summary statistics for parallel SEM in-text prose
  summary_parallel_rel_freq_s1 <- extract_parallel_model_summary(parallel_rel_freq_s1, "Religiosity", "AI_Moral_Frequency")
  summary_parallel_rel_freq_s2 <- extract_parallel_model_summary(parallel_rel_freq_s2, "Religiosity", "AI_Moral_Frequency")

  summary_parallel_rs_freq_s1 <- extract_parallel_model_summary(parallel_rs_freq_s1, "R_Score", "AI_Moral_Frequency")
  summary_parallel_rs_freq_s2 <- extract_parallel_model_summary(parallel_rs_freq_s2, "R_Score", "AI_Moral_Frequency")

  summary_parallel_rel_int_s1 <- extract_parallel_model_summary(parallel_rel_int_s1, "Religiosity", "AI_Moral_Interest")
  summary_parallel_rel_int_s2 <- extract_parallel_model_summary(parallel_rel_int_s2, "Religiosity", "AI_Moral_Interest")

  summary_parallel_rs_int_s1 <- extract_parallel_model_summary(parallel_rs_int_s1, "R_Score", "AI_Moral_Interest")
  summary_parallel_rs_int_s2 <- extract_parallel_model_summary(parallel_rs_int_s2, "R_Score", "AI_Moral_Interest")

  # ── 6. Moderation Fits by Source Access (Study 2 Only) ────────────────────────
  # Standardized Order: rel_freq, rs_freq, rel_int, rs_int

  # 1. rel_freq
  moderation_rel_freq_s2_ai <- lm(AI_Moral_Frequency ~ Religiosity * AI_Moral_Access, data = s2_core)
  moderation_rel_freq_s2_overall <- lm(AI_Moral_Frequency ~ Religiosity * Moral_Access, data = s2_core)

  # 2. rs_freq
  moderation_rs_freq_s2_ai <- lm(AI_Moral_Frequency ~ R_Score * AI_Moral_Access, data = s2_core)
  moderation_rs_freq_s2_overall <- lm(AI_Moral_Frequency ~ R_Score * Moral_Access, data = s2_core)

  # 3. rel_int
  moderation_rel_int_s2_ai <- lm(AI_Moral_Interest ~ Religiosity * AI_Moral_Access, data = s2_core)
  moderation_rel_int_s2_overall <- lm(AI_Moral_Interest ~ Religiosity * Moral_Access, data = s2_core)

  # 4. rs_int
  moderation_rs_int_s2_ai <- lm(AI_Moral_Interest ~ R_Score * AI_Moral_Access, data = s2_core)
  moderation_rs_int_s2_overall <- lm(AI_Moral_Interest ~ R_Score * Moral_Access, data = s2_core)

  # Save the results of main-analysis.R to R/main-analysis.RData
  CACHED_BOOTSTRAP_SIMS <- BOOTSTRAP_SIMS

  # Exclude cache helper variables from the saved workspace
  all_vars <- ls(envir = .GlobalEnv)
  vars_to_save <- setdiff(all_vars, c("cache_file", "analysis_deps", "is_cache_valid"))

  save(list = vars_to_save, file = cache_file, envir = .GlobalEnv)
  message("Main analysis results successfully cached to ", cache_file)
}
