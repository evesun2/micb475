library(phyloseq)
library(ape)
library(tidyverse)
library(picante)

#### Load in RData ####
load("mpt_rare.RData")
load("mpt_final.RData")

#### Alpha diversity ######
plot_richness(mpt_rare) 

plot_richness(mpt_rare, measures = c("Shannon","Chao1")) 

gg_richness <- plot_richness(mpt_rare, x = "subject", measures = c("Shannon","Chao1")) +
  xlab("Subject ID") +
  geom_boxplot()
gg_richness

ggsave(filename = "plot_richness.png"
       , gg_richness
       , height=4, width=6)

estimate_richness(mpt_rare)

# phylogenetic diversity

# calculate Faith's phylogenetic diversity as PD
phylo_dist <- pd(t(otu_table(mpt_rare)), phy_tree(mpt_rare),
                 include.root=F) 
?pd

# add PD to metadata table
sample_data(mpt_rare)$PD <- phylo_dist$PD

# plot any metadata category against the PD
plot.pd <- ggplot(sample_data(mpt_rare), aes(subject, PD)) + 
  geom_boxplot() +
  xlab("Subject ID") +
  ylab("Phylogenetic Diversity")

# view plot
plot.pd


#### Beta diversity #####
bc_dm <- distance(mpt_rare, method="bray")
# check which methods you can specify
?distance

pcoa_bc <- ordinate(mpt_rare, method="PCoA", distance=bc_dm)

plot_ordination(mpt_rare, pcoa_bc, color = "body.site", shape="subject")

gg_pcoa <- plot_ordination(mpt_rare, pcoa_bc, color = "body.site", shape="subject") +
  labs(pch="Subject #", col = "Body Site")
gg_pcoa

ggsave("plot_pcoa.png"
       , gg_pcoa
       , height=4, width=5)

#### Taxonomy bar plots ####

# Plot bar plot of taxonomy
plot_bar(mpt_rare, fill="Phylum") 

# Convert to relative abundance
mpt_RA <- transform_sample_counts(mpt_rare, function(x) x/sum(x))

# To remove black bars, "glom" by phylum first
mpt_phylum <- tax_glom(mpt_RA, taxrank = "Phylum", NArm=FALSE)

plot_bar(mpt_phylum, fill="Phylum") + 
  facet_wrap(.~subject, scales = "free_x")

gg_taxa <- plot_bar(mpt_phylum, fill="Phylum") + 
  facet_wrap(.~subject, scales = "free_x")
gg_taxa

ggsave("plot_taxonomy.png"
       , gg_taxa
       , height=8, width =12)


