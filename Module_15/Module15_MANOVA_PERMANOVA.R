#!/usr/bin/env Rscript
library(tidyverse)
library(phyloseq)
library(vegan)

######## Load data ##########

load("../Module_13/mpt_rare.RData")
samp_dat_wdiv <- data.frame(sample_data(mpt_rare), estimate_richness(mpt_rare))


### Multivariate ANOVAs ####
# What of the "response" is actually a combination of many different variables?
# For example; changes in community composition are shifts in many different ASVs

# Make an ordination with Unifrac
ord.unifrac <- ordinate(mpt_rare, method="PCoA", distance="unifrac")
# Plot ordination by body site and subject
plot_ordination(mpt_rare_phylum, ord.unifrac, color="body.site", shape = "subject")
# There is a small effect of pH, but not a very strong effect of transect

### MANOVA
responsevar <- t(otu_table(mpt_rare))
predictbodysite <- sample_data(mpt_rare)$body.site
predictsub <- sample_data(mpt_rare)$subject
mdl_manova <- lm( responsevar ~ sample_data(mpt_rare)$body.site)
manova_mdl_multivar <- manova(mdl_manova)
summary(manova_mdl_multivar, tot=0)

# The downside to MANOVA is that it cannot incorporate phylogenetic distances into response variable
# If one phyla is more closely related to another... it can't tell
# Therefore, the superior way to test for changes in composition is actually a PERMANOVA...

### PERMANOVA (Permutational ANOVA) ####
# non-parametric version of ANOVA
# Takes a distance matrix, which can be calculated with any kind of metric you want
# e.g. Bray, Jaccard, Unifrac
# Need the package, "vegan"
# Use phyloseq to calculate weighted Unifrac distance matrix
?UniFrac
dm_unifrac <- UniFrac(mpt_rare, weighted=TRUE)

# plot the above as an ordination to a PCoA plot
ord.unifrac <- ordinate(mpt_rare, method="PCoA", distance="unifrac")
plot_ordination(mpt_rare, ord.unifrac, color="body.site", shape = "subject")

# run the permanova on the above matrix for weighted unifrac
?adonis2
adonis2(dm_unifrac ~ `body.site`*subject, data=samp_dat_wdiv)

# Also use other metrics: for example, the vegan package includes bray and jaccard
dm_bray <- vegdist(t(otu_table(mpt_rare)), method="bray")
adonis2(dm_bray ~ `body.site`*subject, data=samp_dat_wdiv)

dm_jaccard <- vegdist(t(otu_table(mpt_rare)), method="jaccard")
adonis2(dm_jaccard ~ `body.site`*subject, data=samp_dat_wdiv)

# re-plot the above PCoA with ellipses to show a significant difference 
# between body sites using ggplot2
plot_ordination(mpt_rare, ord.unifrac, color = "body.site") +
  stat_ellipse(type = "norm")

# can also use the ggforce package's geom_mark_ellipse function
plot_ordination(mpt_rare, ord.unifrac, color = "body.site", shape="subject") +
  geom_mark_ellipse(aes(filter = subject != "subject-1"))

                    