
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

# Plot as required
plot(hp.df, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Save the plot to a file
dev.copy(png,'plot2.png', width=480, height=480)
dev.off()