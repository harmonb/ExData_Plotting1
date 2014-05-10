##Read in file
temp<-read.table("household_power_consumption.txt", sep=";", header=T, 
                 stringsAsFactors=F)

##Subset data
data<-subset(temp, temp$Date=="1/2/2007" | temp$Date=="2/2/2007")

## Create a variable of date and time and convert to POSIXct
datetime<-paste(data$Date, data$Time)
datetime<-as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S")

## Make the line plot of time vs. Global active power as a png
power<-as.numeric(data$Global_active_power)
png(file="pngplot2.png")
plot(datetime, power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()