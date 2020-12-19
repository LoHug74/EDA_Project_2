##

setwd('C:/Users/huguel/Documents/Training/R/Coursera/Exploratory Data Analysis/EDA_Project2')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#3
# Of the four types of sources indicated by type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)
library(dplyr)

balt <- NEI%>% filter (fips== "24510") %>%
  group_by (type,year)%>%
  summarize (Emissions = sum (Emissions))

ggplot (balt, aes (x = year, y = Emissions)) + 
  geom_point() + 
  geom_smooth (method = "lm", se = FALSE, linetype=3) +
  geom_smooth ()+
  facet_grid(.~type) +
  labs(title = "pm 2.5 emissions from 1999–2008 for Baltimore City by Type")
dev.copy(png, file = "Plot3.png")
dev.off()

