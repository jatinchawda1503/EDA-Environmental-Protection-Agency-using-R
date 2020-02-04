library(data.table)
library(ggplot2)

#unzipping and loading the data
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

#reading the data 

data_summary <- readRDS("summarySCC_PM25.rds")

data_source <- readRDS("Source_Classification_Code.rds")

#converting the formate to data table

NEI <- data.table::as.data.table(data_summary)
SCC <- data.table::as.data.table(data_source)

#Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
##Assgining baltimore feilds to a variable

baltimore <- subset(NEI, fips == '24510')

#Converting list to respected types,Preventing plot from printing in scientific notation

by_year <- baltimore[, list(emissions=sum(Emissions)), by=c('year', 'type')]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))

## deriving type of file to save the plot
png(filename='plot3.png')

##Plotting using ggplot2 
ggplot(by_year, aes(by_year$year, by_year$emissions, col=by_year$type)) + geom_line() + geom_point() + ggtitle("Emissions in Baltimore City")

dev.off()
