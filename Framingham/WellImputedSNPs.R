rm(list = ls())
library(GEOquery)
options(stringasFactor =F)
files<-list.files(path = "/work/larylab/dbgap/data3/phg000835.v5.FHS_SHARE_imputed_HRC1.marker-info.MULTI/",
                  pattern = "*.gz")
files <- paste("/work/larylab/dbgap/data3/phg000835.v5.FHS_SHARE_imputed_HRC1.marker-info.MULTI/", files, sep = "")
for (i in 1:length(files)){
  print(i)
  gunzip(filename = files[i], overwrite = T, remove = F)
}
setwd('/work/larylab/dbgap/data3/phg000835.v5.FHS_SHARE_imputed_HRC1.marker-info.MULTI/')
info_files <- list.files(path = "/work/larylab/dbgap/data3/phg000835.v5.FHS_SHARE_imputed_HRC1.marker-info.MULTI/",
                         pattern = "*.info$")
chrs<- read.table(info_files[1], header = T)
for (i in 2:length(info_files)){
  print(i)
  chrs <- rbind(chrs,read.table(info_files[i], header = T))
}

chrs8 <- chrs[chrs$Rsq > 0.8,]


write.csv(chrs8, "/work/larylab/Griffin_Stuff/Griffin_Framingham/data/WellImputedSNPs08.csv", quote = F, row.names = F)

chrs8<-read.csv("/work/larylab/Griffin_Stuff/Griffin_Framingham/data/WellImputedSNPs08.csv.csv")
setwd("/work/larylab/Griffin_Stuff/Griffin_Framingham/data/")
library(tidyr)
chrs8 <- separate(data=chrs8, col = SNP, into = c("CHR", "POS"), sep = ":")
chrs8$CHR <- as.numeric(chrs8$CHR)
chrs8$POS <- as.numeric(chrs8$POS)
chrs8pos <- chrs8[1:2]
write.table(chrs8pos,file = "/work/larylab/Griffin_Stuff/Griffin_Framingham/data/WellImputedPositions8.txt", quote = F, row.names = F, sep = '\t')

vcfgzfiles<- list.files(path = "/work/larylab/dbgap/data3/phg000835.v5.FHS_SHARE_imputed_HRC1.genotype-calls-vcf.c2/",pattern = ".vcf.gz")

fileConn <- file("gzfile.txt")    
writeLines(vcfgzfiles, fileConn)    

unique(chrs8pos$CHR)
