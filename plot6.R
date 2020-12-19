##

setwd('C:/Users/huguel/Documents/Training/R/Coursera/Exploratory Data Analysis/EDA_Project2')


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#6 
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

## BALTIMORE

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
ba_tot_yr <- sapply(spl_yr,sum)

# sort out years for graph naming
nm <- names(tot_yr)

## LOS ANGELES (LA)
# Extract la emissions
la <- NEI %>% filter (fips == "06037") %>%
  group_by (year, SCC) %>%
  summarize (Emissions = sum (Emissions))

# join scc_mv with balt data
la_mv <- inner_join (la,scc_mv, by = "SCC")

# group by year
spl_yr <- split(la_mv$Emissions, la_mv$year)

# compute sum of emissions by year
la_tot_yr <- sapply(spl_yr,sum)

# get max Y value (rounded next hundreds)
y_mx <- ceiling (max(la_tot_yr,ba_tot_yr)/100)*100

## Plot for both cities
plot(nm,ba_tot_yr, type = 'l', xlab = 'Years', ylab = 'total PM2.5 emission',
     ylim = c(0,y_mx)
     , main = 'Compairing PM2.5 emissions between LA & Baltimore for Vehicles
     for years 1999, 2002, 2005, and 2008')
points(nm,ba_tot_yr, pch = 20, col = 'red')
lines(nm,la_tot_yr, col = 'blue')
points(nm,la_tot_yr, pch = 20, col = 'blue')
text (x = 2008, y = la_tot_yr[4], adj = c(1,1),cex = .8
        , labels = paste ("2008 vs 1999: "
        ,(round(((la_tot_yr[4]/la_tot_yr[1])-1)*100,2))," %",sep = ""))
text (x = 2008, y = ba_tot_yr[4], adj = c(1,1),cex = .8
        ,labels = paste ("2008 vs 1999: "
        ,(round(((ba_tot_yr[4]/ba_tot_yr[1])-1)*100,2))," %",sep = ""))
legend("left", pch = 20, col = c("blue","red"), legend = c("L.A.","Balt."))

# save plot as png
dev.copy(png, file = "Plot6.png")
dev.off()

