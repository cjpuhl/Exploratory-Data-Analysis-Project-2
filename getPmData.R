downloadData <- function(){
        if(!file.exists("exdata_data_NEI_data.zip")){
                fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
                
                download.file(url = fileUrl, destfile = "exdata_data_NEI_data.zip")
        }
        if(!file.exists("summarySCC_PM25.rds") || file.exists("Source_Classification_Code.rds")){
                unzip(zipfile = "exdata_data_NEI_data.zip")
        }
}
