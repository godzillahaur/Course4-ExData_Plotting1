file.name <- "./household_power_consumption.txt"
url       <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file  <- "./quiz1-data.zip"

# Check if the data is downloaded and download when applicable
if (!file.exists("./household_power_consumption.txt")) {
        download.file(url, destfile = zip.file)
        unzip(zip.file)
        file.remove(zip.file)
}

# Reading the file
library(data.table)
OriData <- fread(file.name, sep = ";", header = TRUE, colClasses = rep("character",9))

#Assign the value, NA, instead of "?" 
OriData[OriData == "?"] <- NA

#Set the format of Date
OriData$Date <- as.Date(OriData$Date, format = "%d/%m/%Y")

#Subset the desired data
OriData <- OriData[OriData$Date >= as.Date("2007-02-01") & OriData$Date <= as.Date("2007-02-02"),]

#Output to the graphics device, PNG
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(OriData$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

