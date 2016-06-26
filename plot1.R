## Read two days' data for energy consumption by one household
# File must be downloaded and unzipped in current working directory
library(dplyr)
datall <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                     stringsAsFactors=FALSE)
dat  <- subset(datall, Date=="1/2/2007" | Date=="2/2/2007")
dat$Date <- as.Date(dat$Date , "%d/%m/%Y")
dat$Global_active_power <- as.numeric(dat$Global_active_power)

## Open PNG file
png(filename = "plot1.png",
    width = 480, height = 480)

## Create histogram
with(dat,
     hist(Global_active_power,
          col="red",
          main = "Global Active Power", 
          xlab="Global Active Power (kilowatts)"))

## Close PNG file
dev.off()

