unzipfile <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

newdata1 <- subset(dataset, Date == '1/2/2007')
newdata2 <- subset(dataset, Date == '2/2/2007')
fevdata <- rbind(newdata1, newdata2)
fevdata$Date <- as.Date(fevdata$Date, format = "%d/%m/%Y")
fevdata2 <- transform(fevdata, datetime = interaction(Date, Time, sep=' '))
fevdata2$datetime <- strptime(fevdata2$datetime, "%Y-%m-%d %H:%M:%S")
fevdata2$Sub_metering_2 <- as.numeric(as.character(fevdata2$Sub_metering_2))
fevdata2$Sub_metering_1 <- as.numeric(as.character(fevdata2$Sub_metering_1))
fevdata2$Sub_metering_total <- rowSums(fevdata2[,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")])
par(mfrow = c(2, 2), mar = c(3,4,1,4), cex.lab = 0.75)

#graph 1
plot(fevdata2$datetime, fevdata2$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')

#graph 2
fevdata2$Voltage <- as.numeric(as.character(fevdata2$Voltage))
plot(fevdata2$datetime, fevdata2$Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')

#graph 3
plot(fevdata2$datetime, fevdata2$Sub_metering_total, type = 'n', ylab ='Energy sub metering', xlab = '')
lines(fevdata2$datetime, fevdata2$Sub_metering_1, col = 'black')
lines(fevdata2$datetime, fevdata2$Sub_metering_2, col = 'red')
lines(fevdata2$datetime, fevdata2$Sub_metering_3, col = 'blue')
legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col= c('black', 'red', 'blue'), lty = 1, cex = 0.50, bty = 'n')

#graph 4
fevdata2$Global_reactive_power <- as.numeric(as.character(fevdata2$Global_reactive_power))
plot(fevdata2$datetime, fevdata2$Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime')

dev.copy(png, file = "plot4.png")
dev.off()