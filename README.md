**Mayo Pharmacogenomics Workflow 06/26/23**
**G. Scott**

![Alt text](https://github.com/GriffinBINF/LaryLabPharmacogenomics/blob/main/plots/mayo_pharmacogenomics.png)
![Alt text](https://github.com/GriffinBINF/LaryLabPharmacogenomics/blob/main/plots/long_fhs_plot.png)
![Alt text](https://github.com/GriffinBINF/LaryLabPharmacogenomics/blob/main/plots/cs_fhs_plot.png)

**Required Files**

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

Results files from Dr. Beth Atkinson - HDAC\_dxa\_fit5.csv, imp\_dxa\_fit5.csv

**Environment Management**

The Framingham step 1.2 script create\_cand\_gene.R must be run from the command line as it relies on vcftools. The simplest way to account for this is to create a conda environment for this project and install vcftools.

Follow the documentation [here](https://rc-docs.northeastern.edu/en/latest/software/conda.html) for installing miniconda. You should install miniconda in your work directory above your projects. Then you can initialize a conda environment and enter it using

$conda activate [env name]

and install your desired libraries using

$conda install [packagename]

Next, install R using

conda install -c r r
conda install -c "r/label/archive" r

Next, install r-essentials which is a set of core R packages including dplyr used in this script.

conda install -c r r-essentials

Alternatively you can install just dplyr if you are confident that you wont be using this env for any other work in R.

conda install -c conda-forge r-dplyr

Finally, install vcftools using one of the following.

conda install -c bioconda vcftools
conda install -c "bioconda/label/cf201901" vcftools

Verify that you have vcftools installed correctly by running vcftools in the command line.

Framingham

1. Preprocessing Genotype Data
  1. WellImputedSNPs.Rmd – Create a list of SNPs that meet the imputation threshold (modified for Discovery server)

**Output: WellImputedSNPs.txt**

  1. create\_cand\_gene.R – Create a vcf file for each gene region. **Run using the running\_create\_cand\_gene\_vcf.sh script from command line after following vcftools install steps.**
    1. Filters for 2KB upstream to 0.5KB downstream.
    2. Filters for well imputed SNPs.
    3. Filters for individuals with phenotype data \* idealized for vcf.gz files.
  2. extract\_vcf\_ktn.Rmd
    1. Read in vcf files for each gene.
    2. Convert to tidy format.
    3. Filter for minor allele frequency \> 0.05
    4. Convert genotype to normal, heterozygous, or homozygous alternative.
    5. Write to Rdata format.
1. Build Genotype-Phenotype Files
  1. build\_longitudinal\_phenotype\_files.Rmd – create files consisting of phenotype data for femoral neck and lumbar spine longitudinal data.
  2. build\_cross\_sectional\_phenotype\_files.Rmd – as above but for cross sectional

**Output** : **[groups]\_[bone site]\_[study]\_Pheno\_Data.csv**

  1. build\_genoPheno\_longitudinalRmd – Merge genes and phenotype data into one file.
  2. build\_genoPheno\_cross\_sectional.Rmd – as above but for cross sectional

**Output** : […] **CandidateGenes.Rdata**

1. Fit Model
  1. run\_lmer\_longitudinal.Rmd – Fit LMER model for longitudinal or cross-sectional data.
  2. run\_lmer\_cross\_sectional.Rmd – cross sectional fit. **If you encounter the error an error of the form "could not extract variance" check the package dependencies for emmeans. You might be missing one of the required packages so it is best to make sure.**

**Output: […]AllSNPs\_LMER\_results\_female.csv**

**[…]AllSNPs\_LMER\_emmeans\_female.csv**

Mayo

1. Clean Mayo Results
  1. clean\_lab.Rmd, clean\_dxa.Rmd – DXA BMD and Serum lab results consist of imputed and non-imputed tables of slightly different formats. These two scripts repackage that data and assign consistent naming, position, and other identifying variables to SNPs.

**Output: cleaned\_dxa.csv, cleaned\_imputed\_dxa.csv**

**cleaned\_lab.csv, cleaned\_imputed\_lab.csv**

1. Merge Mayo Results By Drug, Identify Mayo SNPs
  1. merge\_mayo\_data\_id\_snps.Rmd – Merge imputed and non-imputed results, arrange results by treatment group, identify SNPs used in mayo results (23 across _ADRB1, ADRB2, HDAC4_.

**Output: all\_mayo\_BMD.csv**

**all\_mayo\_LAB.csv**

**all\_mayo\_SNPs.csv**

1. Preprocess Mayo Data
  1. pre\_process\_mayo\_data.Rmd – Process Mayo data such that each and bone site is labeled separately for easier filtering later on. Flip signs of non-imputed effect estimates so that they match the allele being measured in the imputed effect estimates. Then flip all of them so that they match the Framingham results. This is because Mayo is measuring the interaction effect from reference allele dose whereas Framingham is counting alternate alleles.

**Output: processedBMD.csv**

**processedLAB.csv**

Plotting and Visualization

1. Plot Effect Estimates
  1. plot\_mayo\_and\_fhsRmd

**Output: None**

1. Plot Estimated Marginal Means (EMmeans) (Currently unused)
  1. build\_emmeans\_plots\_v2.Rmd
