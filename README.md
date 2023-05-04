Mayo Pharmacogenomics Workflow

Required Files
Framingham Phenotype Files
Exam 6 BMD- phs000007.v33.pht000169.v8.p14.c1.t_bmd_ex07_1_0104s.HMB-IRB-MDS.txt.gz
Exam 8 BMD - phs000007.v33.pht003096.v4.p14.c1.t_bmdhs_2008_1_0748s.HMB-IRB-MDS.txt.gz
Estrogen Use - phs000007.v33.pht000307.v10.p14.c1.meno1_8s.HMB-IRB-MDS.txt.gz
Exam 6 Meds - phs000007.v33.pht000035.v11.p14.c1.ex1_6s.HMB-IRB-MDS.txt.gz
Covariates - phs000007.v33.pht006027.v4.p14.c1.vr_wkthru_ex09_1_1001s.HMB-IRB-MDS.txt.gz

Framingham Genotype Files
Candidate Genes (ADRB1, ADBR2 HDAC4 for this study) – Candidate_Gene_List.csv
SNP Directory - phg000835.v4.FHS_SHARE_imputed_HRC1.marker-info.MULTI/
vcf.gz Directory - phg000835.v4.FHS_SHARE_imputed_HRC1.genotype-calls-vcf.c1/

Other Framingham
Pedigree - share_ped_052517.csv 

Mayo
SNP Annotation Master List – mayo_fram_snp_master_list.csv

Mayo
1.	Clean Mayo Results
1.1.	clean_lab.Rmd, clean_dxa.Rmd – DXA BMD and Serum lab results consist of imputed and non-imputed tables of slightly different formats. These two scripts repackage that data and assign consistent naming, position, and other identifying variables to SNPs.
Output: cleaned_dxa.csv, cleaned_imputed_dxa.csv, 
cleaned_lab.csv, cleaned_imputed_lab.csv

2.	Merge Mayo Results By Drug, Identify Mayo SNPs
2.1.	merge_mayo_data_id_snps.Rmd – Merge imputed and non-imputed results, arrange results by treatment group, identify SNPs used in mayo results (23 across ADRB1, ADRB2, HDAC4. 
Output: all_mayo_BMD.csv, all_mayo_LAB.csv, all_mayo_SNPs.csv
Framingham
1.	Follow K. Nevola’s Workflow - (Code adapted into Rmarkdown files and to run on Discovery)
1.1.	WellImputedSNPs.Rmd – Create a list of SNPs that meet the imputation threshold (modified for Discovery server)
Output: WellImputedSNPs.txt
1.2.	create_cand_gene.Rmd – Create a vcf file for each gene region.
1.2.1.	Filters for +- 5KB from gene of interest.
1.2.2.	Filters for well imputed SNPs.
1.2.3.	Filters for individuals with phenotype data * idealized for vcf.gz files.
1.3.	extract_vcf_ktn.Rmd
1.3.1.	Read in vcf files for each gene.
1.3.2.	Convert to tidy format.
1.3.3.	Filter for minor allele frequency > 0.05
1.3.4.	Convert genotype to normal, heterozygous, or homozygous alternative.
1.3.5.	Write to Rdata format.
2.	Adapted K. Nevola’s Workflow for Longitudinal Data
2.1.	 build_longitudinal_phenotype_files.Rmd – create files consisting of phenotype data for femoral neck and lumbar spine longitudinal data.
Output: Femoral_Neck_Pheno_Data.csv
2.2.	build_genotype_phenotype_file.Rmd – Merge genes and phenotype data into one file.
Output: CandidateGenes.Rdata
3.	Run relational matrix LMER
3.1.	run_lmer.Rmd – Fit LMER model for longitudinal or cross-sectional data.

Plotting and Visualization
1.	Merge Mayo with Framingham, make Flextables.
1.1.	build_merged_mayo_fram_tables.Rmd – Rework Framingham headers to match mayo, merge results, create tables of significant results as .csv and .docx flextable.
Output: all_dxa_ctx_flex.csv, filtered_dxa_plus_ctx_flex.csv, cross_sectional_flex.csv
2.	Plot Effect Estimates 
2.1.	build_effect_estimate_plot.Rmd 
Output: [Default] All Significant BMD Plus CTX .png
3.	Plot Estimated Marginal Means (EMmeans)
3.1.	build_emmeans_plots_v2.Rmd 

![image](https://user-images.githubusercontent.com/99134876/236244855-dc8bdd19-3ea5-4175-b1ac-a66ba4185bc5.png)
