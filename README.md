# LaryLab Pharmacogenomics
Repository for my coding work for Dr. Christine Lary's lab at the Roux Institute during my 2023 co-op. I primarily worked on a study comparing the results of Framingham and Mayo clinic clinical trial data on the pharmacogenetic effect of beta blockers on bone density.


Workflow:  

1. Framingham
  1a. Use code adapted from K. Nevola to create phenotype-genotype files from Framingham offspring cohort data tables for analysis
  1b. Perform linear kinship model to analyze the interaction effect of SNP plus Beta Blocker use on bone density from exam six to exam eight
  *1c. Plot results for each SNP
  1.d Merge framingham model results into Mayo nomeclature and formatting
  
2. Mayo
  *2a. Create unified data table for all mayo data
  *2b. Organize into readable subtables by site, drug, gene
  *2c. Combine with Framingham data and plot SNP effect estimates for bone and lab biomarker results
  *2d. Create emmeans plots for each snp
 
