##

setwd('C:/Users/huguel/Documents/Training/R/Coursera/Exploratory Data Analysis/EDA_Project2')


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# fips == "24510" from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
balt <- subset (NEI, fips == "24510" )
spl_yr <- split(balt$Emissions, balt$year)
tot_yr <- sapply(spl_yr,sum)
nm <- names(tot_yr)
plot(nm,tot_yr, type = 'l', xlab = 'Years', ylab = 'total PM2.5 emission'
     , main = 'Total PM2.5 emissions from all sources for BALTIMORE CITY
     for each years 1999, 2002, 2005, and 2008')
points(nm,tot_yr, pch = 20, col = 'red')
dev.copy(png, file = "Plot2.png")
dev.off()
