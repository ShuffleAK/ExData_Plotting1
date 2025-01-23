#Download and unzip file
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<- "Electric_Power_Consumption.zip"
download.file(url, destfile = filename,method= "curl")
unzip(filename)
data<-read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?")

#Convert Date and Time column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

#Subset data
dt <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Create and save plot1
hist(dt$Global_active_power,col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power")
dev.copy(png, "plot1.png",
         width  = 480,
         height = 480)

dev.off()