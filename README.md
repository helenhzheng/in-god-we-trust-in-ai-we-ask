# In God We Trust, In AI We Ask

**Religiosity and Moral Advice Seeking in the Age of Generative AI**

Helen Huiting Zheng¹*, Kyle Fiore Law², Sara M Haman¹, David DeSteno³, Liane Young¹

¹ Department of Psychology and Neuroscience, Boston College  
² Department of Psychology, University of Utah  
³ Department of Psychology, Northeastern University  

*Corresponding author: helen.zheng@bc.edu

## Abstract

As AI chatbots increasingly enter domains long considered uniquely human, such as moral guidance, questions arise about how they intersect with traditional frameworks like religion. While it is commonly assumed that religious individuals would resist AI intrusion in the moral sphere, we found the opposite. Across two pre-registered studies with a stratified U.S. sample (*N* = 695), both self-reported religious engagement and religious belief were consistently associated with greater openness to seeking moral advice from AI systems. To lay the groundwork for understanding the landscape of psychological factors that may intervene in this relationship, we conducted first-pass parallel mediation analyses using cross-sectional data. These models indicate that the relationship is statistically accounted for primarily by a broader disposition to seek moral guidance from multiple sources, and secondarily by the perceived authority of AI as moral advisors. As we make no causal claims in this study, we invite future experimental work that manipulates these mediators to establish potential causal relationships. Rather than shielding individuals from AI's appeal in the moral domain, this study indicates that religiosity may systematically facilitate it. These findings carry broad societal implications for AI-mediated moral guidance, a new challenge requiring coordinated attention from technologists, faith communities, and policymakers alike.

## Repository Structure

All codebase source files, Quarto documents, R analysis modules, and datasets are organized within the `code/` directory:

- `code/` — Core codebase directory
  - `index.qmd` — Website landing page and abstract
  - `manuscript_clean.qmd` — Full APA 7 submission-ready manuscript document with supplementary materials
  - `qmd/` — Modular Quarto manuscript section files:
    - `introduction.qmd` — Literature review and study overview
    - `methods.qmd` — Materials, measures, and procedure
    - `question1.qmd` — Q1: Does Self-Reported Religiosity Predict Frequency of Seeking Moral Advice from AI Chatbots?
    - `question2.qmd` — Q2: Does Behavioral Religiosity Predict Frequency of Seeking Moral Advice from AI Chatbots?
    - `question3.qmd` — Q3: What Explains the Relationship Between Religiosity and the Frequency of Seeking Moral Advice from AI Chatbots? (Exploratory Indirect Associations)
    - `question4.qmd` — Q4: Does Access to Sources of Moral Advice Moderate the Relationship between Religiosity and Seeking Moral Advice from AI Chatbots? 
    - `discussion.qmd` — General discussion, implications, and limitations
    - `supplementary.qmd` — Full supplementary analyses, robustness checks, and tables
  - `R/` — Standardized modular R analysis scripts:
    - `packages.R` — Package loading and dependency management
    - `colors.R` — Dynamic Okabe-Ito color palette architecture (Color vs. B/W modes)
    - `helpers.R` — Helper functions, APA formatters, and Lavaan SEM extractors
    - `tables.R` — APA table generation functions 
    - `plots.R` — Publication-ready visualization functions 
    - `data-loading.R` — Data loading, cleaning, and composite variable creation
    - `main-analysis.R` — Main analyses precalculation
    - `supplementary.R` — Supplementary-specific functions, pilot analyses, and heatmaps
  - `Data Collection/` — Raw survey datasets (CSV) and codebook
  - `references.bib` — BibTeX reference database
  - `_quarto.yml` — Quarto website configuration
- [Live Project Website](https://helenzheng.me/in-god-we-trust-in-ai-we-ask/) — Full rendered manuscript with supplementary materials

## Reproducibility

This repository is designed to be fully self-contained. Downloading this repository and opening the R project file will automatically align all directories and scripts necessary to reproduce the manuscript and analyses.

### Prerequisites
- **R and RStudio**: Install the latest version of [R](https://cran.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/).
- **Quarto**: Included by default in newer versions of RStudio, and downloadable from [quarto.org](https://quarto.org/docs/get-started/).

### Getting Started

1. **Download the Repository**:
   - Via Git: `git clone https://github.com/helenhzheng/in-god-we-trust-in-ai-we-ask.git`
   - Or click **Code -> Download ZIP** on GitHub and extract the folder.

2. **Open the Project Structure**:
   - Navigate into the `code/` folder and double-click `Manuscript.Rproj` to open the project in RStudio. 
   - *Note: Opening the `code/Manuscript.Rproj` file is critical. It automatically sets your exact working directory, ensuring all relative loading paths to data files (`./Data Collection/`) and R scripts (`./R/`) execute properly.*

3. **Reproduce the Manuscript and Analyses**:
   - To render the submission-ready APA 7 manuscript (`manuscript_clean.docx`), run:
     ```bash
     quarto render manuscript_clean.qmd
     ```

> ⏱️ **Note on Render Times**: Executing `quarto render` or rendering the supplementary documents can take **over an hour** to complete. This is entirely normal. The codebase runs heavy parallel mediation models and 5,000-iteration bootstrap simulations for the network paths in the background. Please let it run uninterrupted.
>
> ⚡ **Faster Testing / Iteration**: Set `BOOTSTRAP_SIMS <- 50` at the top of your setup block or in your R console before rendering to run rapid test builds in seconds instead of waiting for 5,000 bootstrap iterations.
>
> 📦 **Automated Package Installation**: The first time you render the project, the scripts will quietly identify, download, and install any missing R dependencies required for the analysis directly from CRAN. 

> ⚠️ **Data Integrity Warning:** Do NOT open or edit the CSV files located in `code/Data Collection/` using Microsoft Excel. Excel alters encodings, dates, and numbers upon saving, which will break the `data-loading.R` pipeline. Please use a plain text editor, VS Code, or RStudio for viewing raw data.

## License

This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](LICENSE).
