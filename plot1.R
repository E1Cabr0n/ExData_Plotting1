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

#makes a histogramm
par(mfrow=c(1,1))
hist(data$Global_active_power, breaks = 12, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#saves a png-file
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()