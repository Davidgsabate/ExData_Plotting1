# download zip file containing data if it hasn't already been downloaded
  zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipFile <- "exdata_data_household_power_consumption.zip"
#
if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}
#
# # unzip zip file containing data if data directory doesn't already exist
archivo <- "household_power_consumption.txt"
if (!file.exists(archivo)){
  unzip(zipFile)
}

# # read data

temp <- read.table(
   file.path("household_power_consumption.txt"),
   header = TRUE,
   sep = ";",
   colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
   na.strings = "?",
   dec = "." )
 temp$Date <- as.Date(temp$Date, format= "%d/%m/%Y")
 datos <- subset(temp, Date == "2007-02-01" | Date == "2007-02-02")
 datos$Date <- strptime(paste(datos$Date, datos$Time), "%Y-%m-%d%H:%M:%S")
 rm(temp)

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Plot 3
 par(mfrow = c(1, 1))
 plot(datos$Date, datos$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
 with(datos,lines(Date, Sub_metering_1))
 with(datos,lines(Date, Sub_metering_2, col="red"))
 with(datos,lines(Date, Sub_metering_3, col="blue"))
 
 legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
 title(main="Energy sub-metering")
 
 dev.copy(png, file = "plot3.png")
 dev.off()
