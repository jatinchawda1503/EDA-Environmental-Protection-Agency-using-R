library(data.table)

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

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


##1 Converting list to respected types,Preventing plot from printing in scientific notation

by_year <- NEI[, list(emissions=sum(Emissions)), by=year]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))

##deriving type of file to save the plot
png(filename='plot1.png')


## Genrating the Plot

barplot(by_year[, by_year$emissions]
        , names = by_year[, by_year$year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()

