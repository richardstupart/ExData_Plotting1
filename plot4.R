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
    data <- mutate(data, Timestamp = paste(as.character(Date), ' ', as.character(Time)))
    data$Date = as.Date(data$Date, format="%d/%m/%Y")

    data$Global_active_power = as.numeric(data$Global_active_power)
    data$Global_reactive_power = as.numeric(data$Global_reactive_power)
    data$Voltage = as.numeric(data$Voltage)
    data$Global_intensity = as.numeric(data$Global_intensity)
    
    
    data <- filter(data, Date <= as.Date("2007-02-02"), Date >= as.Date("2007-02-01"))
    data
}

allData <- obtainData()


#Create plot 4
png("plot4.png")
par(mfrow = c(2,2))
plot(strptime(paste(as.character(allData$Date), ' ', as.character(allData$Time)), format = "%Y-%m-%d %H:%M:%S"), allData$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
plot(strptime(paste(as.character(allData$Date), ' ', as.character(allData$Time)), format = "%Y-%m-%d %H:%M:%S"), allData$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

plot(strptime(paste(as.character(allData$Date), ' ', as.character(allData$Time)), format = "%Y-%m-%d %H:%M:%S"), allData$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
points(strptime(paste(as.character(allData$Date), ' ', as.character(allData$Time)), format = "%Y-%m-%d %H:%M:%S"), allData$Sub_metering_2, type="l", col="red")
points(strptime(paste(as.character(allData$Date), ' ', as.character(allData$Time)), format = "%Y-%m-%d %H:%M:%S"), allData$Sub_metering_3, type="l", col="blue")
legend("topright", legend= c("Sub_metering_2", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)

plot(strptime(paste(as.character(allData$Date), ' ', as.character(allData$Time)), format = "%Y-%m-%d %H:%M:%S"), allData$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()



