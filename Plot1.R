library(sqldf)

# get the file for only the 2 dates using the sqldf package
# I'm writing the file so that I dont have to keep reading the big file again and again.
inputfile <- read.csv.sql("./household_power_consumption.txt", sep =";",sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
write.csv(inputfile, "./household_power_consumtion_subset.txt")

# this is the main input file I'm going to use for the plots.
inputfile_1 <- read.csv("./household_power_consumtion_subset.txt")

hist(as.numeric(inputfile_1$Global_active_power), col ="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, filename = "./plot1.png")

dev.off()
