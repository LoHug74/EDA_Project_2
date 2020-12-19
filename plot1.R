##

setwd('C:/Users/huguel/Documents/Training/R/Coursera/Exploratory Data Analysis/EDA_Project2')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008

spl_yr <- split(NEI$Emissions, NEI$year)
tot_yr <- sapply(spl_yr,sum)
nm <- names(tot_yr)
plot(nm,tot_yr, type = 'l', xlab = 'Years', ylab = 'total PM2.5 emission'
     , main = 'total PM2.5 emissions from all sources 
     for each years 1999, 2002, 2005, and 2008')
points(nm,tot_yr, pch = 20)
dev.copy(png, file = "Plot1.png")
dev.off()


