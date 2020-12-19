##

setwd('C:/Users/huguel/Documents/Training/R/Coursera/Exploratory Data Analysis/EDA_Project2')


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# !!! we will Consider the category Vehicle (as this is pm2.5 they all have motor)
# rather than precisely [Mm]otor [Vv]ehicle

# identify scc.level>three having the word 'Vehicle'
scc_nm <- SCC$SCC.Level.Three[grep("[Vv]ehicle",SCC$SCC.Level.Three)]

# filter and select Vehicle related SCC
scc_mv <- SCC %>% filter (SCC.Level.Three %in% scc_nm) %>% select (SCC,Data.Category)

# Extract Baltimore emissions
balt <- NEI %>% filter (fips == "24510") %>%
  group_by (year, SCC) %>%
  summarize (Emissions = sum (Emissions))

# join scc_mv with balt data
balt_mv <- inner_join (balt,scc_mv, by = "SCC")

# group by year
spl_yr <- split(balt_mv$Emissions, balt_mv$year)

# compute sum of emissions by year
tot_yr <- sapply(spl_yr,sum)

# sort out years for graph naming
nm <- names(tot_yr)

# plot
plot(nm,tot_yr, type = 'l', xlab = 'Years', ylab = 'total PM2.5 emission'
     , main = 'Total PM2.5 emissions related to Vehicles
     for years 1999, 2002, 2005, and 2008')
points(nm,tot_yr, pch = 20, col = 'red') 
dev.copy(png, file = "Plot5.png")
dev.off()

