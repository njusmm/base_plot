# plot3.R
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

png(file = "plot3.png")
plot(data$Sub_metering_1, type="n", xaxt='n',
     xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_1)
lines(data$Sub_metering_2, col = 'red')
lines(data$Sub_metering_3, col = 'blue')
axis(1, at = c(1, 1441, 2881), labels = c('Thu','Fri','Sat'))
legend("topright", col=c("black", "red", "blue"), lty = 1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
