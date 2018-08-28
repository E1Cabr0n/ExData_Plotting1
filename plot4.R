datadir <- "data"
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#if (!file.exists(datadir)) {
#  dir.create(datadir)
#}
#filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download.file(paste("https://d396qusza40orc.cloudfront.net/", filename, sep = ""),
#              file.path(datadir, filename))
#if(file.exists(file.path(datadir, filename))) {
#  unzip(file.path(datadir, filename), exdir = datadir)
#}

#switches from ru to en
Sys.setenv(LANG = "en")
Sys.setlocale("LC_TIME", "English_United States")
#reads the file household_power_consumption.txt from the downloaded zip-archive
data <- read.table(file.path(datadir, "household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors=FALSE)
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
data$Datetime <- strptime(paste(data$Date, " ", data$Time), format = "%d/%m/%Y %H:%M:%S")
data <- subset(data, select = -c(Date, Time))
data$Global_active_power <- as.numeric(data$Global_active_power)

#makes a grid
par(mfrow=c(2,2))
#draws the 1st plot
with(data, plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
#draws the 2nd plot
with(data, plot(Datetime, Voltage, type = "l"))
#draws the 3rd plot with additional lines and a corrected legend
plot(data$Datetime, data$Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
lines(data$Datetime,data$Sub_metering_2, col="red")
lines(data$Datetime,data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, cex = 0.6)
#draws the 4th plot
with(data, plot(Datetime, Global_reactive_power, type = "l"))
#saves a png-file
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()