## Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

require(dplyr)

source("getPmData.R")
downloadData()

NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")


total <- NEI  %>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise_at(.vars = "Emissions", .funs = sum)

rm(NEI)

png(file = "Plot1.png", 
    width = 480, height = 480)

plot(total, main = "Total Emissions by Year", type = "h", 
     xlim = c(1998, 2009), ylim = c(2000000,9000000))

text(total$year, total$Emissions, paste(round(total$Emissions, 2), "\n"), cex=1)
dev.off()
     