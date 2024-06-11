# For data management
install.packages('tidyverse')
BiocManager::install("clusterProfiler")
BiocManager::install("org.Hs.eg.db")

# For visualisation
install.packages('pheatmap')
install.packages("DOSE")
install.packages("enrichplot")
install.packages("ggupset")

# Loading relevant libraries
library(tidyverse) # includes ggplot2, for data visualisation. dplyr, for data manipulation.
library(RColorBrewer) # for a colourful plot
library(pheatmap)
library(clusterProfiler) # for PEA analysis
library('org.Hs.eg.db')
library(DOSE)
library(enrichplot) # for visualisations
library(ggupset) # for visualisations

df<- read.table("data/table_degenes.txt",header = TRUE)
glimpse(df)
df$Gene_Symbol<- as.factor(df$Gene_Symbol)
df$Gene_ID<- as.factor(df$Gene_ID)

cox<- read.table("data/table_similar.txt",header = TRUE)
glimpse(cox)
cox$Gene_Symbol<- as.factor(cox$Gene_Symbol)
cox$Gene_ID<- as.factor(cox$Gene_ID)

pw<- read.gmt("data/gene_symbols.gmt")
pw<- pw[pw$gene %in% df$Gene_Symbol,]
saveRDS(pw,'kegg.RDS')

bg_genes<- readRDS('kegg.RDS')

res<- lapply(names(df),
             function(x) enricher(gene = df[[x]]$Gene_Symbol,
                                  TERM2GENE = bg_genes))

