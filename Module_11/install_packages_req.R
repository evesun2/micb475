# Install DESeq2
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.16")

## NOTE: THIS TAKES A LOOOOONG TIME. GO GET LUNCH.
BiocManager::install("DESeq2")
# Takes 5-15 min; make sure you press 'a' when it asks you whether you want to update all/some/none packages

# for PERMANOVA
install.packages("vegan")

# For venn diagram
install.packages('ggVennDiagram')

# For core microbiome
BiocManager::install("microbiome")

install.packages('indicspecies')

# for faith's phylogenetic distance analysis

install.packages("picante")

# very important package for microbiome analysis in general
## this can also take quite a bit of time to install
BiocManager::install("phyloseq")

# analysis of phylogenetic trees

install.packages("ape")


