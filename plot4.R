#Download and unzip file
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<- "Electric_Power_Consumption.zip"
download.file(url, destfile = filename,method= "curl")
unzip(filename)
data<-read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?")

#Convert Date and Time column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subset data
dt <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Combine Date and Time
datetime <- paste(dt$Date, dt$Time)
dt$Datetime <- as.POSIXct(datetime)

#Create plot 4
par(mfrow=c(2,2))

##Graph (1,1)
plot(dt$Global_active_power~dt$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="",xaxt = "n")
# Create custom x-axis labels for Thu, Fri, and Sat
library(lubridate)
x_labels <- seq(min(dt$Datetime), max(dt$Datetime) + days(1), by = "day")  # Adjust the by parameter as needed
x_labels_text <- sapply(x_labels, function(d) {
  wd <- weekdays(d)
  if (wd == "Thursday") "Thu"
  else if (wd == "Friday") "Fri"
  else if (wd == "Saturday") "Sat"
  else NA
})
# Remove NA values (days not Thu, Fri, or Sat)
x_labels <- x_labels[!is.na(x_labels_text)]
x_labels_text <- x_labels_text[!is.na(x_labels_text)]
# Plot the custom x-axis labels
axis(1, at = x_labels, labels = x_labels_text, las = 1, cex.axis = 1)

##Graph (1,2)
plot(dt$Voltage~dt$Datetime, type="l", ylab="Voltage", xlab="datetime",xaxt = "n")

# Plot the custom x-axis labels
axis(1, at = x_labels, labels = x_labels_text, las = 1, cex.axis = 1)

##Graph(2,1)
plot(dt$Sub_metering_1~dt$Datetime, type = "l",xaxt = "n",xlab="",ylab = "Energy sub metering")
lines(dt$Sub_metering_2~dt$Datetime,type="l",col="red")
lines(dt$Sub_metering_3~dt$Datetime,type="l",col="blue")
legend("topright", col=c("black", "red", "blue"),cex = 0.7, lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Plot the custom x-axis labels
axis(1, at = x_labels, labels = x_labels_text, las = 1, cex.axis = 1)

##Graph(2,2)
plot(dt$Global_reactive_power~dt$Datetime,type="l",xlab="datetime",xaxt="n",ylab = "Global_reactive_power")
# Plot the custom x-axis labels
axis(1, at = x_labels, labels = x_labels_text, las = 1, cex.axis = 1)

#Save graph
dev.copy(png, "plot4.png",
         width  = 480,
         height = 480)

dev.off()
