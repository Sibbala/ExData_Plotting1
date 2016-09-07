getwd()
library(dplyr)
library(ggplot2)
library(reshape2)
library(grid)

### Setting the working Directory
==================================
setwd("C:/Users/Gowtham/Documents/")

### Reading the Source file into Reading
========================================
file_rd <-read.csv("household_power_consumption.txt",header = T,sep=";",stringsAsFactors = FALSE)

### Changing the Data Type for DATE column to filter the data based on Date
===========================================================================
file_rd$Date <- as.Date(file_rd$Date,"%d/%m/%Y")
file_rd_2days <- subset(file_rd, Date =='2007-02-01' | Date=='2007-02-02')
nrow(file_rd_2days)

### Adding a new column to concatinate the date and time
======================================================================================
file_rd_2days <- mutate(file_rd_2days, Date_Time = paste(Date, Time, sep = " "))
str(file_rd_2days)

### Change the data type for required columns
==============================================
file_rd_2days$Date_Time <- strptime(file_rd_2days$Date_Time, format=("%Y-%m-%d %H:%M:%S"))
file_rd_2days[, 3:9] <- lapply(file_rd_2days[, 3:9], as.numeric)
file_rd_2days <- file_rd_2days[, c(10, 3:9)]

### Command to draw the Plot:4

par(mfrow = c(2,2))
plot(file_rd_2days$Date_Time, file_rd_2days$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(file_rd_2days$Date_Time, file_rd_2days$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(file_rd_2days$Date_Time, file_rd_2days$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(file_rd_2days$Date_Time, file_rd_2days$Sub_metering_2, type = "l", col = "red")
points(file_rd_2days$Date_Time, file_rd_2days$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.75)

plot(file_rd_2days$Date_Time, file_rd_2days$Global_reactive_power,type = "l", ylab = "Global reactive power", xlab = "datetime")
