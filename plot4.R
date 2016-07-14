# plot4.R
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt",
                     sql = "SELECT * FROM file
                     WHERE Date == '1/2/2007' OR
                     Date == '2/2/2007'",
                     header = TRUE, sep = ';')
data[data == '?'] <- NA  # replace '?' with NA
# create column time as stardard time representation
data$time <- with(data, strptime(
  paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"
))

png(file = "plot4.png")
par(mfcol = c(2, 2))
#first
plot(data$Global_active_power, type='l', xaxt='n',
     xlab = "", ylab = "Global Active Power")
axis(1, at = c(0, 1440, 2880), labels = c('Thu', 'Fri', 'Sat'))
#second
plot(data$Sub_metering_1, type="n", xaxt='n',
     xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_1)
lines(data$Sub_metering_2, col = 'red')
lines(data$Sub_metering_3, col = 'blue')
axis(1, at = c(1, 1441, 2881), labels = c('Thu','Fri','Sat'))
legend("topright", col=c("black", "red", "blue"), lty = 1, bty = 'n',
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#third
plot(data$Voltage, type='l', xaxt='n', xlab='datetime', ylab='Voltage')
axis(1, at = c(0, 1440, 2880), labels = c('Thu', 'Fri', 'Sat'))
#fourth
plot(data$Global_reactive_power, type='l', xaxt='n', xlab='datetime',
     ylab='Global_reactive_power', xaxt='n')
axis(1, at = c(0, 1440, 2880), labels = c('Thu', 'Fri', 'Sat'))
dev.off()
