library(sqldf)

# get the file for only the 2 dates using the sqldf package
# I'm writing the file so that I dont have to keep reading the big file again and again.
inputfile <- read.csv.sql("./household_power_consumption.txt", sep =";",sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
write.csv(inputfile, "./household_power_consumtion_subset.txt")

# this is the main input file I'm going to use for the plots.
inputfile_1 <- read.csv("./household_power_consumtion_subset.txt")

# Get the datetime field correct. This is required for the x-axis to plot points for time
Datetime <- strptime(paste(as.Date(inputfile_1$Date, "%d/%m/%Y"), inputfile_1$Time), "%Y-%m-%d %H:%M:%S")
inputfile_1 <- cbind(inputfile_1,Datetime)

# plot the first graph
with(inputfile_1, plot(Datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " "))
# add points for the 2nd and 3rd graphs with appropriate color
with(inputfile_1,points(Datetime, Sub_metering_2, type = "l", col = "red"))
with(inputfile_1,points(Datetime, Sub_metering_3, type = "l", col = "blue"))

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1,col = c("black", "red","blue"))

# width parameter was necessary otherwise the legend was getting cut off in the png
dev.copy(png, filename = "./plot3.png", width = 780)

dev.off()
