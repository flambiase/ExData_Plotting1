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
png(filename = "plot3.png",
    width = 480, height = 480)

## Create line chart 
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
       col=c("black","blue","red")) 



## Close PNG file
dev.off()

