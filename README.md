# In God We Trust, In AI We Ask

**Religiosity and Moral Advice Seeking in the Age of Generative AI**

Helen Huiting Zheng¹*, Kyle Fiore Law², Sara M Haman¹, David DeSteno³, Liane Young¹

¹ Department of Psychology and Neuroscience, Boston College
² School of Sustainability, College of Global Futures, Arizona State University
³ Department of Psychology, Northeastern University

*Corresponding author: helen.zheng@bc.edu

## Abstract

As AI chatbots increasingly enter domains long considered uniquely human, such as moral guidance, questions arise about how they intersect with traditional frameworks like religion. While it is commonly assumed that religious individuals would resist AI intrusion in the moral sphere, we found the opposite. Across two pre-registered studies with a stratified U.S. sample (*N* = 695), both self-reported religious engagement and religious belief consistently predict greater openness to seeking moral advice from AI systems. Parallel mediation models indicate that this relationship is mediated primarily by a broader disposition to seek moral guidance from multiple sources, and secondarily by perceived authority of AI as moral advisors. Rather than shielding individuals from AI's appeal in the moral domain, religiosity may systematically facilitate it. These findings carry broad societal implications for AI-mediated moral guidance, a new challenge requiring coordinated attention from technologists, faith communities, and policymakers alike.

## Repository Structure

- `*.qmd` — Quarto manuscript source files
- `R/` — Analysis scripts (data loading, tables, plots, helpers)
- `Data Collection/` — Data files (CSV) and codebook
- `references.bib` — Bibliography
- [Live HTML Website](https://helenzheng.me/in-god-we-trust-in-ai-we-ask/) — Full rendered manuscript with supplementary materials

## Reproducibility

This repository is designed to be fully self-contained. Assuming you have the prerequisites installed, downloading this repository and opening the project file will automatically align all directories and scripts necessary to reproduce the manuscript and analyses.

### Prerequisites
- **R and RStudio**: Install the latest version of [R](https://cran.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/).
- **Quarto**: Included by default in newer versions of RStudio, but can be downloaded explicitly from [quarto.org](https://quarto.org/docs/get-started/).

### Getting Started

1. **Download the Repository**:
   - Via Git: `git clone https://github.com/helenhzheng/in-god-we-trust-in-ai-we-ask.git`
   - Or click **Code -> Download ZIP** on GitHub and extract the folder.

2. **Open the Project Structure**:
   - Double-click the `Manuscript.Rproj` file to open the project in RStudio. 
   - *Note: Opening the .Rproj file is critical. It automatically sets your exact working directory, ensuring all relative loading paths to the data files (e.g., `./Data Collection/`) work properly without manual configuration.*

3. **Render the Project**:
   - In RStudio, open the **Terminal** tab (next to the Console). 
   - To render the entire HTML website interface locally, run:
     ```bash
     quarto render
     ```
   - To render the submission-ready Microsoft Word manuscript (`manuscript_clean.docx`), run:
     ```bash
     quarto render manuscript_clean.qmd
     ```
   - To render the supplementary materials document (`supplementary_clean.docx`), run:
     ```bash
     quarto render supplementary_clean.qmd
     ```

> ⏱️ **Note on Render Times**: Executing `quarto render` or rendering the supplementary documents can take **over an hour** to complete. This is entirely normal. The codebase runs heavy parallel mediation models and 5000-iteration bootstrap simulations for the network paths in the background. Please let it run uninterrupted.
>
> ⚡ **Faster Testing / Iteration**: If you are simply testing the code and want it to render quickly, you can reduce the number of bootstrap simulations. Open `question3.qmd` and `supplementary.qmd`, and do a "Find and Replace" for `5000` (changing it to a smaller number like `100` or `50`). Be sure to change it in both the `sims = 5000` arguments and the Lavaan `bootstrap = 5000` arguments.

> **Automated Package Installation**: The first time you render the project, the scripts will quietly identify, download, and install any missing R dependencies required for the analysis directly from CRAN. 

> ⚠️ **Data Integrity Warning:** Do NOT open or edit the CSV files located in `Data Collection/` using Microsoft Excel. Excel alters encodings, dates, and numbers upon saving, which will catastrophically break the `data-loading.R` pipeline. Please use a plain text editor, VS Code, or RStudio for viewing raw data.

## License

This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](LICENSE).
