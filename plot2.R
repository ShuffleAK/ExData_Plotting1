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

#Create and save Plot 2
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



