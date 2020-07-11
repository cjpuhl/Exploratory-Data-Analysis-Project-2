## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

source("getPmData.R")
downloadData()

require(dplyr)
require(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")

coalSCC <- SCC  %>%
        filter(grepl(x = Short.Name, pattern = "Coal")) %>%
        select(SCC)
        
rm(SCC)        

NEI <- readRDS("summarySCC_PM25.rds")

merged <- merge(x = NEI, y = coalSCC)
rm(NEI, coalSCC)

coalEmission <- merged  %>%
        select(year, Emissions, type) %>%
        group_by(type, year) %>%
        summarise_at(.vars = "Emissions", .funs = sum)

rm(merged)

png(file = "Plot4.png", 
    width = 480, height = 480)

with(coalEmission, qplot(x = year, y = Emissions, col = type)) +
             scale_colour_discrete(name = "Type of sources") +
        labs(title = expression("United States " * PM[2.5]* 
                                        " emissions from coal combustion Sources")) +
        labs(y = expression("Total " * PM[2.5]* " emissions"), x = "Year")
dev.off()
