# Data loading and cleaning for all 4 datasets
# Produces: P1, P2, Study1, Study2, plus core analysis data frames

# --- Source labels (18 sources) ---
SOURCES <- c(
  "Social Media", "Legacy Media", "Family", "Friends",
  "Colleagues and Coworkers", "Praying or Meditation",
  "Religious Texts", "Religious Leaders", "Influencers",
  "Public Figures", "Internet Search", "Community Leaders",
  "Educators", "Books", "Historical Figures", "Online Forums",
  "Chatbots/AI Assistants", "Yourself"
)

# Sources excluded from composite disposition scores.
# "Chatbots/AI Assistants" is excluded because it is the outcome variable;
# "Yourself" is excluded because internal deliberation is not external guidance;
# the three religious sources are excluded to avoid criterion contamination with the religiosity predictor.
RELIGIOUS_SOURCES <- c("Praying or Meditation", "Religious Texts", "Religious Leaders")
EXCLUDED_SOURCES  <- c("Chatbots/AI Assistants", "Yourself", RELIGIOUS_SOURCES)

# --- Race / Faith label maps ---
RACE_MAP <- c(
  "Black or African American", "East Asian", "Hispanic or Latina/o/x/e",
  "Indigenous American, American Indian, or Alaska Native",
  "Middle Eastern or North African", "Native Hawaiian or other Pacific Islander",
  "South Asian", "Southeast Asian", "White", "Other", "Prefer not to disclose"
)

FAITH_MAP <- c(
  "Agnostic", "Atheist", "Buddhist", "Christian", "Hindu",
  "Jewish", "Muslim", "Sikh", "Other"
)

# --- Helper: recode gender ---
recode_demographics <- function(df) {
  df %>%
    mutate(
      across(any_of("Gender"), ~ case_when(
        . == 1 ~ "Man",
        . == 2 ~ "Woman",
        . %in% c(3, 4) ~ "Other",
        . == 5 ~ "Prefer not to disclose",
        TRUE ~ as.character(.)
      ))
    )
}

# ============================================================
# PILOT STUDY 1
# ============================================================
P1 <- read.csv("./Data Collection/P1.csv")
P1 <- P1[-c(1, 2), ]
P1 <- P1 %>%
  mutate(across(where(is.character), ~ na_if(trimws(.), ""))) %>%
  type_convert() %>%
  filter(
    DistributionChannel == "anonymous",
    Q1 == 5, Finished == 1,
    X110.Rules_111 == 1, X110.Rules_112 == 3, X110.Rules_113 == 5,
    X110.Rules_114 == 6, X110.Rules_115 == 2, X110.Rules_116 == 4,
    X110.Rules_117 == 7
  ) %>%
  recode_demographics()

P1_date <- get_date_range(P1)

# ============================================================
# PILOT STUDY 2
# ============================================================
P2 <- read.csv("./Data Collection/P2.csv")
P2 <- P2[-c(1, 2), ]
P2 <- P2 %>%
  mutate(across(where(is.character), ~ na_if(trimws(.), ""))) %>%
  type_convert() %>%
  filter(DistributionChannel == "anonymous", Q1 == 5, Finished == 1) %>%
  recode_demographics()

P2_date <- get_date_range(P2)

# ============================================================
# STUDY 1
# ============================================================
Study1 <- read.csv("./Data Collection/Study1.csv")
Study1 <- Study1[-c(1, 2), ]
Study1 <- Study1 %>%
  mutate(across(where(is.character), ~ na_if(trimws(.), ""))) %>%
  type_convert() %>%
  filter(
    DistributionChannel == "anonymous",
    Q1 == 1, Finished == 1,
    Q_RecaptchaScore >= .5,
    factual_resp == 1
  ) %>%
  mutate(
    Religiosity = case_when(
      Religiosity == 1 ~ 1, Religiosity == 2 ~ 2, Religiosity == 3 ~ 3,
      Religiosity == 4 ~ 5, Religiosity == 6 ~ 4 # correcting error in Quatrics for Religiosity coding
    ),
    Spirituality = case_when(
      Spirituality == 1 ~ 1, Spirituality == 2 ~ 2, Spirituality == 3 ~ 3,
      Spirituality == 4 ~ 5, Spirituality == 6 ~ 4 # correcting error in Quatrics for Spirituality coding
    ),
    Service = Services # normalise field name to match Study 2
  ) %>%
  recode_demographics() %>%
  mutate(R_Score = (Service + Pray) / 2)

Study1_date <- get_date_range(Study1)

# ============================================================
# STUDY 2
# ============================================================
Study2 <- read_csv("./Data Collection/Study2.csv")
Study2 <- Study2[-c(1, 2), ]
Study2 <- Study2 %>%
  mutate(across(where(is.character), ~ na_if(trimws(.), ""))) %>%
  type_convert() %>%
  filter(
    DistributionChannel == "anonymous",
    Q1 == 1, Q3 == 45, Finished == 1,
    Q_RecaptchaScore >= .5,
    factual_resp == 1,
    is.na(Q_DuplicateRespondent)
  ) %>%
  recode_demographics() %>%
  mutate(R_Score = (Service + Pray) / 2)

Study2_date <- get_date_range(Study2)

# ============================================================
# STUDY 1 - CORE ANALYSIS DATA
# ============================================================
s1_moral_freq <- Study1[, c(55:72)] %>%
  mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
  setNames(SOURCES)

s1_moral_interest <- Study1[, c(75:92)] %>%
  mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
  setNames(SOURCES)

s1_core <- data.frame(
  AI_Moral_Frequency = s1_moral_freq$`Chatbots/AI Assistants`,
  AI_Moral_Interest = s1_moral_interest$`Chatbots/AI Assistants`,
  Moral_Frequency = rowMeans(s1_moral_freq[, setdiff(names(s1_moral_freq), EXCLUDED_SOURCES)], na.rm = TRUE),
  Moral_Interest = rowMeans(s1_moral_interest[, setdiff(names(s1_moral_interest), EXCLUDED_SOURCES)], na.rm = TRUE),
  General_Curiosity = rowSums(Study1[, c(96:105)]),
  Moral_Curiosity = rowSums(Study1[, c(106:120)]),
  CIHS = rowSums(Study1[, c(121:142)] %>%
    mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
    mutate(across(ends_with("_R"), ~ 6 - .))),
  MMIH = rowSums(Study1[, c(143:165)] %>%
    mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
    mutate(across(ends_with("_R"), ~ 8 - .))),
  Moral_Objectivity = Study1 %>% dplyr::select(starts_with("Moral.Objectivity")) %>% dplyr::pull(1),
  AI_Valence_Moral = Study1$AI_Valence_moral,
  AI_Authority_Moral = Study1$AI_Authority_Moral,
  Religiosity = Study1$Religiosity,
  R_Score = Study1$R_Score,
  Age = Study1$Age,
  Education = Study1$Education,
  Income = Study1$Income,
  SES = Study1$SES,
  Political = Study1$Political_overall,
  check.names = FALSE
)

s1_mediators <- s1_core[, 3:11]
S1_MEDIATOR_NAMES <- c(
  "Overall Frequency of Seeking Moral Advice",
  "Overall Interest in Seeking Moral Advice",
  "General Open-Mindedness",
  "Open-Mindedness on Moral Issues",
  "Intellectual Humility (CIHS)",
  "Intellectual Humility (MMIH)",
  "Belief in Moral Objectivity",
  "Perceived Valence of AI Chatbots as Moral Advisors",
  "Perceived Authority of AI Chatbots as Moral Advisors"
)

S1_CORE_NAMES <- c(
  "Frequency of Seeking Moral Advice from AI Chatbots",
  "Interest in Seeking Moral Advice from AI Chatbots",
  "Overall Frequency of Seeking Moral Advice",
  "Overall Interest in Seeking Moral Advice",
  "General Open-Mindedness",
  "Open-Mindedness on Moral Issues",
  "Intellectual Humility (CIHS)",
  "Intellectual Humility (MMIH)",
  "Belief in Moral Objectivity",
  "Perceived Valence of AI Chatbots as Moral Advisors",
  "Perceived Authority of AI Chatbots as Moral Advisors",
  "Self-Reported Religiosity",
  "Religious Behavior Score",
  "Age", "Education", "Income", "Socioeconomic Status", "Political Orientation"
)

# ============================================================
# STUDY 2 - CORE ANALYSIS DATA
# ============================================================
s2_moral_freq <- Study2[, c(16:33)] %>%
  mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
  setNames(SOURCES)

s2_moral_interest <- Study2[, c(34:51)] %>%
  mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
  setNames(SOURCES)

s2_moral_access <- Study2[, c(52:69)] %>%
  mutate(across(everything(), ~ as.numeric(as.character(.)))) %>%
  setNames(SOURCES)

s2_core <- data.frame(
  AI_Moral_Frequency = s2_moral_freq$`Chatbots/AI Assistants`,
  AI_Moral_Interest = s2_moral_interest$`Chatbots/AI Assistants`,
  AI_Moral_Access = s2_moral_access$`Chatbots/AI Assistants`,
  Moral_Frequency = rowMeans(s2_moral_freq[, setdiff(names(s2_moral_freq), EXCLUDED_SOURCES)], na.rm = TRUE),
  Moral_Interest = rowMeans(s2_moral_interest[, setdiff(names(s2_moral_interest), EXCLUDED_SOURCES)], na.rm = TRUE),
  Moral_Access = rowMeans(s2_moral_access[, setdiff(names(s2_moral_access), EXCLUDED_SOURCES)], na.rm = TRUE),
  Moral_Curiosity = rowSums(Study2 %>% dplyr::select(starts_with("MCS"))),
  Moral_Objectivity = Study2 %>% dplyr::select(starts_with("Moral Objectivism")) %>% dplyr::pull(1),
  AI_Authority_Moral = Study2 %>% dplyr::select(starts_with("AI Authority")) %>% dplyr::pull(1),
  AI_Anthropomorphism = rowMeans(Study2 %>% dplyr::select(starts_with("Anthropomorphism"))),
  FNES = rowSums(Study2 %>%
    dplyr::select(starts_with("FNES")) %>%
    mutate(across(ends_with("_R"), ~ 6 - as.numeric(.)))),
  SR = rowSums(Study2 %>%
    dplyr::select(starts_with("SR")) %>%
    mutate(across(ends_with("_R"), ~ 7 - as.numeric(.)))),
  Authority_MFQ_2 = rowSums(Study2 %>% dplyr::select(starts_with("MFQ_2_Authority"))),
  Authority_MAC = rowSums(Study2[, c(192, 193, 194)]),
  Religiosity = Study2$Religiosity,
  R_Score = rowMeans(Study2[, c("Service", "Pray")]),
  Age = Study2$Age,
  Education = Study2$Education,
  Political = Study2$Political_overall,
  SES = Study2$SES,
  Income = Study2$Income
)

s2_mediators <- s2_core[, c(4:5, 7:14)]
S2_MEDIATOR_NAMES <- c(
  "Overall Frequency of Seeking Moral Advice",
  "Overall Interest in Seeking Moral Advice",
  "Open-Mindedness on Moral Issues",
  "Belief in Moral Objectivity",
  "Perceived Authority of AI Chatbots as Moral Advisors",
  "Tendency to Anthropomorphize AI Chatbots",
  "Fear of Negative Judgement",
  "Self-Reflective Tendencies",
  "Deference to Authority (MFQ-2)",
  "Deference to Authority (MAC-Q)"
)

S2_CORE_NAMES <- c(
  "Frequency of Seeking Moral Advice from AI Chatbots",
  "Interest in Seeking Moral Advice from AI Chatbots",
  "Access to AI Chatbots as Moral Advisors",
  "Overall Frequency of Seeking Moral Advice",
  "Overall Interest in Seeking Moral Advice",
  "Overall Access to Sources of Moral Advice",
  "Open-Mindedness on Moral Issues",
  "Belief in Moral Objectivity",
  "Perceived Authority of AI Chatbots as Moral Advisors",
  "Tendency to Anthropomorphize AI Chatbots",
  "Fear of Negative Judgement",
  "Self-Reflective Tendencies",
  "Deference to Authority (MFQ-2)",
  "Deference to Authority (MAC-Q)",
  "Self-Reported Religiosity",
  "Religious Behavior Score",
  "Age", "Education", "Political Orientation",
  "Socioeconomic Status", "Income"
)

# --- Mediator cluster membership ---
# Used by pick_cluster_reps() in supplementary.R to select one mediator per cluster.
# Cluster letters match the 8-cluster moral consultancy framework:
#   a = Moral Consultation Disposition (frequency / interest)
#   b = Moral Open-mindedness (general curiosity, moral curiosity, CIHS, MMIH)
#   c = Moral Meta-cognition (belief in moral objectivity)
#   d = AI Perception (perceived valence / authority of AI)
#   e = AI Social Cognition (tendency to anthropomorphize AI)
#   f = Other Personal Trait (FNE / SR / Authority)
MEDIATOR_CLUSTERS <- c(
  Moral_Frequency     = "a",
  Moral_Interest      = "a",
  General_Curiosity   = "b",
  Moral_Curiosity     = "b",
  CIHS                = "b",
  MMIH                = "b",
  Moral_Objectivity   = "c",
  AI_Valence_Moral    = "d",
  AI_Authority_Moral  = "d",
  AI_Anthropomorphism = "e",
  FNES                = "f",
  SR                  = "f",
  Authority_MFQ_2     = "f",
  Authority_MAC       = "f"
)
