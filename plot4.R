## Read two days' data for energy consumption by one household
# File must be downloaded and unzipped in current working directory
library(dplyr)
library(lubridate)
datall <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                     stringsAsFactors=FALSE)
dat  <- subset(datall, Date=="1/2/2007" | Date=="2/2/2007")
dat$Date <- as.Date(dat$Date , "%d/%m/%Y")
dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$DateTime <- ymd_hms(paste(dat$Date, dat$Time, sep=" "))

## Open PNG file
png(filename = "plot4.png",
    width = 480, height = 480)

## Create line charts
par(mfrow=c(2,2))

# 1: Global Active Power by day
plot(dat$DateTime, dat$Global_active_power,
     type="n",
     ylab="Global Active Power (kilowatts)",
     xlab = "")
axis(1, labels=wday(dat$DateTime, label= TRUE), xaxt="n", at =wday(dat$DateTime))
lines(dat$DateTime, dat$Global_active_power)

# 2: Voltage by day
plot(dat$DateTime, dat$Voltage,
     type="n",
     ylab="Voltage",
     xlab="datetime")
axis(1, labels=wday(dat$DateTime, label= TRUE), xaxt="n", at =wday(dat$DateTime))
lines(dat$DateTime, dat$Voltage)

#3: Energy sub metering by day
plot(dat$DateTime, dat$Sub_metering_1,
     type="n",
     ylab="Energy sub metering",
     xlab = "")
axis(1, labels=wday(dat$DateTime, label= TRUE), xaxt="n", at =wday(dat$DateTime))
lines(dat$DateTime, dat$Sub_metering_1)
lines(dat$DateTime, dat$Sub_metering_2, col="red")
lines(dat$DateTime, dat$Sub_metering_3, col="blue")

legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1, 1), 
       cex=0.6,
       bty="n",
       col=c("black","blue","red")) 


#4: Global Reactive Power by day
plot(dat$DateTime, dat$Global_reactive_power,
     type="n",
     ylab="Global_reactive_power",
     xlab="datetime")
axis(1, labels=wday(dat$DateTime, label= TRUE), xaxt="n", at =wday(dat$DateTime))
lines(dat$DateTime, dat$Global_reactive_power)



## Close PNG file
dev.off()

