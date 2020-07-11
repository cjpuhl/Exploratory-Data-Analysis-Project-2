## How have emissions from motor vehicle sources 
## changed from 1999–2008 in Baltimore City?

source("getPmData.R")
downloadData()

require(dplyr)
require(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")

motorVS <- SCC %>%
        filter(grepl(x = Short.Name, pattern = "Vehicle") & 
                       grepl(x = Data.Category, pattern = "Onroad")) %>%
        select(SCC)

rm(SCC)

NEI <- readRDS("summarySCC_PM25.rds")

merged <- merge(x = NEI, y = motorVS)
rm(motorVS, NEI)

baltimoreMV <- merged %>%
        filter(fips == "24510") %>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise_at(.vars = "Emissions", .funs = sum)

png(file = "Plot5.png", 
    width = 480, height = 480)

qplot(x = baltimoreMV$year, y = baltimoreMV$Emissions) +
        scale_colour_discrete(name = "Type of sources") +
        labs(title = "Baltimore City Motor Vehicle emissions") +
        labs(y = expression("Total " * PM[2.5]* " emissions"), x = "Year")

dev.off()

