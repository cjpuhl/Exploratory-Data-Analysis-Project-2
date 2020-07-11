## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California
## fips == "06037". Which city has seen greater changes over time 
## in motor vehicle emissions?

source("getPmData.R")
downloadData()

SCC <- readRDS("Source_Classification_Code.rds")

motorVS <- SCC %>%
        filter(grepl(x = Short.Name, pattern = "Vehicle") & 
                grepl(x = Data.Category, pattern = "Onroad")) %>%
        select(SCC)

rm(SCC)

NEI <- readRDS("summarySCC_PM25.rds")

merged <- merge(x = NEI, y = motorVS)
rm(motorVS, NEI)

baltimore.LA <- merged %>%
        filter(fips == "24510" || fips == "06037") %>%
        select(year, fips, Emissions) %>%
        group_by(fips, year) %>%
        summarise_at(.vars = "Emissions", .funs = sum)

rm(merged)

png(file = "Plot6.png", 
    width = 480, height = 480)

with(baltimore.LA, qplot(x = year, y = Emissions, col = fips)) +
        scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
        labs(title = expression("Baltimore and Los Angeles " 
                * PM[2.5]* " Motor Vehicle emissions")) +
        labs(y = expression("Total " * PM[2.5]* " emissions"), x = "Year")
dev.off()
