# Mayo Pharmacogenomics Workflow

## Required Files

**Framingham Phenotype Files**

Exam 6 BMD- phs000007.v33.pht000169.v8.p14.c1.t\_bmd\_ex07\_1\_0104s.HMB-IRB-MDS.txt.gz

Exam 8 BMD - phs000007.v33.pht003096.v4.p14.c1.t\_bmdhs\_2008\_1\_0748s.HMB-IRB-MDS.txt.gz

Estrogen Use - phs000007.v33.pht000307.v10.p14.c1.meno1\_8s.HMB-IRB-MDS.txt.gz

Exam 6 Meds - phs000007.v33.pht000035.v11.p14.c1.ex1\_6s.HMB-IRB-MDS.txt.gz

Covariates - phs000007.v33.pht006027.v4.p14.c1.vr\_wkthru\_ex09\_1\_1001s.HMB-IRB-MDS.txt.gz

**Framingham Genotype Files**

SNP Directory - phg000835.v4.FHS\_SHARE\_imputed\_HRC1.marker-info.MULTI/

vcf.gz Directory - phg000835.v4.FHS\_SHARE\_imputed\_HRC1.genotype-calls-vcf.c1/

**Other Framingham**

Pedigree - share\_ped\_052517.csv

**Mayo**

SNP Annotation Master List – mayo\_fram\_snp\_master\_list.csv

## Mayo

1. Clean Mayo Results
  1. clean\_lab.Rmd, clean\_dxa.Rmd – DXA BMD and Serum lab results consist of imputed and non-imputed tables of slightly different formats. These two scripts repackage that data and assign consistent naming, position, and other identifying variables to SNPs.

**Output: cleaned\_dxa.csv, cleaned\_imputed\_dxa.csv,**

**cleaned\_lab.csv, cleaned\_imputed\_lab.csv**

1. Merge Mayo Results By Drug, Identify Mayo SNPs
  1. merge\_mayo\_data\_id\_snps.Rmd – Merge imputed and non-imputed results, arrange results by treatment group, identify SNPs used in mayo results (23 across _ADRB1, ADRB2, HDAC4_.

**Output: all\_mayo\_BMD.csv, all\_mayo\_LAB.csv, all\_mayo\_SNPs.csv**

## Framingham

1. Follow K. Nevola's Workflow - (Code adapted into Rmarkdown files and to run on Discovery)
  1. WellImputedSNPs.Rmd – Create a list of SNPs that meet the imputation threshold (modified for Discovery server)

**Output: WellImputedSNPs.txt**

  1. create\_cand\_gene.Rmd – Create a vcf file for each gene region.
    1. Filters for 2KB upstream to 0.5KB downstream.
    2. Filters for well imputed SNPs.
    3. Filters for individuals with phenotype data \* idealized for vcf.gz files.
  2. extract\_vcf\_ktn.Rmd
    1. Read in vcf files for each gene.
    2. Convert to tidy format.
    3. Filter for minor allele frequency \> 0.05
    4. Convert genotype to normal, heterozygous, or homozygous alternative.
    5. Write to Rdata format.
1. Adapted K. Nevola's Workflow for Longitudinal Data
  1. build\_longitudinal\_phenotype\_files.Rmd – create files consisting of phenotype data for femoral neck and lumbar spine longitudinal data.

**Output** : **Femoral\_Neck\_Pheno\_Data.csv**

  1. build\_genotype\_phenotype\_file.Rmd – Merge genes and phenotype data into one file.

**Output** : **CandidateGenes.Rdata**

1. Run relational matrix LMER
  1. run\_lmer.Rmd – Fit LMER model for longitudinal or cross-sectional data.

## Plotting and Visualization

1. Merge Mayo with Framingham, make Flextables.
  1. build\_merged\_mayo\_fram\_tables.Rmd – Rework Framingham headers to match mayo, merge results, create tables of significant results as .csv and .docx flextable.

**Output: all\_dxa\_ctx\_flex.csv, filtered\_dxa\_plus\_ctx\_flex.csv, cross\_sectional\_flex.csv**

1. Plot Effect Estimates
  1. build\_effect\_estimate\_plot.Rmd

**Output: [Default] All Significant BMD Plus CTX .png**

1. Plot Estimated Marginal Means (EMmeans)
  1. build\_emmeans\_plots\_v2.Rmd
