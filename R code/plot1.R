unzipfile <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## Question 1
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))
newdata1 <- subset(dataset, Date == '1/2/2007')
newdata2 <- subset(dataset, Date == '2/2/2007')
fevdata <- rbind(newdata1, newdata2)
hist(fevdata$Global_active_power, col = 'red', main = "Global Avtive Power", xlab = 'Global Active Power (kilowatts)')
dev.copy(png, file = "plot1.png")
dev.off()