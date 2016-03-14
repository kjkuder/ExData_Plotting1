# This script reads electric power consumption data and builds a plot
# for a two-day subset.

# Read electric power consumption data, convert dates & times,
# subset to the two paricular dates for the project, and
# convert sub meters to numbers.
epc <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";",
                colClasses = c(rep("character",2),rep("numeric",7)),
                na.strings = "?")
epc$SampleTime<-as.POSIXlt(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")
epc <- subset(epc, ((SampleTime >= "2007-02-01") & (SampleTime < "2007-02-03")))

# Move SampleTime to the first column and drop the remaining Date and Time
# columns which are no longer needed.
epc <- (epc[c(10, 3:9)])

# Open the PNG device, and make the 3-line graph
png(filename="plot3.png")
with(epc, plot(SampleTime, Sub_metering_1, type = "l",
               ylab = "Energy sub metering", xlab="", col = "black"))
with(epc, lines(SampleTime, Sub_metering_2, col = "red"))
with(epc, lines(SampleTime, Sub_metering_3, col = "blue"))
legend(x="topright", legend = c("Sub_metering_1", "Sub_metering_2", 
       "Sub_metering_3"), lty = c(1,1), col = c("black", "blue", "red"))

# Close the PNG file
dev.off()

