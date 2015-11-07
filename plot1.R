library("dplyr")

fromDate = as.Date("2007-02-01")
toDate = as.Date("2007-02-02")

# Function to download and extract the data needed for the exercise from its web repository.
obtainData <- function(){
    
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
    data <- read.table(unzip(temp), sep = ";", header = TRUE, stringsAsFactors = FALSE)
    unlink(temp)
    
    #Do some cleanup to convert date columns to Date/Time classes, factors to numeric, etc
    data$Date = as.Date(data$Date, format="%d/%m/%Y")

    data$Global_active_power = as.numeric(data$Global_active_power)
    data$Global_reactive_power = as.numeric(data$Global_reactive_power)
    data$Voltage = as.numeric(data$Voltage)
    data$Global_intensity = as.numeric(data$Global_intensity)
    
    
    data <- filter(data, Date <= as.Date("2007-02-02"), Date >= as.Date("2007-02-01"))
    data
}

allData <- obtainData()

#Create plot 1
png("plot1.png")
hist(allData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main="Global Active Power")
dev.off()





