# Using data.table package
require(data.table)

# Setting my current working directory. You may need to change this if you would like to run the code
# setwd("P:/ImpDocuments/Exploratory_Data_Analysis_052014/Assignments/ExData_Plotting1/")

# Reading data
all.data <- fread("../exdata-data-household_power_consumption/household_power_consumption.txt", 
                  header=T, sep=";", na.strings=c("NA", '', '?'), colClasses="character") 

# Formating Date using as.Date
all.data[, New_Date:=as.Date(Date, format="%d/%m/%Y")]

# Keeping only required 2 days worth of data
my.data <- all.data[New_Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Order by date and time
my.data <- my.data[order(Date, Time)]

# converts character vectors of Date and Time to class "POSIXlt" 
date_time <- strptime(paste(my.data$Date, my.data$Time), "%d/%m/%Y %H:%M:%S")


# Plotting 4 plots on one screen ------------------------------------------------------------

par(mfrow=c(2,2))

## 1st plot

# Setting margin to get rid of xlab
par(mar=c(3,4.1,4.1,2.1))

# Line plot with continuous date_time value
with( my.data, plot( date_time, 
                     as.numeric(Global_active_power), 
                     type="l", 
                     ylab="Global Active Power (kilowatts)"),
                     xlab=NULL)



## 2nd plot
par(mar=c(4.1,4.1,4.1,2.1))

# Line plot with continuous date_time value
with( my.data, plot( date_time, 
                     as.numeric(Voltage), 
                     type="l", 
                     ylab="Voltage",
                     xlab="datetime") )

## 3rd plot
# Setting margin to get rid of xlab
par(mar=c(3,4.1,4.1,2.1))

# Line plot with continuous date_time value
with( my.data, plot( date_time, 
                     as.numeric(Sub_metering_1), 
                     type="l", 
                     ylab="Energy sub meeting"),
                     xlab=NULL)

with( my.data, lines(date_time, 
                     as.numeric(Sub_metering_2), 
                     col="red") )

with( my.data, lines(date_time, 
                     as.numeric(Sub_metering_3), 
                     col="blue") )

legend("topright", bty="n" , y.intersp = 0.7, 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"),
       
       lty=c(1,1), # gives appropriate symbol e.g. lines
       
       lwd=c(2.5,2.5), # Line width 
       col=c("black", "red", "blue") # line colors
       )

## 4th plot

# Setting margin to get rid of xlab
par(mar=c(4.1,4.1,4.1,2.1))

# Line plot with continuous date_time value
with( my.data, plot( date_time, 
                     as.numeric(Global_reactive_power), 
                     type="l", 
                     ylab="Global_reactive_power",
                     xlab="datetime") )

# copy plot to png file
# Default width is 480 and image can't display legend or full plot properly
dev.copy(png, file = "plot4.png", width=870, height=600)
dev.off()
