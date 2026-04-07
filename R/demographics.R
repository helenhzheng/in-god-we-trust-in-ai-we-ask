# Demographic summary functions
# Requires: R/data-loading.R sourced first (for RACE_MAP, FAITH_MAP)

get_date_range <- function(dataset) {
  date_col <- as.Date(dataset[[1]])  # truncate timestamps → calendar dates
  d_min <- min(date_col, na.rm = TRUE)
  d_max <- max(date_col, na.rm = TRUE)
  if (d_min == d_max) return(format(d_min, "%B %d, %Y"))
  # Same month & year → "September 19–20, 2025"
  if (format(d_min, "%B %Y") == format(d_max, "%B %Y")) {
    return(paste0(format(d_min, "%B %d"), "\u2013", format(d_max, "%d, %Y")))
  }
  # Same year → "March 27–September 20, 2025"
  if (format(d_min, "%Y") == format(d_max, "%Y")) {
    return(paste0(format(d_min, "%B %d"), "\u2013", format(d_max, "%B %d, %Y")))
  }
  # Different years → "December 30, 2024–January 2, 2025"
  paste0(format(d_min, "%B %d, %Y"), "\u2013", format(d_max, "%B %d, %Y"))
}

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

