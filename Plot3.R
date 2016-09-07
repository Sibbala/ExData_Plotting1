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

### Command to draw the Plot:3
===============================
cols <- c("Sub_metering_1"= "black", "Sub_metering_2" ="#F8766D" , "Sub_metering_3" = "#00BFC4")
(ggplot(file_rd_2days)
       + geom_line(aes(Date_Time, Sub_metering_1, color = "Sub_metering_1"))
       + geom_line(aes(Date_Time, Sub_metering_2, color = "Sub_metering_2"))
       + geom_line(aes(Date_Time, Sub_metering_3, color = "Sub_metering_3"))
       + labs(x = "", y = "Energy sub metering")
       + scale_colour_manual(name="",values=cols)
       + theme(legend.justification = c(1, 1), legend.position = c(1, 1), legend.title = element_blank()))

