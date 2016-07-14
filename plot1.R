# plot1.R
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

png(file = "plot1.png")
hist(data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
