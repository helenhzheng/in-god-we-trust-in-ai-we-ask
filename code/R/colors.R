# Color palette architecture for the manuscript
# Supports dynamic switching between color-blind friendly (Okabe-Ito) and high-contrast B/W modes

if (!exists("PLOT_COLOR_MODE")) {
  PLOT_COLOR_MODE <- "color"
}

set_color_scheme <- function(mode = "color") {
  assign("PLOT_COLOR_MODE", mode, envir = .GlobalEnv)

  if (mode == "bw") {
    # High-contrast Grayscale / Black & White Scheme
    CLR_PRIMARY        <<- "#000000"  # Solid Black
    CLR_SECONDARY      <<- "#555555"  # Dark Grey
    CLR_ACCENT         <<- "#888888"  # Mid Grey

    CLR_PRIMARY_FILL   <<- "#CCCCCC"  # Light Grey Fill
    CLR_SECONDARY_FILL <<- "#E5E5E5"  # Soft Grey Fill
    CLR_ACCENT_FILL    <<- "#F0F0F0"  # Off-White Fill

    CLR_DIRECT_PATH    <<- "#000000"  # Black dashed line
    CLR_SEGMENT        <<- "#333333"  # Dark segment lines
    CLR_LABEL_BG       <<- "#FFFFFF"  # White label background
    CLR_BOX_BORDER     <<- "#000000"  # Black box border
    CLR_TEXT           <<- "#000000"  # Black text
    CLR_NODE_TEXT      <<- "#FFFFFF"  # White text inside dark nodes
  } else {
    # Color-Blind Friendly Scheme (Okabe-Ito High Contrast)
    CLR_PRIMARY        <<- "#1F4E79"  # Deep Navy Blue
    CLR_SECONDARY      <<- "#D55E00"  # Vermilion Red-Orange
    CLR_ACCENT         <<- "#009E73"  # Bluish Green

    CLR_PRIMARY_FILL   <<- "#A6C4E2"  # Soft Blue Fill
    CLR_SECONDARY_FILL <<- "#FADBD8"  # Soft Red/Orange Fill
    CLR_ACCENT_FILL    <<- "#A8E6A1"  # Soft Green Fill

    CLR_DIRECT_PATH    <<- "#D55E00"  # Vermilion direct path
    CLR_SEGMENT        <<- "grey45"   # Grey segment lines
    CLR_LABEL_BG       <<- "#FFFFFF"  # White label background
    CLR_BOX_BORDER     <<- "#FFFFFF"  # White box border
    CLR_TEXT           <<- "#000000"  # Black text
    CLR_NODE_TEXT      <<- "#FFFFFF"  # White text inside nodes
  }
}

# Initialize scheme based on current mode setting
set_color_scheme(PLOT_COLOR_MODE)
