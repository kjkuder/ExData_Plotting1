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

# Open the PNG device, and make the line graph
png(filename="plot2.png")
with(epc, plot(SampleTime, Global_active_power, type = "l",
               ylab = "Global Active Power (kilowatts)", xlab=""))

# Close the PNG file
dev.off()

