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

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##filtering data set 'on-road'
baltimore <- subset(NEI,fips %in% c('06037', '24510') & type == 'ON-ROAD')

#Converting list to respected types,Preventing plot from printing in scientific notation

by_year <- baltimore[, list(emissions=sum(Emissions)), by=c('year', 'fips')]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))


## deriving type of file to save the plot
png(filename='plot6.png')

##Plotting using ggplot2 
ggplot(data=by_year, aes(x=year, y=emissions, col=fips)) + geom_line() + geom_point() + ggtitle("Emissions in Baltimore City from Motor Vehicles")

dev.off()
