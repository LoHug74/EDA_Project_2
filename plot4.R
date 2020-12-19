##

setwd('C:/Users/huguel/Documents/Training/R/Coursera/Exploratory Data Analysis/EDA_Project2')


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# identify all scc with level Three containing the word coal
scc_nm <- SCC$SCC.Level.Three[grep(".*[Cc][Oo][Aa][Ll]",SCC$SCC.Level.Three)]

# filter and select Coal related SCC
scc_coal <- SCC %>% filter (SCC.Level.Three %in% scc_nm) %>% select (SCC,Data.Category)

# join scc_coal with NEI data
nei_coal <- inner_join (NEI,scc_coal, by = "SCC")
# group by year
spl_yr <- split(nei_coal$Emissions, nei_coal$year)

# compute sum of emissions by year
tot_yr <- sapply(spl_yr,sum)

# sort out years for graph naming
nm <- names(tot_yr)

# Plot 
plot(nm,tot_yr, type = 'l', xlab = 'Years', ylab = 'total PM2.5 emissions'
     , main = 'total PM2.5 emissions related to COAL
     for years 1999, 2002, 2005, and 2008')
points(nm,tot_yr, pch = 20, col = 'red') 

# save plot as png picture
dev.copy(png, file = "Plot4.png")
dev.off()

