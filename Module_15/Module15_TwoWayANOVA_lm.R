#!/usr/bin/env Rscript
library(tidyverse)
library(phyloseq)
######## Load data ##########

load("../Module_13/mpt_rare.RData")

# alphadiv <- estimate_richness(mpt_rare)
# samp_dat <- sample_data(mpt_rare)
# samp_dat_wdiv <- data.frame(samp_dat, alphadiv)
## I'm shortening the code above into one single command:
samp_dat_wdiv <- data.frame(sample_data(mpt_rare), estimate_richness(mpt_rare))


### 2-way ANOVA ####

# let's plot the subject and reported antibiotic usage against Shannon
# used facet_grid to customize the order of antibiotic usage so it's not alphabetical
ggplot(samp_dat_wdiv) + geom_boxplot(aes(x=subject, y=Shannon)) +
  facet_grid(~factor(`reported.antibiotic.usage`, levels=c("Yes","No")))

# run the 2-way ANOVA
ml_anti_sub <- lm(Shannon ~ `reported.antibiotic.usage`*`subject`, data=samp_dat_wdiv)
summary(aov(ml_anti_sub))
TukeyHSD(aov(ml_anti_sub))

### Linear models ####
# Linear models are identical to ANOVA when predictors are categorical
ggplot(samp_dat_wdiv) + geom_boxplot(aes(x=subject, y=Shannon)) +
  facet_grid(~factor(`reported.antibiotic.usage`))
summary(ml_anti_sub)

# Plus, with linear models we can test continuous predictor variables
# In fact, linear models combines a potentially infinite number of predictor models
ggplot(samp_dat_wdiv,aes(x=days.since.experiment.start, y=Shannon)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(.~subject)

ml_sub_start <- lm(Shannon ~ subject*days.since.experiment.start, data=samp_dat_wdiv)
summary(ml_sub_start)
