#!/usr/bin/env Rscript

# Load packages
library(tidyverse)

# Load metadata
sampdatfp <- "atacamasoil_sample-data.txt"
sampdat <- read.delim(sampdatfp)

str(sampdat)


# plot(sampdat$elevation, sampdat$ph)

ggplot(sampdat, aes(x=elevation, y=averagesoiltemperature)) +
  geom_point()


gg_elevation_soiltemp <- ggplot(sampdat, aes(x=elevation, y=averagesoiltemperature)) +
  geom_point()
gg_elevation_soiltemp

gg_elevation_soiltemp +
  geom_line()

gg_elevation_soiltemp +
  geom_line() + 
  geom_line(aes(y=temperaturesoillow), col="blue") +
  geom_line(aes(y=temperaturesoilhigh), col="red")

gg_elevation_soiltemp + 
  geom_line() + 
  geom_ribbon(aes(ymin=temperaturesoillow, ymax = temperaturesoilhigh)
              , alpha=0.25
              , col="orange"
                , fill = "yellow")

gg_tosave <- gg_elevation_soiltemp + 
  geom_line() + 
  geom_ribbon(aes(ymin=temperature.soil.low, ymax = temperature.soil.high)
              , alpha=0.25
              , col="orange"
                , fill = "yellow")
gg_tosave
# jpeg, png, pdf
ggsave(filename = "ggplot_elevation_vs_temp.png"
       , gg_tosave
       , height=4, width=4)

######## Summary type plots #########

ggplot(sampdat, aes(x=elevation, y=averagesoiltemperature)) + 
  geom_smooth(method="lm", col="red") + 
  geom_point()

ggplot(sampdat, aes(x=elevation)) +
  geom_histogram()

ggplot(sampdat, aes(x=`sitename`, y=ph)) + 
  geom_boxplot() +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Site name") +
  ylab("pH")

ggplot(sampdat, aes(x=vegetation, y=ph)) +
  geom_boxplot() +
  facet_grid(.~transectname)

###### Faceting ###########

ggplot(sampdat, aes(x=`sitename`, y=ph)) + 
  geom_boxplot() +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Site name") +
  ylab("pH") +
  facet_grid(.~transectname, scales="free_x")
# facet_wrap


ggplot(sampdat, aes(x=`sitename`, y=ph)) + 
  geom_boxplot() +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Site name") +
  ylab("pH") +
  facet_grid(vegetation~transectname, scales="free_x")

#### Practice ####

sampdat$averagesoiltempinF <- (sampdat$averagesoiltemperature*9/5) + 32

ggplot(sampdat, aes(x=averagesoilrelativehumidity, y=averagesoiltempinF, color=transectname)) +
  geom_point() +
  geom_smooth(method="lm") +
  xlab("Average soil relative humidity") +
  ylab("Average soil temperature (F)") +
  labs(color='Transect Name')
