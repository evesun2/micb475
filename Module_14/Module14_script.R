#!/usr/bin/env Rscript
library(tidyverse)
library(phyloseq)
library(ggsignif)

# Load data
load("../Module_13/mpt_rare.RData")

######## Comparison of two means with t-test (Parametric) ##########
# Let's do very simple plot with t-test
plot_richness(mpt_rare, x = "subject", measures="Shannon") + geom_point()

# Need to extract information
alphadiv <- estimate_richness(mpt_rare)
samp_dat <- sample_data(mpt_rare)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv)

View(samp_dat_wdiv)

# These are equivalent:
# t.test()
t.test(samp_dat_wdiv$Shannon ~ samp_dat_wdiv$subject)
t.test(Shannon ~ subject, data=samp_dat_wdiv)

# learn more about the t test
?t.test

# Note: you can set variances to be equal for a "classic" t-test
t.test(Shannon ~ subject, data=samp_dat_wdiv, var.equal=TRUE)
# If your data is paired, you can set paired=TRUE
t.test(Shannon ~ subject, data=samp_dat_wdiv, paired=TRUE)


######## Comparison of two means with Wilcoxon (Non-parametric) ##########
# Let's say we want to know whether richness (Observed) differs between subjects
# rich <- estimate_richness(mpt, measures = c("Shannon", "Chao1", "Observed"))
# samp_dat <- data.frame(samp_dat, rich)

# Microbial count data is generally NON-NORMAL
# In fact, it is even more complex because microbial data is usually in RELATIVE ABUNDANCE
allCounts <- as.vector(otu_table(mpt_rare))
allCounts <- allCounts[allCounts>0]
hist(allCounts)
hist(log(allCounts))

# Visualize the relationship between richness and subject
samp_dat_wdiv %>%
  filter(!is.na(Observed)) %>%
  ggplot(aes(x=subject, y=Observed))+
  geom_point() 

# Attempt a t-test assuming normal distribution
t.test(Observed ~ subject, data=samp_dat_wdiv)

# Non-parametric distribution means it does not follow a distribution-- it may
# be irregular, skewed, or both
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Observed), bins=5)

## There are two ways of dealing with non-parametric data distributions:

# (1) Transform your data (usually with a log function)
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Observed)), bins=5)

# Log transform then perform a t-test
t.test(log(Observed) ~ subject, data=samp_dat_wdiv)


# Let's see what transformed data looks like:
samp_dat_wdiv %>%
  filter(!is.na(Observed)) %>%
  ggplot(aes(x=subject, y=log(Observed)))+
  geom_boxplot() +
  geom_jitter() #spread out scatterplot

# (2) Or you can use a non-parametric test, which usually uses "ranks" or random sampling
# instead of pre-defined distributions
wilcox.test(Observed ~ subject, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Observed) ~ subject, data=samp_dat_wdiv, exact = FALSE)

#### Comparison of >2 means with ANOVA (Parametric) ####
# Let's create a Shannon plot for the body sites
ggplot(samp_dat_wdiv) +
  geom_boxplot(aes(x=`body.site`, y=Shannon)) + geom_point(aes(x=`body.site`, y=Shannon))

# Set up our linear model 
lm_shannon_vs_site <- lm(Shannon ~ `body.site`, dat=samp_dat_wdiv)
# Calculate AOV
anova_shannon_vs_site <- aov(lm_shannon_vs_site)
# Summarize to determine if there are significant differences
summary(anova_shannon_vs_site)
# Determine which groups are significant
tukey_sum <- TukeyHSD(anova_shannon_vs_site)

# Mapping the significance to a ggplot
shan_bodysite <- ggplot(samp_dat_wdiv, aes(x=`body.site`, y=Shannon)) +
  geom_boxplot() +
  geom_signif(comparisons = list(c("tongue","right palm"), c("tongue", "left palm")),
              y_position = c(4.2, 4.5),
              annotations = c("***","****"))

#### Comparison of >2 means with Kruskall-Wallis (Non-parametric) ####
ggplot(samp_dat_wdiv, aes(x=`body.site`, y=Observed)) +
  geom_boxplot() +
  geom_point()

# You can use the ANOVA test we did above
lm_ob_vs_site <- lm(Observed ~ `body.site`, data=samp_dat_wdiv)
anova_ob_vs_site <- aov(lm_ob_vs_site)
summary(anova_ob_vs_site)

# Or you run a kruskal-wallis test to show that you get greater significance
kruskal_obs <- kruskal.test(Observed ~ `body.site`, data = samp_dat_wdiv)

# log the data and run ANOVA again to see that you also get better significance
# than just the ANOVA without the transformation
lm_ob_vs_site_log <- lm(log(Observed) ~ `body.site`, data=samp_dat_wdiv)
anova_ob_vs_site_log <- aov(lm_ob_vs_site_log)
summary(anova_ob_vs_site_log)
TukeyHSD(anova_ob_vs_site_log)

# let's graph the observed features to the body site and annotate significance
# based on the logged ANOVA above
# Mapping the significance to a ggplot
ggplot(samp_dat_wdiv, aes(x=`body.site`, y=Observed)) +
  geom_boxplot() +
  geom_signif(comparisons = list(c("tongue","right palm"), c("tongue", "left palm"), c("tongue","gut")),
              y_position = c(148, 160, 172),
              annotations = c("0.001","0.0001","0.002"))

#### Correlations between two variables with Pearson (Parametric) ####
# prepare the data by removing NAs and zeros
samp_dat_wdiv <- samp_dat_wdiv %>%
  filter(!is.na(Shannon), !is.na(`days.since.experiment.start`), !is.na(Observed), Shannon!=0)

# Let's look at Shannon versus days since the experiment started
ggplot(samp_dat_wdiv,aes(x=days.since.experiment.start, y=Shannon)) +
  geom_point() +
  geom_smooth(method = "lm")

# Default option for cor.test is a parametric test called "Pearson"
# cor.test( Xvar, Yvar )
cor.test(samp_dat_wdiv$days.since.experiment.start, samp_dat_wdiv$Shannon)


#### Correlations between two variables with Spearman (Non-parametric) ####
# Let's look at how days of the month affects alpha diversity
ggplot(samp_dat_wdiv,aes(x=days.since.experiment.start, y=Observed)) +
  geom_point()+
  geom_smooth(method="lm")
# Let's assume we have a relatively non-normal distribution
# A regular Pearson's test will not be ideal because toc is not normally distributed

# Again, we have two options: transform, or use a non-parametric test
ggplot(samp_dat_wdiv, aes(x=log(days.since.experiment.start), y=Observed)) +
  geom_point() +
  geom_smooth(method = "lm")
cor.test(log(samp_dat_wdiv$`days.since.experiment.start`), samp_dat_wdiv$Observed)

# Or, we can simply use a non-parametric test:
# cor.test( Xvar, Yvar, method = 'spearman')
cor.test(samp_dat_wdiv$days.since.experiment.start, 
         samp_dat_wdiv$Observed, method = "spearman", exact = FALSE)

cor.test(samp_dat_wdiv$days.since.experiment.start, log(samp_dat_wdiv$Observed), 
         method = "spearman", exact = FALSE)
