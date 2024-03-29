
# Genomic Signatures of Oral Microbiome-Associated ARGs for Diagnosing Pancreatic Cancer

## Description
This repository contains the code used in the study "Leveraging genomic signatures of oral microbiome-associated antibiotic resistance genes for diagnosing pancreatic cancer". The study investigates the potential of using genomic signatures associated with antibiotic resistance genes (ARGs) within the oral microbiome for the diagnosis of pancreatic ductal adenocarcinoma (PDAC).

## Contents
- `pipeline.sh`: Shell script for preprocessing, quality control, and alignment of sequencing data.
- `analysis.R`: R script for data analysis, including statistical tests, correlation analysis, visualizations (violin plots, heat maps, PCoA, box plots), CLR transformation, Aitchison and Bray-Curtis distance calculation, Adonis test, and ROC curve analysis.

## How to Use
### Prerequisites
- For `pipeline.sh`:
  - SRA Toolkit for `fastq-dump`
  - Trimmomatic for quality control
  - Bowtie2 and Samtools for alignment
- For `analysis.R`:
  - R with installed packages: `ggpubr`, `pheatmap`, `psych`, `ggplot2`, `ggsignif`, `compositions`, `vegan`, `pROC`

### Running the Scripts
1. **Shell Script (`pipeline.sh`):**
   - Ensure all prerequisite tools are installed and paths in the script are correctly set to match your environment.
   - Place your `.lite.1` files in the directory where you intend to run the script.
   - Run the script in a Unix-like terminal: `bash pipeline.sh`

2. **R Script (`analysis.R`):**
   - Set the working directory to where your data files are located by modifying the `setwd()` function calls in the script.
   - Run the script in R or RStudio.

## Authors
- Xiaojing Shen
- Xiaolin Zhu
- Hairong Liu
- Rongtao Yuan
- Qingyuan Guo
- Peng Zhao (Corresponding Author)

## Contact
For any questions or comments, please contact Peng Zhao at zhaopengyayi@163.com.

## License
This project is open source and available under the MIT License.

## Acknowledgements
This work was supported by the Qingdao Municipal Hospital (Group) Stomatology, Qingdao, Shandong, China, and the Department of Gastroenterology, Qingdao Municipal Hospital, Qingdao, Shandong, China.


