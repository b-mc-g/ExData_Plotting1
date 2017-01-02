# Read data from the txt file in the working directory into R
pdata <- read.table("household_power_consumption.txt", skip = 1, sep = ";", na.strings = '?')

# Add the column names according to the data field descriptions at
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

names(pdata) <- c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3")

# Convert Date variable to a Date class using the as.Date function
pdata$Date <- as.Date(pdata$Date, format="%d/%m/%Y")

# Extract the subset of data from "pdata" for the dates, 1 Feb 2007 and 2 Feb 2007
dsubset <- subset(pdata, pdata$Date == "2007-02-01" | pdata$Date == "2007-02-02")
                
# Create Plot 1 and store it as "plot1.png" in working directory

# Open the plotting device with the required dimensions
png(filename = './plots/plot1.png', width = 480, height = 480, units='px')

with (dsubset, 
      hist(Global_active_power, 
      xlab = "Global Active Power (kilowatts)", 
      ylab = "Frequency", 
      main = "Global Active Power",
      col = "red"
          )
      )

# Close the plotting device
dev.off()


