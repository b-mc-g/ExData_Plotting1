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


# Create Plot 2 and store it as "plot2.png" in working directory
# The variable Global_active_power is plotted against the new DateTime variable
# using plot type "l" for a line

# Open the plotting device  with the required dimensions
png(filename = './plot2.png', width = 480, height = 480, units='px')

plot (dsubset$DateTime, dsubset$Global_active_power,
           xlab = "", 
           ylab = "Global Active Power (kilowatts)", 
           type = "l"
      )


# Close the plotting device
dev.off()