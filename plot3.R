## Of the four types of sources indicated by the 
## type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions 
## from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

source("getPmData.R")
downloadData()

require(dplyr)
require(ggplot2)


NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")

type <- NEI  %>%
        filter(fips == "24510") %>%
        select(year, type, Emissions) %>%
        group_by(type, year) %>%
        summarise_at(.vars = "Emissions", .funs = sum)

rm(NEI)

png(file = "Plot3.png", width = 720, height = 720)

qplot(x = type$year, y = type$Emissions, facets = .~ type$type) +
        labs(title = expression("Baltimore " * PM[2.5]* " Emissions by Source")) +
        labs(y = expression("Total " * PM[2.5]* " emissions"), x = "Year")

dev.off()
