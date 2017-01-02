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

# Create Plot 4 and store it as "plot4.png" in working directory
# 4 plots are created in 2 rows and 2 columns.
# Graphs are created by row i.e row 1 col 1 then row 1 col 2 etc

# The variables Global_active_power and Voltage  are
# plotted against the new DateTime variable in two seperate plots
# in position 1,1 and 1,2. 
# 
# Position 2,1 is a plot followed by the addition of two lines 
# for Sub_metering_1 to _3 respectively using plot type "l" for a line.
# A legend is also created.
#
# The last plot in position 2,2 is for Global_reactive_power against DateTime
# 

# Open the plotting device with the required dimensions
png(filename = './plot4.png', width = 480, height = 480, units='px')

par(mfrow = c(2, 2))
plot(dsubset$DateTime,dsubset$Global_active_power, 
     xlab = '', 
     ylab = 'Global Active Power (kilowatt)', 
     type = 'l'
     )
plot(dsubset$DateTime, dsubset$Voltage, 
     xlab = 'datetime', 
     ylab = 'Voltage', 
     type = 'l'
     )
plot(dsubset$DateTime, dsubset$Sub_metering_1, 
     xlab = '', 
     ylab = 'Energy sub metering', 
     type = 'l'
     )
lines(dsubset$DateTime, dsubset$Sub_metering_2, col = 'red')
lines(dsubset$DateTime, dsubset$Sub_metering_3, col = 'blue')

legend('topright', 
       col = c('black', 'red', 'blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd = 1
       )

plot(dsubset$DateTime, dsubset$Global_reactive_power, 
     xlab = 'datetime', 
     ylab = 'Global_reactive_power', 
     type = 'l'
     )


# Close the plotting device
dev.off()



