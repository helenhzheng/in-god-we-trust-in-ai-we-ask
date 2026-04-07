# Package loading and global options
# Source this file once at the start of each .qmd

# List of required packages
required_packages <- c(
  "knitr", "psych", "ggplot2", "tidyr", "dplyr", "patchwork",
  "forcats", "tibble", "mediation", "lavaan", "readr",
  "stringr", "scales", "flextable", "officer"
)

# Check and install any missing packages
missing_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if (length(missing_packages) > 0) {
  install.packages(missing_packages, repos = "https://cloud.r-project.org/")
}

# Load all packages quietly
suppressPackageStartupMessages({
  invisible(lapply(required_packages, library, character.only = TRUE))
})

# Global flextable defaults — match APA document font
set_flextable_defaults(
  font.family = "Times New Roman",
  font.size   = 12
)

# Global chunk options
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  echo    = FALSE,
  include = TRUE
)
