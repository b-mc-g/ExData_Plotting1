# Read data from the txt file in the working directory into R
pdata <- read.table("household_power_consumption.txt", skip = 1, sep = ";", na.strings = '?')

# Add the column names according to the data field descriptions at
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

names(pdata) <- c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3")

# Convert Date variable to Date class using the as.Date function
pdata$Date <- as.Date(pdata$Date, format = "%d/%m/%Y")

# Extract the subset of data from "pdata" for the dates, 1 Feb 2007 and 2 Feb 2007
dsubset <- subset(pdata, pdata$Date == "2007-02-01" | pdata$Date == "2007-02-02")

# For the data subset "dsubset" only - 
# Concatenate Date and Time objects using the function paste and then 
# convert to a class representing date and time using as.POSIXct()
# and add the data to the data frame "dsubset" in new column called "DataTime"
dsubset$DateTime <- as.POSIXct(paste(dsubset$Date, dsubset$Time))

# Create Plot 3 and store it as "plot3.png" in working directory
# The variable Sub_metering_1 is plotted against the new DateTime variable
# using plot type "l" for a line and using the default color black
# Then 2 lines are added to the plot, for Sub_metering_2 and Sub_metering_3 
# colored red and blue respectively

# Open the plotting device with the required dimensions
png(filename = './plot3.png', width = 480, height = 480, units='px')

plot(dsubset$DateTime,dsubset$Sub_metering_1, 
     xlab = '', 
     ylab = 'Energy sub metering', 
     type = 'l')

lines(dsubset$DateTime, dsubset$Sub_metering_2, col = 'red')
lines(dsubset$DateTime, dsubset$Sub_metering_3, col = 'blue')

# Finally we add a legend using the legend function
legend('topright', col = c('black', 'red', 'blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd = 1
       )

# Close the plotting device
dev.off()















