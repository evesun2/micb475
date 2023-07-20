# if you didn't install microbiome or ggVennDiagram packages, run the following code
# these can take quite a few minutes to install, give it 5-15 minutes for microbiome
# ggVennDiagram can take up to 10-25 minutes to install
Biocmanager::install("microbiome")
install.packages("ggVennDiagram")

#!/usr/bin/env Rscript
library(tidyverse)
library(phyloseq)
library(microbiome)
library(ggVennDiagram)

#### Load data ####
load("../Module_13/mpt_final.RData")

#### "core" microbiome ####

# Convert to relative abundance
mpt_RA <- transform_sample_counts(mpt_final, fun=function(x) x/sum(x))

# Filter dataset by antibiotic use
mpt_anti <- subset_samples(mpt_RA, `reported.antibiotic.usage`=="Yes")
mpt_noanti <- subset_samples(mpt_RA, `reported.antibiotic.usage`=="No")

# What ASVs are found in more than 70% of samples in each antibiotic usage category?
# trying changing the prevalence to see what happens
anti_ASVs <- core_members(mpt_anti, detection=0, prevalence = 0.7)
noanti_ASVs <- core_members(mpt_noanti, detection=0, prevalence = 0.7)

# What are these ASVs? you can code it in two different ways to see the same things
prune_taxa(anti_ASVs,mpt_final) %>%
tax_table()

tax_table(prune_taxa(noanti_ASVs,mpt_final))

# can plot those ASVs' relative abundance
prune_taxa(noanti_ASVs,mpt_RA) %>% 
  plot_bar(fill="Genus") + 
  facet_wrap(.~`reported.antibiotic.usage`, scales ="free")

# Notice that in this dataset, there are very few CORE microbiome members. This is common
### What if we wanted to make a Venn diagram of all the ASVs that showed up in each treatment?
anti_list <- core_members(mpt_anti, detection=0.001, prevalence = 0.10)
noanti_list <- core_members(mpt_noanti, detection=0.001, prevalence = 0.10)

anti_list_full <- list(Antibiotic = anti_list, No_Antibiotic = noanti_list)

## MAC USERS BEWARE ##
# If you are working on a new Mac running one of their new OS, you may get an error when
# you try to run the ggVennDiagram function that says something along the lines of a 
# a package called 'sf' is not found so you need to install said package and a couple more
# packages to ensure that ggVennDiagram is going to work on your computer
install.packages("sf")
# BUT when it asks if you want to install from sources, answer NO!
# load the package before running the next command, not good practice to load midway but this
# for mac users only
library("sf")
## MAC USERS BEWARE ENDS HERE##

# Create a Venn diagram using all the ASVs shared and unique to antibiotic users and non users
first_venn <- ggVennDiagram(x = anti_list_full)

ggsave("venn_antibiotic.png", first_venn)
