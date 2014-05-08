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



# Plot 1 - histogram ------------------------------------------------------
hist( as.numeric(my.data$Global_active_power), 
      xlab = "Global Active Power (kilowatts)", 
      main = "Global Active Power", 
      col="red" )

# copy plot to png file
dev.copy(png, file = "plot1.png")
dev.off()

