
# Get the data into memory
hp <- read.csv2("household_power_consumption.txt", header = T)

# Cast the Date column
hp$Date <- as.Date(hp$Date, "%d/%m/%Y")

# Subset to get the dates important to this project
hp.sub <- subset(hp, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

# Get a numeric vector out of the factor
hp.v <- as.numeric(as.character(hp.sub[,3]))

# Plot the histogram as required
hist(hp.v, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Save the plot to a file
dev.copy(png,'plot1.png', width=480, height=480)
dev.off()