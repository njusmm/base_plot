# plot2.R
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

png(file = "plot2.png")
plot(data$Global_active_power, type='l', xaxt='n',
     xlab = "", ylab = "Global Active Power (kilowatts)")
axis(1, at = c(0, 1440, 2880), labels = c('Thu', 'Fri', 'Sat'))
dev.off()
