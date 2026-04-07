# Codebook

Each CSV file contains a 3-row Qualtrics header:
- Row 1: Column names
- Row 2: Question text / variable descriptions
- Row 3: ImportId metadata (skipped by the R code)

Data rows begin at row 4.

Columns that were collected but not analyzed in the manuscript are marked in bold with the purpose "Collected, not reported".

## Study 1 (Study1.csv) — 224 columns

| # | Column Name | Description (Row 2) | Purpose |
|---|-------------|---------------------|---------|
| 1 | `StartDate` | Start Date | Metadata |
| 2 | `EndDate` | End Date | Metadata |
| 3 | `Status` | Response Type | Metadata |
| 4 | `Progress` | Progress | Metadata |
| 5 | `Duration (in seconds)` | Duration (in seconds) | Metadata |
| 6 | `Finished` | Finished | Response filter |
| 7 | `RecordedDate` | Recorded Date | Metadata |
| 8 | `ResponseId` | Response ID | Metadata |
| 9 | `DistributionChannel` | Distribution Channel | Response filter |
| 10 | `UserLanguage` | User Language | Metadata |
| 11 | `Q_RecaptchaScore` | Q_RecaptchaScore | Response filter |
| 12 | `Q1` | Consent form | Response filter |
| 13 | `prolific_id` | Removed from the record | Metadata |
| 14 | `Advice _1` | How often do you look toward each of the below sources for advice and guidance? - Social media | Collected, not reported |
| 15 | `Advice _2` | How often do you look toward each of the below sources for advice and guidance? - Legacy media (e.g. newspaper, television) | Collected, not reported |
| 16 | `Advice _3` | How often do you look toward each of the below sources for advice and guidance? - Family | Collected, not reported |
| 17 | `Advice _4` | How often do you look toward each of the below sources for advice and guidance? - Friends | Collected, not reported |
| 18 | `Advice _5...18` | How often do you look toward each of the below sources for advice and guidance? - Colleagues and coworkers | Collected, not reported |
| 19 | `Advice _6...19` | How often do you look toward each of the below sources for advice and guidance? - Religious or spiritual practices (e.g., praying or meditation) | Collected, not reported |
| 20 | `Advice _7` | How often do you look toward each of the below sources for advice and guidance? - Religious texts (e.g., Bible, Koran, Torah) | Collected, not reported |
| 21 | `Advice _8` | How often do you look toward each of the below sources for advice and guidance? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Collected, not reported |
| 22 | `Advice _9` | How often do you look toward each of the below sources for advice and guidance? - Influencers | Collected, not reported |
| 23 | `Advice _10` | How often do you look toward each of the below sources for advice and guidance? - Public figures | Collected, not reported |
| 24 | `Advice _11` | How often do you look toward each of the below sources for advice and guidance? - Internet search | Collected, not reported |
| 25 | `Advice _12` | How often do you look toward each of the below sources for advice and guidance? - Community leaders | Collected, not reported |
| 26 | `Advice _13` | How often do you look toward each of the below sources for advice and guidance? - Educators | Collected, not reported |
| 27 | `Advice _14` | How often do you look toward each of the below sources for advice and guidance? - Books | Collected, not reported |
| 28 | `Advice _5...28` | How often do you look toward each of the below sources for advice and guidance? - Historical figures | Collected, not reported |
| 29 | `Advice _6...29` | How often do you look toward each of the below sources for advice and guidance? - Online forums | Collected, not reported |
| 30 | `Advice _17` | How often do you look toward each of the below sources for advice and guidance? - Chatbots/ AI assistants | Collected, not reported |
| 31 | `Advice _18` | How often do you look toward each of the below sources for advice and guidance? - Yourself (use your own judgment) | Collected, not reported |
| 32 | `Advice _O` | How often do you look toward each of the below sources for advice and guidance? - Other sources | Collected, not reported |
| 33 | `Advice _O_TEXT` | How often do you look toward each of the below sources for advice and guidance? - Other sources - Text | Collected, not reported |
| 34 | `Advice_interest_1` | How interested are you in seeking advice or guidance from each of the following sources? - Social media | Collected, not reported |
| 35 | `Advice_interest_2` | How interested are you in seeking advice or guidance from each of the following sources? - Legacy media (e.g. newspaper, television) | Collected, not reported |
| 36 | `Advice_interest_3` | How interested are you in seeking advice or guidance from each of the following sources? - Family | Collected, not reported |
| 37 | `Advice_interest_4` | How interested are you in seeking advice or guidance from each of the following sources? - Friends | Collected, not reported |
| 38 | `Advice_interest_5` | How interested are you in seeking advice or guidance from each of the following sources? - Colleagues and coworkers | Collected, not reported |
| 39 | `Advice_interest_6` | How interested are you in seeking advice or guidance from each of the following sources? - Religious or spiritual practices (e.g., praying or meditation) | Collected, not reported |
| 40 | `Advice_interest_7` | How interested are you in seeking advice or guidance from each of the following sources? - Religious texts (e.g., Bible, Koran, Torah) | Collected, not reported |
| 41 | `Advice_interest_8` | How interested are you in seeking advice or guidance from each of the following sources? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Collected, not reported |
| 42 | `Advice_interest_9` | How interested are you in seeking advice or guidance from each of the following sources? - Influencers | Collected, not reported |
| 43 | `Advice_interest_10` | How interested are you in seeking advice or guidance from each of the following sources? - Public figures | Collected, not reported |
| 44 | `Advice_interest_11` | How interested are you in seeking advice or guidance from each of the following sources? - Internet search | Collected, not reported |
| 45 | `Advice_interest_12` | How interested are you in seeking advice or guidance from each of the following sources? - Community leaders | Collected, not reported |
| 46 | `Advice_interest_13` | How interested are you in seeking advice or guidance from each of the following sources? - Educators | Collected, not reported |
| 47 | `Advice_interest_14` | How interested are you in seeking advice or guidance from each of the following sources? - Books | Collected, not reported |
| 48 | `Advice_interest_15` | How interested are you in seeking advice or guidance from each of the following sources? - Historical figures | Collected, not reported |
| 49 | `Advice_interest_16` | How interested are you in seeking advice or guidance from each of the following sources? - Online forums | Collected, not reported |
| 50 | `Advice_interest_17` | How interested are you in seeking advice or guidance from each of the following sources? - Chatbots/ AI assistants | Collected, not reported |
| 51 | `Advice_interest_18` | How interested are you in seeking advice or guidance from each of the following sources? - Yourself (use your own judgment) | Collected, not reported |
| 52 | `Advice_interest_O` | How interested are you in seeking advice or guidance from each of the following sources? - Other sources | Collected, not reported |
| 53 | `Advice_interest_O_TEXT` | How interested are you in seeking advice or guidance from each of the following sources? - Other sources - Text | Collected, not reported |
| 54 | `Questions for chatbo` | Please list any topics or areas where you would consider asking a chatbot or AI assistant for help. Feel free to include any specific questions that come to mind. | Metadata |
| 55 | `Frequency_M_1` | How often do you look toward each of the below sources for moral advice and guidance? - Social media | Mediator composite (Moral Advice Frequency) |
| 56 | `Frequency_M_2` | How often do you look toward each of the below sources for moral advice and guidance? - Legacy media (e.g. newspaper, television) | Mediator composite (Moral Advice Frequency) |
| 57 | `Frequency_M_3` | How often do you look toward each of the below sources for moral advice and guidance? - Family | Mediator composite (Moral Advice Frequency) |
| 58 | `Frequency_M_4` | How often do you look toward each of the below sources for moral advice and guidance? - Friends | Mediator composite (Moral Advice Frequency) |
| 59 | `Frequency_M_5` | How often do you look toward each of the below sources for moral advice and guidance? - Colleagues and coworkers | Mediator composite (Moral Advice Frequency) |
| 60 | `Frequency_M_6` | How often do you look toward each of the below sources for moral advice and guidance? - Religious or spiritual practices (e.g., praying or meditation) | Mediator composite (Moral Advice Frequency) |
| 61 | `Frequency_M_7` | How often do you look toward each of the below sources for moral advice and guidance? - Religious texts (e.g., Bible, Koran, Torah) | Mediator composite (Moral Advice Frequency) |
| 62 | `Frequency_M_8` | How often do you look toward each of the below sources for moral advice and guidance? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Mediator composite (Moral Advice Frequency) |
| 63 | `Frequency_M_9` | How often do you look toward each of the below sources for moral advice and guidance? - Influencers | Mediator composite (Moral Advice Frequency) |
| 64 | `Frequency_M_10` | How often do you look toward each of the below sources for moral advice and guidance? - Public figures | Mediator composite (Moral Advice Frequency) |
| 65 | `Frequency_M_11` | How often do you look toward each of the below sources for moral advice and guidance? - Internet search | Mediator composite (Moral Advice Frequency) |
| 66 | `Frequency_M_12` | How often do you look toward each of the below sources for moral advice and guidance? - Community leaders | Mediator composite (Moral Advice Frequency) |
| 67 | `Frequency_M_13` | How often do you look toward each of the below sources for moral advice and guidance? - Educators | Mediator composite (Moral Advice Frequency) |
| 68 | `Frequency_M_14` | How often do you look toward each of the below sources for moral advice and guidance? - Books | Mediator composite (Moral Advice Frequency) |
| 69 | `Frequency_M_15` | How often do you look toward each of the below sources for moral advice and guidance? - Historical figures | Mediator composite (Moral Advice Frequency) |
| 70 | `Frequency_M_16` | How often do you look toward each of the below sources for moral advice and guidance? - Online forums | Mediator composite (Moral Advice Frequency) |
| 71 | `Frequency_M_17` | How often do you look toward each of the below sources for moral advice and guidance? - Chatbots/ AI assistants | Mediator composite (Moral Advice Frequency) |
| 72 | `Frequency_M_18` | How often do you look toward each of the below sources for moral advice and guidance? - Yourself (use your own judgment) | Outcome (AI Moral Advice Frequency) |
| 73 | `Frequency_M_O` | How often do you look toward each of the below sources for moral advice and guidance? - Other sources | Metadata |
| 74 | `Frequency_M_O_TEXT` | How often do you look toward each of the below sources for moral advice and guidance? - Other sources - Text | Metadata |
| 75 | `Interest_Moral_4` | How interested are you in seeking moral advice or guidance from each of the following sources? - Social media | Mediator composite (Moral Advice Interest) |
| 76 | `Interest_Moral_19` | How interested are you in seeking moral advice or guidance from each of the following sources? - Legacy media (e.g. newspaper, television) | Mediator composite (Moral Advice Interest) |
| 77 | `Interest_Moral_11` | How interested are you in seeking moral advice or guidance from each of the following sources? - Family | Mediator composite (Moral Advice Interest) |
| 78 | `Interest_Moral_12` | How interested are you in seeking moral advice or guidance from each of the following sources? - Friends | Mediator composite (Moral Advice Interest) |
| 79 | `Interest_Moral_13` | How interested are you in seeking moral advice or guidance from each of the following sources? - Colleagues and coworkers | Mediator composite (Moral Advice Interest) |
| 80 | `Interest_Moral_9` | How interested are you in seeking moral advice or guidance from each of the following sources? - Religious or spiritual practices (e.g., praying or meditation) | Mediator composite (Moral Advice Interest) |
| 81 | `Interest_Moral_23` | How interested are you in seeking moral advice or guidance from each of the following sources? - Religious texts (e.g., Bible, Koran, Torah) | Mediator composite (Moral Advice Interest) |
| 82 | `Interest_Moral_24` | How interested are you in seeking moral advice or guidance from each of the following sources? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Mediator composite (Moral Advice Interest) |
| 83 | `Interest_Moral_8` | How interested are you in seeking moral advice or guidance from each of the following sources? - Influencers | Mediator composite (Moral Advice Interest) |
| 84 | `Interest_Moral_21` | How interested are you in seeking moral advice or guidance from each of the following sources? - Public figures | Mediator composite (Moral Advice Interest) |
| 85 | `Interest_Moral_5` | How interested are you in seeking moral advice or guidance from each of the following sources? - Internet search | Mediator composite (Moral Advice Interest) |
| 86 | `Interest_Moral_14` | How interested are you in seeking moral advice or guidance from each of the following sources? - Community leaders | Mediator composite (Moral Advice Interest) |
| 87 | `Interest_Moral_15` | How interested are you in seeking moral advice or guidance from each of the following sources? - Educators | Mediator composite (Moral Advice Interest) |
| 88 | `Interest_Moral_16` | How interested are you in seeking moral advice or guidance from each of the following sources? - Books | Mediator composite (Moral Advice Interest) |
| 89 | `Interest_Moral_6` | How interested are you in seeking moral advice or guidance from each of the following sources? - Historical figures | Mediator composite (Moral Advice Interest) |
| 90 | `Interest_Moral_7` | How interested are you in seeking moral advice or guidance from each of the following sources? - Online forums | Mediator composite (Moral Advice Interest) |
| 91 | `Interest_Moral_10` | How interested are you in seeking moral advice or guidance from each of the following sources? - Chatbots/ AI assistants | Mediator composite (Moral Advice Interest) |
| 92 | `Interest_Moral_17` | How interested are you in seeking moral advice or guidance from each of the following sources? - Yourself (use your own judgment) | Outcome (AI Moral Advice Interest) |
| 93 | `Interest_Moral_22` | How interested are you in seeking moral advice or guidance from each of the following sources? - Other sources | Metadata |
| 94 | `Interest_Moral_22_TEXT` | How interested are you in seeking moral advice or guidance from each of the following sources? - Other sources - Text | Metadata |
| 95 | `Q129` | Please list any moral topics or situations where you would consider asking a chatbot or AI assistant for help—for example, questions about whether something is right or wrong. Feel free to include any specific moral questions that come to mind. | Metadata |
| 96 | `CEI-II_1_Stretching` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I actively seek as much information as I can in new situations. | Mediator (General Open-Mindedness / CEI-II) |
| 97 | `CEI-II_2_Embracing` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I am the type of person who really enjoys the uncertainty of everyday life. | Mediator (General Open-Mindedness / CEI-II) |
| 98 | `CEI-II_3_Stretching` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I am at my best when doing something that is complex or challenging. | Mediator (General Open-Mindedness / CEI-II) |
| 99 | `CEI-II_4_Embracing` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - Everywhere I go, I am out looking for new things or experiences. | Mediator (General Open-Mindedness / CEI-II) |
| 100 | `CEI-II_5_Stretching` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I view challenging situations as an opportunity to grow and learn. | Mediator (General Open-Mindedness / CEI-II) |
| 101 | `CEI-II_6_Embracing` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I like to do things that are a little frightening. | Mediator (General Open-Mindedness / CEI-II) |
| 102 | `CEI-II_7_Stretching` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I am always looking for experiences that challenge how I think about myself and the world. | Mediator (General Open-Mindedness / CEI-II) |
| 103 | `CEI-II_8_Embracing` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I prefer jobs that are excitingly unpredictable. | Mediator (General Open-Mindedness / CEI-II) |
| 104 | `CEI-II_9_Stretching` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I frequently seek out opportunities to challenge myself and grow as a person. | Mediator (General Open-Mindedness / CEI-II) |
| 105 | `CEI-II_10_Embracing` | Rate the statements below for how accurately they reflect the way you generally feel and behave. Do not rate what you think you should do, or wish you do, or things you no longer do. Please be as honest as possible. - I am the kind of person who embraces unfamiliar people, events, and places. | Mediator (General Open-Mindedness / CEI-II) |
| 106 | `MCS_1_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I seek out opportunities to learn about other people’s values | Mediator (Moral Curiosity / MCS) |
| 107 | `MCS_2_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When someone thinks differently than me about morality, I’m curious to hear their opinion | Mediator (Moral Curiosity / MCS) |
| 108 | `MCS_3_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - It is really valuable to hear different sides of moral issues | Mediator (Moral Curiosity / MCS) |
| 109 | `MCS_4_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - It is always interesting to hear about people’s moral positions on issues | Mediator (Moral Curiosity / MCS) |
| 110 | `MCS_5_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I make it a priority to understand the values of the people I disagree with | Mediator (Moral Curiosity / MCS) |
| 111 | `MCS_6_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - It’s fun to discuss “outlandish” moral questions like whether we should stop having children and let humanity go extinct | Mediator (Moral Curiosity / MCS) |
| 112 | `MCS_7_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - There are moral arguments or ideas that are fascinating to think about even if they are wrong | Mediator (Moral Curiosity / MCS) |
| 113 | `MCS_8_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I often think about how I would behave in morally gray situations | Mediator (Moral Curiosity / MCS) |
| 114 | `MCS_9_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I sometimes find myself exploring (e.g., thinking, reading, or talking about) unusual moral questions | Mediator (Moral Curiosity / MCS) |
| 115 | `MCS_10_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I like finding out what people are thinking when they behave immorally | Mediator (Moral Curiosity / MCS) |
| 116 | `MCS_11_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I subscribe to podcasts or blogs to hear opposing viewpoints | Mediator (Moral Curiosity / MCS) |
| 117 | `MCS_12_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I intentionally express my views around people who might disagree with me | Mediator (Moral Curiosity / MCS) |
| 118 | `MCS_13_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I’ve gotten into trouble for discussing moral ideas others may find objectionable | Mediator (Moral Curiosity / MCS) |
| 119 | `MCS_14_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I like stirring the pot and getting people to talk about thorny moral questions | Mediator (Moral Curiosity / MCS) |
| 120 | `MCS_15_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I intentionally follow people on social media who have moral views I disagree with | Mediator (Moral Curiosity / MCS) |
| 121 | `CIHS_1_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I feel small when others disagree with me on topics that are close to my heart. | Mediator (Intellectual Humility / CIHS) |
| 122 | `CIHS_2_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When someone contradicts my most important beliefs, it feels like a personal attack | Mediator (Intellectual Humility / CIHS) |
| 123 | `CIHS_3_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When someone disagrees with ideas that are important to me, it feels as though I’m being attacked | Mediator (Intellectual Humility / CIHS) |
| 124 | `CIHS_4_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I tend to feel threatened when others disagree with me on topics that are close to my heart. | Mediator (Intellectual Humility / CIHS) |
| 125 | `CIHS_5_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When someone disagrees with ideas that are important to me, it makes me feel insignificant. | Mediator (Intellectual Humility / CIHS) |
| 126 | `CIHS_6` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I am open to revising my important beliefs in the face of new information. | Mediator (Intellectual Humility / CIHS) |
| 127 | `CIHS_7` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I am willing to change my position on an important issue in the face of good reasons. | Mediator (Intellectual Humility / CIHS) |
| 128 | `CIHS_8` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I am willing to change my opinions on the basis of compelling reason. | Mediator (Intellectual Humility / CIHS) |
| 129 | `CIHS_9` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I have at times changed opinions that were important to me, when someone showed me I was wrong. | Mediator (Intellectual Humility / CIHS) |
| 130 | `CIHS_10` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I’m willing to change my mind once it’s made up about an important topic. | Mediator (Intellectual Humility / CIHS) |
| 131 | `CIHS_11` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I can respect others, even if I disagree with them in important ways. | Mediator (Intellectual Humility / CIHS) |
| 132 | `CIHS_12` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I can have great respect for someone, even when we don’t see eye-to-eye on important topics. | Mediator (Intellectual Humility / CIHS) |
| 133 | `CIHS_13` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - Even when I disagree with others, I can recognize that they have sound points. | Mediator (Intellectual Humility / CIHS) |
| 134 | `CIHS_14` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I am willing to hear others out, even if I disagree with them. | Mediator (Intellectual Humility / CIHS) |
| 135 | `CIHS_15` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I welcome different ways of thinking about important topics. | Mediator (Intellectual Humility / CIHS) |
| 136 | `CIHS_16` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I respect that there are ways of making important decisions that are different from the way I make decisions. | Mediator (Intellectual Humility / CIHS) |
| 137 | `CIHS_17_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - My ideas are usually better than other people’s ideas. | Mediator (Intellectual Humility / CIHS) |
| 138 | `CIHS_18_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - For the most part, others have more to learn from me than I have to learn from them. | Mediator (Intellectual Humility / CIHS) |
| 139 | `CIHS_19_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When I am really confident in a belief, there is very little chance that belief is wrong. | Mediator (Intellectual Humility / CIHS) |
| 140 | `CIHS_20_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - On important topics, I am not likely to be swayed by the viewpoints of others. | Mediator (Intellectual Humility / CIHS) |
| 141 | `CIHS_21_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I’d rather rely on my own knowledge about most topics than turn to others for expertise. | Mediator (Intellectual Humility / CIHS) |
| 142 | `CIHS_22_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - Listening to perspectives of others seldom changes my important opinions. | Mediator (Intellectual Humility / CIHS) |
| 143 | `MDMIH_1_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I think that paying attention to people who disagree with me is a waste of time. | Mediator (Intellectual Humility / MMIH) |
| 144 | `MDMIH_2` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I feel no shame learning from someone who knows more than me. | Mediator (Intellectual Humility / MMIH) |
| 145 | `MDMIH_3` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - If I do not know much about some topic, I don’t mind being taught about it, even if I know about other topics. | Mediator (Intellectual Humility / MMIH) |
| 146 | `MDMIH_4` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - Even when I have high status, I don’t mind learning from others who have lower status. | Mediator (Intellectual Humility / MMIH) |
| 147 | `MDMIH_5_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - Only wimps admit that they’ve made mistakes. | Mediator (Intellectual Humility / MMIH) |
| 148 | `MDMIH_6_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I don’t take people seriously if they’re very different from me. | Mediator (Intellectual Humility / MMIH) |
| 149 | `MDMIH_7` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - Being smarter than other people is not especially important to me. | Mediator (Intellectual Humility / MMIH) |
| 150 | `MDMIH_8_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I would like to be seen explaining ideas that no one else understands. | Mediator (Intellectual Humility / MMIH) |
| 151 | `MDMIH_9_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I get a lot of pleasure from knowing more than other people. | Mediator (Intellectual Humility / MMIH) |
| 152 | `MDMIH_10` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I wouldn’t want people to treat me as though I were intellectually superior to them. | Mediator (Intellectual Humility / MMIH) |
| 153 | `MDMIH_11_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I want people to know that I am an unusually intelligent person. | Mediator (Intellectual Humility / MMIH) |
| 154 | `MDMIH_12_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I like to be the smartest person in the room. | Mediator (Intellectual Humility / MMIH) |
| 155 | `MDMIH_13_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I find it annoying to be told that I’ve made an intellectual mistake. | Mediator (Intellectual Humility / MMIH) |
| 156 | `MDMIH_14_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - If someone points out an intellectual mistake that I’ve made, I tend to get angry. | Mediator (Intellectual Humility / MMIH) |
| 157 | `MDMIH_15` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I appreciate being corrected when I make a mistake. | Mediator (Intellectual Humility / MMIH) |
| 158 | `MDMIH_16` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When someone corrects a mistake that I’ve made, I do not feel embarrassed. | Mediator (Intellectual Humility / MMIH) |
| 159 | `MDMIH_17_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When I realize that someone knows more than me, I feel frustrated and humiliated. | Mediator (Intellectual Humility / MMIH) |
| 160 | `MDMIH_18_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I rarely discuss things that I wish I understood better with other people. | Mediator (Intellectual Humility / MMIH) |
| 161 | `MDMIH_19` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I enjoy reading about the ideas of different cultures. | Mediator (Intellectual Humility / MMIH) |
| 162 | `MDMIH_20_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I would be very bored by a book about ideas I disagreed with. | Mediator (Intellectual Humility / MMIH) |
| 163 | `MDMIH_21_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I’ve never really enjoyed figuring out why people disagree with me. | Mediator (Intellectual Humility / MMIH) |
| 164 | `MDMIH_22_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I find it boring to discuss things I don’t already understand. | Mediator (Intellectual Humility / MMIH) |
| 165 | `MDMIH_23_R` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - A disagreement is like a war. | Mediator (Intellectual Humility / MMIH) |
| 166 | `Truth Objectivity _1` | Objective truth means something is true regardless of what people believe. Some argue that truth is objective—fixed and independent of opinion. Others believe truth is subjective or relative—it depends on personal or cultural perspectives. To what extent do you believe that truth is objective or relative? - Truth is | Collected, not reported |
| 167 | `Moral Objectivity _1` | Objective morality means something is either good or bad regardless of what people believe. Some argue that morality is objective—fixed and independent of opinion. Others believe morality is subjective or relative—it depends on personal or cultural perspectives. To what extent do you believe that morality is objective or relative? - Morality is | Mediator (Belief in Moral Objectivity) |
| 168 | `NFC_S_1` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I don’t like situations that are uncertain. | Collected, not reported |
| 169 | `NFC_S_2` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I dislike questions which could be answered in many different ways. | Collected, not reported |
| 170 | `NFC_S_3` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I find that a well ordered life with regular hours suits my temperament. | Collected, not reported |
| 171 | `NFC_S_4` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I feel uncomfortable when I don’t understand the reason why an event occurred in my life. | Collected, not reported |
| 172 | `NFC_S_5` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I feel irritated when one person disagrees with what everyone else in a group believes. | Collected, not reported |
| 173 | `NFC_S_6` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I don’t like to go into a situation without knowing what I can expect from it. | Collected, not reported |
| 174 | `NFC_S_7` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - When I have made a decision, I feel relieved. | Collected, not reported |
| 175 | `NFC_S_8` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - When I am confronted with a problem, I’m dying to reach a solution very quickly. | Collected, not reported |
| 176 | `NFC_S_9` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I would quickly become impatient and irritated if I would not find a solution to a problem immediately. | Collected, not reported |
| 177 | `NFC_S_10` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I don’t like to be with people who are capable of unexpected actions. | Collected, not reported |
| 178 | `NFC_S_11` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I dislike it when a person’s statement could mean many different things. | Collected, not reported |
| 179 | `NFC_S_12` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I find that establishing a consistent routine enables me to enjoy life more. | Collected, not reported |
| 180 | `NFC_S_13` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I enjoy having a clear and structured mode of life. | Collected, not reported |
| 181 | `NFC_S_14` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I do not usually consult many different opinions before forming my own view. | Collected, not reported |
| 182 | `NFC_S_15` | Read each of the following statements and decide how much you agree with each according to
your beliefs and experiences. - I dislike unpredictable situations. | Collected, not reported |
| 183 | `AI-Authority ` | Chatbots/ AI assistants are trusted authorities for giving accurate advice | Collected, not reported |
| 184 | `AI_Authority_Moral` | Chatbots/ AI assistants are trusted authorities for giving accurate moral advice | Mediator (Perceived Authority of AI) |
| 185 | `AI_Valence` | Chatbots/ AI assistants are _____ at giving advice | Collected, not reported |
| 186 | `AI_Valence_moral` | Chatbots/ AI assistants are _____ at giving moral advice. | Mediator (Perceived Valence of AI) |
| 187 | `factual_resp` | What is the number that comes immediately before 23? | Attention check |
| 188 | `Religiosity` | To what extent do you consider yourself to be religious? | Predictor |
| 189 | `Spirituality` | To what extent do you consider yourself to be spiritual? | Collected, not reported |
| 190 | `God` | Do you believe in God? - Selected Choice | Demographic |
| 191 | `God_3_TEXT` | Do you believe in God? - Other - Text | Demographic |
| 192 | `Faith_1` | Which of the following religious affiliations do you identify with? - Selected Choice - Agnostic | Demographic |
| 193 | `Faith_2` | Which of the following religious affiliations do you identify with? - Selected Choice - Atheist | Demographic |
| 194 | `Faith_3` | Which of the following religious affiliations do you identify with? - Selected Choice - Buddhist | Demographic |
| 195 | `Faith_4` | Which of the following religious affiliations do you identify with? - Selected Choice - Christian | Demographic |
| 196 | `Faith_5` | Which of the following religious affiliations do you identify with? - Selected Choice - Hindu | Demographic |
| 197 | `Faith_6` | Which of the following religious affiliations do you identify with? - Selected Choice - Jewish | Demographic |
| 198 | `Faith_7` | Which of the following religious affiliations do you identify with? - Selected Choice - Muslim | Demographic |
| 199 | `Faith_8` | Which of the following religious affiliations do you identify with? - Selected Choice - Sikh | Demographic |
| 200 | `Faith_9` | Which of the following religious affiliations do you identify with? - Selected Choice - Other | Demographic |
| 201 | `Faith_9_TEXT` | Which of the following religious affiliations do you identify with? - Other - Text | Demographic |
| 202 | `Services` | How often do you attend religious services? | Predictor (R_Score component) |
| 203 | `Pray` | How often do you pray? | Predictor (R_Score component) |
| 204 | `Age` | What is your age (in years)? | Covariate / Demographic |
| 205 | `Gender` | With which gender do you identify? - Selected Choice | Demographic |
| 206 | `Gender_4_TEXT` | With which gender do you identify? - An identity not listed - Text | Demographic |
| 207 | `Race_Ethnicity_1` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Black or African American | Demographic |
| 208 | `Race_Ethnicity_2` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - East Asian | Demographic |
| 209 | `Race_Ethnicity_3` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Hispanic or Latina/o/x/e | Demographic |
| 210 | `Race_Ethnicity_4` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Indigenous American, American Indian, or Alaska Native | Demographic |
| 211 | `Race_Ethnicity_5` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Middle Eastern or North African | Demographic |
| 212 | `Race_Ethnicity_6` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Native Hawaiian or other Pacific Islander | Demographic |
| 213 | `Race_Ethnicity_7` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - South Asian | Demographic |
| 214 | `Race_Ethnicity_8` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Southeast Asian | Demographic |
| 215 | `Race_Ethnicity_9` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - White | Demographic |
| 216 | `Race_Ethnicity_10` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Other | Demographic |
| 217 | `Race_Ethnicity_11` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Prefer not to disclose | Demographic |
| 218 | `Race_Ethnicity_10_TEXT` | Please indicate how you identify yourself (Choose all that apply). - Other - Text | Demographic |
| 219 | `Income` | What is your household income per year? | Covariate / Demographic |
| 220 | `Education` | What is the highest level of education you have received? (If you’re currently enrolled in school, please indicate the highest degree you have received. ) | Covariate / Demographic |
| 221 | `SES` | Think of this ladder as representing where people stand in the United States... Please indicate below where you would place yourself on this ladder. | Covariate / Demographic |
| 222 | `Political_party` | In politics today, do you consider yourself a: - Selected Choice | Collected, not reported |
| 223 | `Political_party_4_TEXT` | In politics today, do you consider yourself a: - Something else - Text | Collected, not reported |
| 224 | `Political_overall` | Politically, how liberal or conservative are you? | Covariate / Demographic |

Study 1 collected-but-not-reported columns include: (a) general (non-moral) advice frequency and interest items (cols 14–53) — parallel measures that replaced "moral" with general advice seeking; (b) Truth Objectivity (col 166) — a non-moral parallel of Moral Objectivity using "truth" in place of "morality"; (c) Need for Cognition Short (cols 168–182); (d) general AI Authority and AI Valence (cols 183, 185) — non-moral parallels of the moral-specific items; (e) Spirituality (col 189).
## Study 2 (Study2.csv) — 238 columns

| # | Column Name | Description (Row 2) | Purpose |
|---|-------------|---------------------|---------|
| 1 | `StartDate` | Start Date | Metadata |
| 2 | `EndDate` | End Date | Metadata |
| 3 | `Status` | Response Type | Metadata |
| 4 | `Progress` | Progress | Metadata |
| 5 | `Duration (in seconds)` | Duration (in seconds) | Metadata |
| 6 | `Finished` | Finished | Response filter |
| 7 | `RecordedDate` | Recorded Date | Metadata |
| 8 | `ResponseId` | Response ID | Metadata |
| 9 | `DistributionChannel` | Distribution Channel | Response filter |
| 10 | `UserLanguage` | User Language | Metadata |
| 11 | `Q_RecaptchaScore` | Q_RecaptchaScore | Response filter |
| 12 | `Q_DuplicateRespondent` | Q_DuplicateRespondent | Response filter |
| 13 | `Q1` | Consent form | Response filter |
| 14 | `prolific_id` | Removed from the record | Metadata |
| 15 | `Q3` | Please describe the object that you see in the image below: | Response filter |
| 16 | `Social Media_F` | How often do you look toward each of the below sources for moral advice and guidance? - Social media | Mediator composite (Moral Advice Frequency) |
| 17 | `Legacy Media_F` | How often do you look toward each of the below sources for moral advice and guidance? - Legacy media (e.g. newspaper, television) | Mediator composite (Moral Advice Frequency) |
| 18 | `Family_F` | How often do you look toward each of the below sources for moral advice and guidance? - Family | Mediator composite (Moral Advice Frequency) |
| 19 | `Friends_F` | How often do you look toward each of the below sources for moral advice and guidance? - Friends | Mediator composite (Moral Advice Frequency) |
| 20 | `Colleagues and Coworkers_F` | How often do you look toward each of the below sources for moral advice and guidance? - Colleagues and coworkers | Mediator composite (Moral Advice Frequency) |
| 21 | `Praying or Meditation_F` | How often do you look toward each of the below sources for moral advice and guidance? - Religious or spiritual practices (e.g., praying or meditation) | Mediator composite (Moral Advice Frequency) |
| 22 | `Religious Text_F` | How often do you look toward each of the below sources for moral advice and guidance? - Religious texts (e.g., Bible, Koran, Torah) | Mediator composite (Moral Advice Frequency) |
| 23 | `Religious Leaders_F` | How often do you look toward each of the below sources for moral advice and guidance? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Mediator composite (Moral Advice Frequency) |
| 24 | `Influencers_F` | How often do you look toward each of the below sources for moral advice and guidance? - Influencers | Mediator composite (Moral Advice Frequency) |
| 25 | `Public Figures_F` | How often do you look toward each of the below sources for moral advice and guidance? - Public figures | Mediator composite (Moral Advice Frequency) |
| 26 | `Internet Search_F` | How often do you look toward each of the below sources for moral advice and guidance? - Internet search | Mediator composite (Moral Advice Frequency) |
| 27 | `Community Leaders_F` | How often do you look toward each of the below sources for moral advice and guidance? - Community leaders | Mediator composite (Moral Advice Frequency) |
| 28 | `Educators_F` | How often do you look toward each of the below sources for moral advice and guidance? - Educators | Mediator composite (Moral Advice Frequency) |
| 29 | `Books_F` | How often do you look toward each of the below sources for moral advice and guidance? - Books | Mediator composite (Moral Advice Frequency) |
| 30 | `Historical Figures_F` | How often do you look toward each of the below sources for moral advice and guidance? - Historical figures | Mediator composite (Moral Advice Frequency) |
| 31 | `Online forums_F` | How often do you look toward each of the below sources for moral advice and guidance? - Online forums | Mediator composite (Moral Advice Frequency) |
| 32 | `AI_F` | How often do you look toward each of the below sources for moral advice and guidance? - Chatbots/ AI assistants | Outcome (AI Moral Advice Frequency) |
| 33 | `Yourself_F` | How often do you look toward each of the below sources for moral advice and guidance? - Yourself (use your own judgment) | Mediator composite (Moral Advice Frequency) |
| 34 | `Advice_interest_1...34` | How interested are you in seeking moral advice or guidance from each of the below sources? - Social media | Mediator composite (Moral Advice Interest) |
| 35 | `Advice_interest_2...35` | How interested are you in seeking moral advice or guidance from each of the below sources? - Legacy media (e.g. newspaper, television) | Mediator composite (Moral Advice Interest) |
| 36 | `Advice_interest_3...36` | How interested are you in seeking moral advice or guidance from each of the below sources? - Family | Mediator composite (Moral Advice Interest) |
| 37 | `Advice_interest_4...37` | How interested are you in seeking moral advice or guidance from each of the below sources? - Friends | Mediator composite (Moral Advice Interest) |
| 38 | `Advice_interest_5...38` | How interested are you in seeking moral advice or guidance from each of the below sources? - Colleagues and coworkers | Mediator composite (Moral Advice Interest) |
| 39 | `Advice_interest_6...39` | How interested are you in seeking moral advice or guidance from each of the below sources? - Religious or spiritual practices (e.g., praying or meditation) | Mediator composite (Moral Advice Interest) |
| 40 | `Advice_interest_7...40` | How interested are you in seeking moral advice or guidance from each of the below sources? - Religious texts (e.g., Bible, Koran, Torah) | Mediator composite (Moral Advice Interest) |
| 41 | `Advice_interest_8...41` | How interested are you in seeking moral advice or guidance from each of the below sources? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Mediator composite (Moral Advice Interest) |
| 42 | `Advice_interest_9...42` | How interested are you in seeking moral advice or guidance from each of the below sources? - Influencers | Mediator composite (Moral Advice Interest) |
| 43 | `Advice_interest_10...43` | How interested are you in seeking moral advice or guidance from each of the below sources? - Public figures | Mediator composite (Moral Advice Interest) |
| 44 | `Advice_interest_11...44` | How interested are you in seeking moral advice or guidance from each of the below sources? - Internet search | Mediator composite (Moral Advice Interest) |
| 45 | `Advice_interest_12...45` | How interested are you in seeking moral advice or guidance from each of the below sources? - Community leaders | Mediator composite (Moral Advice Interest) |
| 46 | `Advice_interest_13...46` | How interested are you in seeking moral advice or guidance from each of the below sources? - Educators | Mediator composite (Moral Advice Interest) |
| 47 | `Advice_interest_14...47` | How interested are you in seeking moral advice or guidance from each of the below sources? - Books | Mediator composite (Moral Advice Interest) |
| 48 | `Advice_interest_15...48` | How interested are you in seeking moral advice or guidance from each of the below sources? - Historical figures | Mediator composite (Moral Advice Interest) |
| 49 | `Advice_interest_16...49` | How interested are you in seeking moral advice or guidance from each of the below sources? - Online forums | Mediator composite (Moral Advice Interest) |
| 50 | `Advice_interest_17...50` | How interested are you in seeking moral advice or guidance from each of the below sources? - Chatbots/ AI assistants | Outcome (AI Moral Advice Interest) |
| 51 | `Advice_interest_18...51` | How interested are you in seeking moral advice or guidance from each of the below sources? - Yourself (use your own judgment) | Mediator composite (Moral Advice Interest) |
| 52 | `Advice_interest_1...52` | How accessible do you find each of the below sources for giving moral advice or guidance? - Social media | Moderator composite (Moral Advice Access) |
| 53 | `Advice_interest_2...53` | How accessible do you find each of the below sources for giving moral advice or guidance? - Legacy media (e.g. newspaper, television) | Moderator composite (Moral Advice Access) |
| 54 | `Advice_interest_3...54` | How accessible do you find each of the below sources for giving moral advice or guidance? - Family | Moderator composite (Moral Advice Access) |
| 55 | `Advice_interest_4...55` | How accessible do you find each of the below sources for giving moral advice or guidance? - Friends | Moderator composite (Moral Advice Access) |
| 56 | `Advice_interest_5...56` | How accessible do you find each of the below sources for giving moral advice or guidance? - Colleagues and coworkers | Moderator composite (Moral Advice Access) |
| 57 | `Advice_interest_6...57` | How accessible do you find each of the below sources for giving moral advice or guidance? - Religious or spiritual practices (e.g., praying or meditation) | Moderator composite (Moral Advice Access) |
| 58 | `Advice_interest_7...58` | How accessible do you find each of the below sources for giving moral advice or guidance? - Religious texts (e.g., Bible, Koran, Torah) | Moderator composite (Moral Advice Access) |
| 59 | `Advice_interest_8...59` | How accessible do you find each of the below sources for giving moral advice or guidance? - Religious leaders (e.g., Priests, Ministers, Imams, Rabbis) | Moderator composite (Moral Advice Access) |
| 60 | `Advice_interest_9...60` | How accessible do you find each of the below sources for giving moral advice or guidance? - Influencers | Moderator composite (Moral Advice Access) |
| 61 | `Advice_interest_10...61` | How accessible do you find each of the below sources for giving moral advice or guidance? - Public figures | Moderator composite (Moral Advice Access) |
| 62 | `Advice_interest_11...62` | How accessible do you find each of the below sources for giving moral advice or guidance? - Internet search | Moderator composite (Moral Advice Access) |
| 63 | `Advice_interest_12...63` | How accessible do you find each of the below sources for giving moral advice or guidance? - Community leaders | Moderator composite (Moral Advice Access) |
| 64 | `Advice_interest_13...64` | How accessible do you find each of the below sources for giving moral advice or guidance? - Educators | Moderator composite (Moral Advice Access) |
| 65 | `Advice_interest_14...65` | How accessible do you find each of the below sources for giving moral advice or guidance? - Books | Moderator composite (Moral Advice Access) |
| 66 | `Advice_interest_15...66` | How accessible do you find each of the below sources for giving moral advice or guidance? - Historical figures | Moderator composite (Moral Advice Access) |
| 67 | `Advice_interest_16...67` | How accessible do you find each of the below sources for giving moral advice or guidance? - Online forums | Moderator composite (Moral Advice Access) |
| 68 | `Advice_interest_17...68` | How accessible do you find each of the below sources for giving moral advice or guidance? - Chatbots/ AI assistants | Moderator (AI Moral Advice Access) |
| 69 | `Advice_interest_18...69` | How accessible do you find each of the below sources for giving moral advice or guidance? - Yourself (use your own judgment) | Moderator composite (Moral Advice Access) |
| 70 | `Questions for chatbo` | Please list any topics or areas where you would consider asking a chatbot or AI assistant for help. Feel free to include any specific questions that come to mind. | Metadata |
| 71 | `MCS_1_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I seek out opportunities to learn about other people’s values | Mediator (Moral Curiosity / MCS) |
| 72 | `MCS_2_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - When someone thinks differently than me about morality, I’m curious to hear their opinion | Mediator (Moral Curiosity / MCS) |
| 73 | `MCS_3_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - It is really valuable to hear different sides of moral issues | Mediator (Moral Curiosity / MCS) |
| 74 | `MCS_4_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - It is always interesting to hear about people’s moral positions on issues | Mediator (Moral Curiosity / MCS) |
| 75 | `MCS_5_MU` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I make it a priority to understand the values of the people I disagree with | Mediator (Moral Curiosity / MCS) |
| 76 | `MCS_6_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - It’s fun to discuss “outlandish” moral questions like whether we should stop having children and let humanity go extinct | Mediator (Moral Curiosity / MCS) |
| 77 | `MCS_7_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - There are moral arguments or ideas that are fascinating to think about even if they are wrong | Mediator (Moral Curiosity / MCS) |
| 78 | `MCS_8_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I often think about how I would behave in morally gray situations | Mediator (Moral Curiosity / MCS) |
| 79 | `MCS_9_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I sometimes find myself exploring (e.g., thinking, reading, or talking about) unusual moral questions | Mediator (Moral Curiosity / MCS) |
| 80 | `MCS_10_MN` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I like finding out what people are thinking when they behave immorally | Mediator (Moral Curiosity / MCS) |
| 81 | `MCS_11_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I subscribe to podcasts or blogs to hear opposing viewpoints | Mediator (Moral Curiosity / MCS) |
| 82 | `MCS_12_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I intentionally express my views around people who might disagree with me | Mediator (Moral Curiosity / MCS) |
| 83 | `MCS_13_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I’ve gotten into trouble for discussing moral ideas others may find objectionable | Mediator (Moral Curiosity / MCS) |
| 84 | `MCS_14_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I like stirring the pot and getting people to talk about thorny moral questions | Mediator (Moral Curiosity / MCS) |
| 85 | `MCS_15_CA` | Read each of the following statements and decide how much you agree with each according to your beliefs and experiences. - I intentionally follow people on social media who have moral views I disagree with | Mediator (Moral Curiosity / MCS) |
| 86 | `Moral Objectivism ` | Do you believe that, in general, the answers to moral questions are objectively right or wrong, or they are based people's subjective opinions and preferences? | Mediator (Belief in Moral Objectivity) |
| 87 | `AI Authority` | Do you believe that chatbots/ AI assistants are trusted authorities to give moral advice? | Mediator (Perceived Authority of AI) |
| 88 | `Anthropomorphism_1` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Fake:Natural | Mediator (Anthropomorphism / Godspeed) |
| 89 | `Anthropomorphism_2` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Machinelike:Humanlike | Mediator (Anthropomorphism / Godspeed) |
| 90 | `Anthropomorphism_3` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Unconcious:Concious | Mediator (Anthropomorphism / Godspeed) |
| 91 | `Anthropomorphism_4` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Artificial:Lifelike | Mediator (Anthropomorphism / Godspeed) |
| 92 | `Anthropomorphism_5` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Speaking rigidly:Speaking elegantly | Mediator (Anthropomorphism / Godspeed) |
| 93 | `Animacy_1` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Dead:Alive | Collected, not reported |
| 94 | `Animacy_2` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Stagnant:Lively | Collected, not reported |
| 95 | `Animacy_3` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Mechanical:Organic | Collected, not reported |
| 96 | `Animacy_4` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Artificial:Lifelike | Collected, not reported |
| 97 | `Animacy_5` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Inert:Interactive | Collected, not reported |
| 98 | `Animacy_6` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Apathetic:Responsive | Collected, not reported |
| 99 | `Likeability_1` | Please rate your impression on Chatbot/ AI Assistants on these scales - Dislike:Like | Collected, not reported |
| 100 | `Likeability_2` | Please rate your impression on Chatbot/ AI Assistants on these scales - Unfriendly:Friendly | Collected, not reported |
| 101 | `Likeability_3` | Please rate your impression on Chatbot/ AI Assistants on these scales - Unkind:Kind | Collected, not reported |
| 102 | `Likeability_4` | Please rate your impression on Chatbot/ AI Assistants on these scales - Unpleasant:Pleasant | Collected, not reported |
| 103 | `Likeability_5` | Please rate your impression on Chatbot/ AI Assistants on these scales - Awful:Nice | Collected, not reported |
| 104 | `Intelligence_1` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Incompetent:Competent | Collected, not reported |
| 105 | `Intelligence_2` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Ignorant:Knowledgeable | Collected, not reported |
| 106 | `Intelligence_3` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Irresponsible:Responsible | Collected, not reported |
| 107 | `Intelligence_4` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Unitelligent:Intelligent | Collected, not reported |
| 108 | `Intelligence_5` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Foollish:Sensible | Collected, not reported |
| 109 | `Safety_1` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Anxious:Relaxed | Collected, not reported |
| 110 | `Safety_2` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Agitated:Calm | Collected, not reported |
| 111 | `Safety_3` | Please rate your impression on Chatbot/ AI Assistants on these scales: - Surprised:Still | Collected, not reported |
| 112 | `FNES_1` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I worry about what other people will think of me even when I know it doesn't make any difference. | Mediator (Fear of Negative Evaluation / FNES) |
| 113 | `FNES_2_R` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I am unconcerned even if I know people are forming an unfavorable impression of me. | Mediator (Fear of Negative Evaluation / FNES) |
| 114 | `FNES_3` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I am frequently afraid of other people noticing my shortcomings. | Mediator (Fear of Negative Evaluation / FNES) |
| 115 | `FNES_4_R` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I rarely worry about what kind of impression I am making on someone. | Mediator (Fear of Negative Evaluation / FNES) |
| 116 | `FNES_5` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I am afraid others will not approve of me. | Mediator (Fear of Negative Evaluation / FNES) |
| 117 | `FNES_6` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I am afraid that people will find fault with me. | Mediator (Fear of Negative Evaluation / FNES) |
| 118 | `FNES_7_R` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - Other people's opinions of me do not bother me. | Mediator (Fear of Negative Evaluation / FNES) |
| 119 | `FNES_8` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - When I am talking to someone, I worry about what they may be thinking about me. | Mediator (Fear of Negative Evaluation / FNES) |
| 120 | `FNES_9` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I am usually worried about what kind of impression I make. | Mediator (Fear of Negative Evaluation / FNES) |
| 121 | `FNES_10_R` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - If I know someone is judging me, it has little effect on me. | Mediator (Fear of Negative Evaluation / FNES) |
| 122 | `FNES_11` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - Sometimes I think I am too concerned with what other people think of me. | Mediator (Fear of Negative Evaluation / FNES) |
| 123 | `FNES_12` | Read each of the following statements carefully and indicate how characteristic it is of you according to the following scale: - I often worry that I will say or do the wrong things. | Mediator (Fear of Negative Evaluation / FNES) |
| 124 | `SR_1_R` | How much do you agree with the below statements? - I don’t often think about my thoughts | Mediator (Self-Reflection / SRIS) |
| 125 | `SR_2_R` | How much do you agree with the below statements? - I rarely spend time in self-reflection | Mediator (Self-Reflection / SRIS) |
| 126 | `SR_3` | How much do you agree with the below statements? - I frequently examine my feelings | Mediator (Self-Reflection / SRIS) |
| 127 | `SR_4_R` | How much do you agree with the below statements? - I don’t really think about why I behave in the way that I do | Mediator (Self-Reflection / SRIS) |
| 128 | `SR_5` | How much do you agree with the below statements? - I frequently take time to reflect on my thoughts | Mediator (Self-Reflection / SRIS) |
| 129 | `SR_6` | How much do you agree with the below statements? - I often think about the way I feel about things | Mediator (Self-Reflection / SRIS) |
| 130 | `SR_7_R` | How much do you agree with the below statements? - I am not really interested in analyzing my behavior | Mediator (Self-Reflection / SRIS) |
| 131 | `SR_8` | How much do you agree with the below statements? - It is important to me to evaluate the things that I do | Mediator (Self-Reflection / SRIS) |
| 132 | `SR_9` | How much do you agree with the below statements? - I am very interested in examining what I think about | Mediator (Self-Reflection / SRIS) |
| 133 | `SR_10` | How much do you agree with the below statements? - It is important to me to try to understand what my feelings mean | Mediator (Self-Reflection / SRIS) |
| 134 | `SR_11` | How much do you agree with the below statements? - I have a definite need to understand the way that my mind works | Mediator (Self-Reflection / SRIS) |
| 135 | `SR_12` | How much do you agree with the below statements? - It is important to me to be able to understand how my thoughts arise | Mediator (Self-Reflection / SRIS) |
| 136 | `IN_1` | How much do you agree with the below statements? - I am usually aware of my thoughts | Collected, not reported |
| 137 | `IN_2_R` | How much do you agree with the below statements? - I’m often confused about the way that I really feel about things | Collected, not reported |
| 138 | `IN_3` | How much do you agree with the below statements? - I usually have a very clear idea about why I’ve behaved in a certain way | Collected, not reported |
| 139 | `IN_4_R` | How much do you agree with the below statements? - I’m often aware that I’m having a feeling, but I often don’t quite know what it is | Collected, not reported |
| 140 | `IN_5_R` | How much do you agree with the below statements? - My behavior often puzzles me | Collected, not reported |
| 141 | `IN_6_R` | How much do you agree with the below statements? - Thinking about my thoughts makes me more confused | Collected, not reported |
| 142 | `IN_7_R` | How much do you agree with the below statements? - Often I find it difficult to make sense of the way I feel about things | Collected, not reported |
| 143 | `IN_8` | How much do you agree with the below statements? - I usually know why I feel the way I do | Collected, not reported |
| 144 | `MFQ_2_Care_1` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - Caring for people who have suffered is an important virtue. | Collected, not reported |
| 145 | `MFQ_2_Equality_1` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - The world would be a better place if everyone made the same amount of money. | Collected, not reported |
| 146 | `MFQ_2_Proportionality_1` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think people who are more hardworking should end up with more money. | Collected, not reported |
| 147 | `MFQ_2_Loyalty_1` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think children should be taught to be loyal to their country. | Collected, not reported |
| 148 | `MFQ_2_Purity_1` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think the human body should be treated like a temple, housing something sacred within. | Collected, not reported |
| 149 | `MFQ_2_Care_2` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I believe that compassion for those who are suffering is one of the most crucial virtues. | Collected, not reported |
| 150 | `MFQ_2_Equality_2` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - Our society would have fewer problems if people had the same income. | Collected, not reported |
| 151 | `MFQ_2_Proportionality_2` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think people should be rewarded in proportion to what they contribute. | Collected, not reported |
| 152 | `MFQ_2_Loyalty_2` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - It upsets me when people have no loyalty to their country. | Collected, not reported |
| 153 | `MFQ_2_Authority_2` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I feel that most traditions serve a valuable function in keeping society orderly. | Mediator (Deference to Authority / MFQ-2) |
| 154 | `MFQ_2_Purity_2` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I believe chastity is an important virtue. | Collected, not reported |
| 155 | `MFQ_2_Care_3` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - We should all care for people who are in emotional pain. | Collected, not reported |
| 156 | `MFQ_2_Equality_3` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I believe that everyone should be given the same quantity of resources in life. | Collected, not reported |
| 157 | `MFQ_2_Proportionality_3` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - The effort a worker puts into a job ought to be reflected in the size of a raise they receive. | Collected, not reported |
| 158 | `MFQ_2_Loyalty_3` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - Everyone should love their own community. | Collected, not reported |
| 159 | `MFQ_2_Authority_3` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think obedience to parents is an important virtue. | Mediator (Deference to Authority / MFQ-2) |
| 160 | `MFQ_2_Purity_3` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - It upsets me when people use foul language like it is nothing. | Collected, not reported |
| 161 | `MFQ_2_Care_4` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I am empathetic toward those people who have suffered in their lives. | Collected, not reported |
| 162 | `MFQ_2_Equality_4` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I believe it would be ideal if everyone in society wound up with roughly the same amount of money. | Collected, not reported |
| 163 | `MFQ_2_Proportionality_4` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - It makes me happy when people are recognized on their merits. | Collected, not reported |
| 164 | `MFQ_2_Loyalty_4` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - Everyone should defend their country, if called upon. | Collected, not reported |
| 165 | `MFQ_2_Authority_4` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - We all need to learn from our elders. | Mediator (Deference to Authority / MFQ-2) |
| 166 | `MFQ_2_Purity_4` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - If I found out that an acquaintance had an unusual but harmless sexual fetish I would feel uneasy about them. | Collected, not reported |
| 167 | `MFQ_2_Care_5` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - Everyone should try to comfort people who are going through something hard. | Collected, not reported |
| 168 | `MFQ_2_Equality_5` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - When people work together toward a common goal, they should share the rewards equally, even if some worked harder on it. | Collected, not reported |
| 169 | `MFQ_2_Proportionality_5` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - In a fair society, those who work hard should live with higher standards of living. | Collected, not reported |
| 170 | `MFQ_2_Loyalty_5` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - Everyone should feel proud when a person in their community wins in an international competition. | Collected, not reported |
| 171 | `MFQ_2_Authority_5` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I believe that one of the most important values to teach children is to have respect for authority. | Mediator (Deference to Authority / MFQ-2) |
| 172 | `MFQ_2_Purity_5` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - People should try to use natural medicines rather than chemically identical human-made ones. | Collected, not reported |
| 173 | `MFQ_2_Care_6` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - It pains me when I see someone ignoring the needs of another human being. | Collected, not reported |
| 174 | `MFQ_2_Equality_6` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I get upset when some people have a lot more money than others in my country. | Collected, not reported |
| 175 | `MFQ_2_Proportionality_6` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I feel good when I see cheaters get caught and punished. | Collected, not reported |
| 176 | `MFQ_2_Loyalty_6` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I believe the strength of a sports team comes from the loyalty of its members to each other. | Collected, not reported |
| 177 | `MFQ_2_Authority_6` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think having a strong leader is good for society. | Mediator (Deference to Authority / MFQ-2) |
| 178 | `MFQ_2_Purity_6` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I admire people who keep their virginity until marriage. | Collected, not reported |
| 179 | `MFQ_2_Authority_1` | For each of the statements below, please indicate how well each statement describes you or your opinions. Response options: Does not describe me at all - I think it is important for societies to cherish their traditional values. | Mediator (Deference to Authority / MFQ-2) |
| 180 | `MAC-Q_1` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone acted to protect their family. | Collected, not reported |
| 181 | `MAC-Q_2` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone helped a member of their family. | Collected, not reported |
| 182 | `MAC-Q_3` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone’s action showed love for their family. | Collected, not reported |
| 183 | `MAC-Q_4` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone acted in a way that helped their community. | Collected, not reported |
| 184 | `MAC-Q_5` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone helped a member of their community. | Collected, not reported |
| 185 | `MAC-Q_6` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone worked to unite a community. | Collected, not reported |
| 186 | `MAC-Q_7` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone did what they had agreed to do. | Collected, not reported |
| 187 | `MAC-Q_8` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone kept their promise. | Collected, not reported |
| 188 | `MAC-Q_9` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone proved that they could be trusted. | Collected, not reported |
| 189 | `MAC-Q_10` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone acted heroically. | Collected, not reported |
| 190 | `MAC-Q_11` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone showed courage in the face of adversity. | Collected, not reported |
| 191 | `MAC-Q_12` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone was brave. | Collected, not reported |
| 192 | `MAC-Q_13` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone deferred to those in authority. | Mediator (Deference to Authority / MAC-Q) |
| 193 | `MAC-Q_14` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone disobeyed orders. | Mediator (Deference to Authority / MAC-Q) |
| 194 | `MAC-Q_15` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone showed respect for authority. | Mediator (Deference to Authority / MAC-Q) |
| 195 | `MAC-Q_16` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone kept the best part for themselves. | Collected, not reported |
| 196 | `MAC-Q_17` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone showed favouritism. | Collected, not reported |
| 197 | `MAC-Q_18` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone took more than others. | Collected, not reported |
| 198 | `MAC-Q_19` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone vandalised another person’s property. | Collected, not reported |
| 199 | `MAC-Q_20` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone kept something that didn’t belong to them. | Collected, not reported |
| 200 | `MAC-Q_21` | When you decide whether something is right or wrong, to what extent are the following considerations relevant to your thinking? (0–100; not at all relevant, not very relevant, slightly relevant, somewhat relevant, very relevant, extremely relevant) - Whether or not someone’s property was damaged. | Collected, not reported |
| 201 | `factual_resp` | What is the number that comes immediately before 23? | Attention check |
| 202 | `Religiosity` | To what extent do you consider yourself to be religious? | Predictor |
| 203 | `Spirituality` | To what extent do you consider yourself to be spiritual? | Collected, not reported |
| 204 | `God` | Do you believe in God? - Selected Choice | Demographic |
| 205 | `God_3_TEXT` | Do you believe in God? - Other - Text | Demographic |
| 206 | `Faith_1` | Which of the following religious affiliations do you identify with? - Selected Choice - Agnostic | Demographic |
| 207 | `Faith_2` | Which of the following religious affiliations do you identify with? - Selected Choice - Atheist | Demographic |
| 208 | `Faith_3` | Which of the following religious affiliations do you identify with? - Selected Choice - Buddhist | Demographic |
| 209 | `Faith_4` | Which of the following religious affiliations do you identify with? - Selected Choice - Christian | Demographic |
| 210 | `Faith_5` | Which of the following religious affiliations do you identify with? - Selected Choice - Hindu | Demographic |
| 211 | `Faith_6` | Which of the following religious affiliations do you identify with? - Selected Choice - Jewish | Demographic |
| 212 | `Faith_7` | Which of the following religious affiliations do you identify with? - Selected Choice - Muslim | Demographic |
| 213 | `Faith_8` | Which of the following religious affiliations do you identify with? - Selected Choice - Sikh | Demographic |
| 214 | `Faith_9` | Which of the following religious affiliations do you identify with? - Selected Choice - Other | Demographic |
| 215 | `Faith_9_TEXT` | Which of the following religious affiliations do you identify with? - Other - Text | Demographic |
| 216 | `Service` | How often do you attend religious services? | Predictor (R_Score component) |
| 217 | `Pray` | How often do you pray? | Predictor (R_Score component) |
| 218 | `Age` | What is your age (in years)? | Covariate / Demographic |
| 219 | `Gender` | With which gender do you identify? - Selected Choice | Demographic |
| 220 | `Gender_4_TEXT` | With which gender do you identify? - An identity not listed - Text | Demographic |
| 221 | `Race_Ethnicity_1` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Black or African American | Demographic |
| 222 | `Race_Ethnicity_2` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - East Asian | Demographic |
| 223 | `Race_Ethnicity_3` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Hispanic or Latina/o/x/e | Demographic |
| 224 | `Race_Ethnicity_4` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Indigenous American, American Indian, or Alaska Native | Demographic |
| 225 | `Race_Ethnicity_5` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Middle Eastern or North African | Demographic |
| 226 | `Race_Ethnicity_6` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Native Hawaiian or other Pacific Islander | Demographic |
| 227 | `Race_Ethnicity_7` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - South Asian | Demographic |
| 228 | `Race_Ethnicity_8` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Southeast Asian | Demographic |
| 229 | `Race_Ethnicity_9` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - White | Demographic |
| 230 | `Race_Ethnicity_10` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Other | Demographic |
| 231 | `Race_Ethnicity_11` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Prefer not to disclose | Demographic |
| 232 | `Race_Ethnicity_10_TEXT` | Please indicate how you identify yourself (Choose all that apply). - Other - Text | Demographic |
| 233 | `Income` | What is your household income per year? | Covariate / Demographic |
| 234 | `Education` | What is the highest level of education you have received? (If you’re currently enrolled in school, please indicate the highest degree you have received. ) | Covariate / Demographic |
| 235 | `SES` | Think of this ladder as representing where people stand in the United States. At the top of the ladder are the people who have the most money, most education, and most respected jobs. At the bottom are the people who have the least money, least education, and least respected jobs/ no job. The higher up you are on this ladder, the closer you are to the people at the very top. The lower you are, the closer you are to the people at the very bottom.          Please indicate below where you would place yourself on this ladder. | Covariate / Demographic |
| 236 | `Political_party` | In politics today, do you consider yourself a: - Selected Choice | Collected, not reported |
| 237 | `Political_party_4_TEXT` | In politics today, do you consider yourself a: - Something else - Text | Collected, not reported |
| 238 | `Political_overall` | Politically, how liberal or conservative are you? | Covariate / Demographic |


Study 2 collected-but-not-reported columns include: (a) Godspeed subscales beyond Anthropomorphism — Animacy (cols 93–98), Likeability (cols 99–103), Intelligence (cols 104–108), Safety (cols 109–111); (b) Insight subscale of the SRIS (cols 136–143) — only the Self-Reflection subscale was used; (c) MFQ-2 subscales beyond Authority — Care, Equality, Proportionality, Loyalty, Purity; (d) MAC-Q items beyond the two Deference items (cols 192, 194); (e) Spirituality (col 203).

## Pilot 1 (P1.csv) — 42 columns

| # | Column Name | Description (Row 2) | Purpose |
|---|-------------|---------------------|---------|
| 1 | `StartDate` | Start Date | Metadata |
| 2 | `Finished` | Finished | Response filter |
| 3 | `DistributionChannel` | Distribution Channel | Response filter |
| 4 | `Q1` | Consent form | Response filter |
| 5 | `110 Rules_111` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Not at all morally relevant". | Attention check |
| 6 | `110 Rules_112` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Slightly morally irrelevant". | Attention check |
| 7 | `110 Rules_113` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Slightly morally relevant". | Attention check |
| 8 | `110 Rules_114` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Moderately morally relevant". | Attention check |
| 9 | `110 Rules_115` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Moderately morally irrelevant". | Attention check |
| 10 | `110 Rules_116` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Neither morally relevant nor morally irrelevant". | Attention check |
| 11 | `110 Rules_117` | Below you will read 110 rules. For each rule, please answer the question: How morally relevant do you think this rule is in modern society? - Attention Check: Choose "Extremely morally relevant". | Attention check |
| 12 | `Moral Source _13` | How much do you usually seek moral guidance from the below sources? - Chatbot/ AI assistant | Outcome |
| 13 | `Age` | What is your age (in years)? | Covariate / Demographic |
| 14 | `Gender` | With which gender do you identify? - Selected Choice | Demographic |
| 15 | `Race_Ethnicity_1` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Black or African American | Demographic |
| 16 | `Race_Ethnicity_2` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - East Asian | Demographic |
| 17 | `Race_Ethnicity_3` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Hispanic or Latina/o/x/e | Demographic |
| 18 | `Race_Ethnicity_4` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Indigenous American, American Indian, or Alaska Native | Demographic |
| 19 | `Race_Ethnicity_5` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Middle Eastern or North African | Demographic |
| 20 | `Race_Ethnicity_6` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Native Hawaiian or other Pacific Islander | Demographic |
| 21 | `Race_Ethnicity_7` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - South Asian | Demographic |
| 22 | `Race_Ethnicity_8` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Southeast Asian | Demographic |
| 23 | `Race_Ethnicity_9` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - White | Demographic |
| 24 | `Race_Ethnicity_10` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Other | Demographic |
| 25 | `Race_Ethnicity_11` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Prefer not to disclose | Demographic |
| 26 | `Race_Ethnicity_10_TEXT` | Please indicate how you identify yourself (Choose all that apply). - Other - Text | Demographic |
| 27 | `Income` | What is your household income per year? | Covariate / Demographic |
| 28 | `Education` | What is the highest level of education you have received? (If you’re currently enrolled in school, please indicate the highest degree you have received. ) | Covariate / Demographic |
| 29 | `SES` | Think of this ladder as representing where people stand in the United States. At the top of the ladder are the people who have the most money, most education, and most respected jobs. At the bottom are the people who have the least money, least education, and least respected jobs/ no job. The higher up you are on this ladder, the closer you are to the people at the very top. The lower you are, the closer you are to the people at the very bottom.          Please indicate below where you would place yourself on this ladder. | Covariate / Demographic |
| 30 | `Political_overall` | Politically, how liberal or conservative are you? | Covariate / Demographic |
| 31 | `Religiosity` | To what extent do you consider yourself to be religious? | Predictor |
| 32 | `God` | Do you believe in God? - Selected Choice | Demographic |
| 33 | `Faith_1` | Which of the following religious affiliations do you identify with? - Selected Choice - Agnostic | Demographic |
| 34 | `Faith_2` | Which of the following religious affiliations do you identify with? - Selected Choice - Atheist | Demographic |
| 35 | `Faith_3` | Which of the following religious affiliations do you identify with? - Selected Choice - Buddhist | Demographic |
| 36 | `Faith_4` | Which of the following religious affiliations do you identify with? - Selected Choice - Christian | Demographic |
| 37 | `Faith_5` | Which of the following religious affiliations do you identify with? - Selected Choice - Hindu | Demographic |
| 38 | `Faith_6` | Which of the following religious affiliations do you identify with? - Selected Choice - Jewish | Demographic |
| 39 | `Faith_7` | Which of the following religious affiliations do you identify with? - Selected Choice - Muslim | Demographic |
| 40 | `Faith_8` | Which of the following religious affiliations do you identify with? - Selected Choice - Sikh | Demographic |
| 41 | `Faith_9` | Which of the following religious affiliations do you identify with? - Selected Choice - Other | Demographic |
| 42 | `Faith_9_TEXT` | Which of the following religious affiliations do you identify with? - Other - Text | Demographic |


## Pilot 2 (P2.csv) — 35 columns

| # | Column Name | Description (Row 2) | Purpose |
|---|-------------|---------------------|---------|
| 1 | `StartDate` | Start Date | Metadata |
| 2 | `Finished` | Finished | Response filter |
| 3 | `DistributionChannel` | Distribution Channel | Response filter |
| 4 | `Q1` | Consent form | Response filter |
| 5 | `Q115_15` | How much do you look toward each of the below sources for moral advice and guidance? - Chatbot/ AI assistant | Outcome |
| 6 | `Age` | What is your age (in years)? | Covariate / Demographic |
| 7 | `Gender` | With which gender do you identify? - Selected Choice | Demographic |
| 8 | `Race_Ethnicity_1` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Black or African American | Demographic |
| 9 | `Race_Ethnicity_2` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - East Asian | Demographic |
| 10 | `Race_Ethnicity_3` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Hispanic or Latina/o/x/e | Demographic |
| 11 | `Race_Ethnicity_4` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Indigenous American, American Indian, or Alaska Native | Demographic |
| 12 | `Race_Ethnicity_5` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Middle Eastern or North African | Demographic |
| 13 | `Race_Ethnicity_6` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Native Hawaiian or other Pacific Islander | Demographic |
| 14 | `Race_Ethnicity_7` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - South Asian | Demographic |
| 15 | `Race_Ethnicity_8` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Southeast Asian | Demographic |
| 16 | `Race_Ethnicity_9` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - White | Demographic |
| 17 | `Race_Ethnicity_10` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Other | Demographic |
| 18 | `Race_Ethnicity_11` | Please indicate how you identify yourself (Choose all that apply). - Selected Choice - Prefer not to disclose | Demographic |
| 19 | `Race_Ethnicity_10_TEXT` | Please indicate how you identify yourself (Choose all that apply). - Other - Text | Demographic |
| 20 | `Income` | What is your household income per year? | Covariate / Demographic |
| 21 | `Education` | What is the highest level of education you have received? (If you’re currently enrolled in school, please indicate the highest degree you have received. ) | Covariate / Demographic |
| 22 | `SES` | Think of this ladder as representing where people stand in the United States. At the top of the ladder are the people who have the most money, most education, and most respected jobs. At the bottom are the people who have the least money, least education, and least respected jobs/ no job. The higher up you are on this ladder, the closer you are to the people at the very top. The lower you are, the closer you are to the people at the very bottom.          Please indicate below where you would place yourself on this ladder. | Covariate / Demographic |
| 23 | `Political_overall` | Politically, how liberal or conservative are you? | Covariate / Demographic |
| 24 | `Religiosity` | To what extent do you consider yourself to be religious? | Predictor |
| 25 | `God` | Do you believe in God? - Selected Choice | Demographic |
| 26 | `Faith_1` | Which of the following religious affiliations do you identify with? - Selected Choice - Agnostic | Demographic |
| 27 | `Faith_10` | Which of the following religious affiliations do you identify with? - Selected Choice - Atheist | Demographic |
| 28 | `Faith_11` | Which of the following religious affiliations do you identify with? - Selected Choice - Buddhist | Demographic |
| 29 | `Faith_12` | Which of the following religious affiliations do you identify with? - Selected Choice - Christian | Demographic |
| 30 | `Faith_13` | Which of the following religious affiliations do you identify with? - Selected Choice - Hindu | Demographic |
| 31 | `Faith_2` | Which of the following religious affiliations do you identify with? - Selected Choice - Jewish | Demographic |
| 32 | `Faith_3` | Which of the following religious affiliations do you identify with? - Selected Choice - Muslim | Demographic |
| 33 | `Faith_6` | Which of the following religious affiliations do you identify with? - Selected Choice - Sikh | Demographic |
| 34 | `Faith_8` | Which of the following religious affiliations do you identify with? - Selected Choice - Other | Demographic |
| 35 | `Faith_8_TEXT` | Which of the following religious affiliations do you identify with? - Other - Text | Demographic |
