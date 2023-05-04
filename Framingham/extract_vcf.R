---
title: "extract_vcf_ktn"
author: "Griffin Tibbitts"
date: '2023-05-04'
output: html_document
---

---
title: "extract vcf ktn"
author: "Griffin T"
date: "3/12/2023"
output: html_document
---

```{r}
library(vcfR)
library(R.utils)
target_files<-list.files(path = '/work/larylab/Griffin_Stuff/Griffin_Framingham/data/target_genes/', pattern = "recode.vcf")
target_genes <- gsub(".recode.vcf", "", target_files)
```

```{r}
ADRB1 <- read.vcfR('/work/larylab/Griffin_Stuff/Griffin_Framingham/data/target_genes/ADRB1.recode.vcf')

ADRB1@fix[,3] <- 1:length(ADRB1@fix[,3])
ADRB1
```
```{r}
tidy<- vcfR2tidy(ADRB1)
```

```{r}
setwd('/work/larylab/Griffin_Stuff/Griffin_Framingham/data/target_genes/')
for (i in target_genes){
  print(i)
  gene = read.vcfR(paste(i, ".recode.vcf",sep = ""))
  # ID numbers are not unique so set ID to arbitrary numbers
  gene@fix[,3] <-1:length(gene@fix[,3])
  
  # Convert VcrF to tidy data
  tidy<- vcfR2tidy(gene, format_fields = c("GT", "DS", "GP"))
  
  # Calculating the minor allele frequency
  maf <- as.data.frame(maf(gene))
  tidy$meta
  tidy$fix
  tidy$gt
  tidy$fix$MAF <- maf$Frequency
  
  
  save(tidy, file = paste(i,"_vcfr_tidy.RData",sep=""))
  
   #Filter for MAF > 0.05 (5 SNPs)
  tidy$fix <- tidy$fix[tidy$fix$MAF > 0.05,]
  tidy$gt <- tidy$gt[tidy$gt$POS %in% tidy$fix$POS,]
  
  save(tidy, file = paste(i,"_vcfr_tidy_filtered.RData",sep=""))
  
  tidy$meta
  tidy$gt$Genotype=NA
  tidy$gt$Genotype[tidy$gt$gt_GT == "0|0"] <- "normal"
  tidy$gt$Genotype[tidy$gt$gt_GT == "1|0" |tidy$gt$gt_GT == "0|1"] <- "heterozygous"
  tidy$gt$Genotype[tidy$gt$gt_GT == "1|1"] <- "homozygous alternative"
  tidy$gt$Genotype <- as.factor(tidy$gt$Genotype)
  table(tidy$gt$Genotype)
  
  save(tidy, file = paste(i,"_vcfr_tidy_filtered_genotype.RData",sep=""))
}
```
