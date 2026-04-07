# APA formatting helpers and shared ggplot theme
# Requires: R/colors.R, R/packages.R sourced first

# --- APA p-value formatting ---
apa_p <- function(x, eq = TRUE) {
  ifelse(x < .001, "<.001",
         if (eq) paste0("=", sprintf("%.3f", x)) else sprintf("%.3f", x))
}

# --- Significance stars ---
add_stars <- function(p) {
  if (is.na(p)) return("")
  if (p < 0.001) return("***")
  if (p < 0.01)  return("**")
  if (p < 0.05)  return("*")
  return("")
}

# --- Extract APA-formatted lm coefficients ---
apa_lm_summary <- function(model, predictor) {
  coef_sum <- summary(model)$coefficients
  est   <- coef_sum[predictor, "Estimate"]
  se    <- coef_sum[predictor, "Std. Error"]
  p_val <- coef_sum[predictor, "Pr(>|t|)"]
  ci    <- confint(model)[predictor, ]

  c(
    Estimate = sprintf("%.2f", est),
    SE       = sprintf("%.2f", se),
    LL       = sprintf("%.2f", ci[1]),
    UL       = sprintf("%.2f", ci[2]),
    p        = ifelse(p_val < .001, "< .001", sprintf("%.3f", p_val))
  )
}

# --- APA correlation label for ggplot annotations (parsed expression) ---
apa_cor_label <- function(x, y) {
  ct <- cor.test(x, y, method = "pearson")
  r  <- sprintf("%.2f", ct$estimate)
  df <- ct$parameter
  p  <- apa_p(ct$p.value)
  paste0(
    "italic('r') == ", r,
    " ~ (", df, ") * ', ' * ",
    "italic('p') ~ '", p, "'"
  )
}

# --- Shared APA ggplot theme ---
apa_theme <- theme_classic(base_size = 12) +
  theme(
    text              = element_text(family = "serif"),
    axis.title        = element_text(size = 12),
    axis.text         = element_text(size = 12),
    strip.text        = element_text(size = 12),
    strip.background  = element_blank(),
    plot.title         = element_text(size = 12, hjust = 0, face = "bold"),
    plot.caption       = element_text(size = 12, hjust = 0),
    panel.border       = element_blank(),
    axis.text.x        = element_text(hjust = 1),
    legend.position    = "bottom",
    legend.direction   = "horizontal",
    plot.title.position   = "plot",
    plot.caption.position = "plot"
  )
