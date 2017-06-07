# This script replot the polt1.png in the project

# Set the file name, the data file should be put in the current working dir
fileName <- "household_power_consumption.txt"

# Read the first line of the data, then obtain the column names and the starting
# date and time
startData <- read.table(fileName, header = TRUE, sep = ";", nrows = 1, na.strings = "?")
ColNames <- names(startData)
# obtain the start time
stime <- strptime(paste(startData$Date, startData$Time), format = "%d/%m/%Y %H:%M:%S")

# compute which the row number of the data for 2007-02-01 starts
start_date070201<-strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")
# since the record is taken every minute, there are 24*60 record per day
# then the row number of the data for 2007-02-01 00:00:00 should be 
start_row_070201 <- as.numeric(start_date070201-stime)*24*60 + 1

# compute how many rows should be read
end_date070202<-strptime("02/02/2007 23:59:00", format = "%d/%m/%Y %H:%M:%S")
# then the total number of rows should be read is 
read_rows <- as.numeric(end_date070202-start_date070201)*24*60 + 1


# read the data for 2007-02-01 to 2007-02-02
PData <- read.table(fileName, sep = ";", header=TRUE, col.names = ColNames, 
                    skip = start_row_070201-1, nrows = read_rows, na.strings = "?")

# obtain the weekday 

# plot the time, global active power to the png file in the current working dir
png("plot2.png", width = 480, height = 480)
# set up the 1*1 plot
par(mfrow=c(1,1))
# prepare the x-axis which indicates the time
Time <-strptime(paste(PData$Date, PData$Time, " "),"%d/%m/%Y %H:%M:%S") 
plot(Time, PData$Global_active_power, type="l", xlab="", 
     ylab = "Global Active Power (kilowatts)")
dev.off()

# remove variables
remove("PData", "read_rows", "end_date070202", "start_row_070201", "start_date070201",
       "stime", "ColNames", "startData", "fileName", "Time")
