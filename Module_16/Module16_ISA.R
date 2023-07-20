# if you didn't install the indicspecies package, run the following
install.packages("indicspecies")

#!/usr/bin/env Rscript
library(tidyverse)
library(phyloseq)
library(indicspecies)

#### Load data ####
load("../Module_13/mpt_final.RData")

#### Indicator Species/Taxa Analysis ####
# glom to Genus
mpt_genus <- tax_glom(mpt_final, "Genus", NArm = FALSE)
mpt_genus_RA <- transform_sample_counts(mpt_genus, fun=function(x) x/sum(x))

#ISA
isa_mpt <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_genus_RA)$`reported.antibiotic.usage`)
summary(isa_mpt)
taxtable <- tax_table(mpt_final) %>% as.data.frame() %>% rownames_to_column(var="ASV")

# consider that your table is only going to be resolved up to the genus level, be wary of 
# anything beyond the glomed taxa level
isa_mpt$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

