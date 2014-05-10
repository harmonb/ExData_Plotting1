
##Read in file
  power<-"household_power_consumption.txt"
  temp<-read.table(power, sep=";", header=T, stringsAsFactors=F)

##Subset data
  data<-subset(temp, temp$Date=="1/2/2007" | temp$Date=="2/2/2007")

## Create a variable of date and time and convert to POSIXct
  datetime<-paste(data$Date, data$Time)
  datetime<-as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S")

## Make the histogram of Global Active Power as a png
  png(file="plot1.png")
  hist(as.numeric(data$Global_active_power), col='red',
    xlab="Global Active Power(kilowatts)", main="Global Active Power")
  dev.off()
