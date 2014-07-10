
# Get the data into memory
hp <- read.csv2("household_power_consumption.txt", header = T)

# Cast the Date column
hp$Date <- strptime(paste(hp$Date,hp$Time), format="%d/%m/%Y %H:%M:%S")

# Subset to get the dates important to this project
hp.sub <- subset(hp, Date >= as.POSIXlt('2007-02-01 00:00') 
                 & Date <= as.POSIXlt('2007-02-02 23:59'))

# Get a numeric vector out of the factor
hp.v <- as.numeric(as.character(hp.sub[,3]))

# Create a dataframe for proper labeling with the days of week
hp.df <- data.frame(hp.sub$Date,hp.v)

# Prepare the data for plotting
hp.sub$Sub_metering_1 <- as.numeric(as.character(hp.sub$Sub_metering_1))
hp.sub$Sub_metering_2 <- as.numeric(as.character(hp.sub$Sub_metering_2))
hp.sub$Sub_metering_3 <- as.numeric(as.character(hp.sub$Sub_metering_3))
hp.sub$Voltage <- as.numeric(as.character(hp.sub$Voltage))
hp.sub$Global_reactive_power <- as.numeric(as.character(hp.sub$Global_reactive_power))
hp.sub$Global_active_power <- as.numeric(as.character(hp.sub$Global_active_power))

# Use the png device to avoid squishing the legend
png("plot4.png", width=480, height=480)

# Plot as required
# Set up environment parameters
par(mfcol=c(2,2))

# Global active power
hp.df <- data.frame(hp.sub$Date,hp.sub$Global_active_power)
plot(hp.df, type="l", ylab="Global Active Power", xlab="")


# Energy sub metering
plot(hp.sub$Date, hp.sub$Sub_metering_1, type="n", 
     ylab="Energy sub metering",
     xlab="")
lines(hp.sub$Date, hp.sub$Sub_metering_1, type="l")
lines(hp.sub$Date, hp.sub$Sub_metering_2, type="l", col="red")
lines(hp.sub$Date, hp.sub$Sub_metering_3, type="l", col="blue")
legend("topright", 
       lty="solid", 
       bty="n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Voltage plot
hp.df <- data.frame(hp.sub$Date,hp.sub$Voltage)
plot(hp.df, type="l", xlab="datetime", ylab="Voltage")

# Global reactive power plot
hp.df <- data.frame(hp.sub$Date,hp.sub$Global_reactive_power)
plot(hp.df, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save the plot to a file
dev.off()