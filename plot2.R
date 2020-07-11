## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## fips == "24510" from 1999 to 2008? Use the base plotting system to
## make a plot answering this question.

source("getPmData.R")
downloadData()

NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")


baltimore <- NEI  %>%
        filter(fips == "24510")%>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise_at(.vars = "Emissions", .funs = sum)

rm(NEI)

png(file = "Plot2.png", 
    width = 480, height = 480)

plot(baltimore, main = "Emissions by Year in Baltimore", type = "h",
     xlim = c(1998, 2009), ylim = c(1000, 4000))

text(baltimore$year, baltimore$Emissions, paste(round(baltimore$Emissions, 2), "\n"), cex=1)

dev.off()
