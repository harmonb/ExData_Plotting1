##Read in file
temp<-read.table("household_power_consumption.txt", sep=";", header=T, 
                 stringsAsFactors=F)

##Subset data
data<-subset(temp, temp$Date=="1/2/2007" | temp$Date=="2/2/2007")

## Create a variable of date and time and convert to POSIXct
datetime<-paste(data$Date, data$Time)
datetime<-as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S")

## Make the variables and data frames to make the third plot.  I tried to make this
## plot just using the datetime variable and different versions on nrg, but
## R would not do it because the x and y were different lengths.  The only way I
## could get it work was to make data frames of both variables.  There is probably
## a much more elegant and/or efficient way to do this, though.

nrg1<-as.numeric(data$Sub_metering_1)
nrg2<-as.numeric(data$Sub_metering_2)
nrg3<-as.numeric(data$Sub_metering_3)
nrg<-data.frame(nrg1,nrg2,nrg3)
datetime.df<-data.frame(datetime,datetime,datetime)

## Make the 4-panel plot (as a png) with the panels being 1) line plot of Global Active
## Power over the two days, 2) line plot of voltage over the two days, 
## 3) the line plot of three sub meters over the two days, and 4) a line plot
## of global reactive power over the two days

png(file="pngplot4.png")
par(mfrow=c(2,2))
plot( datetime, as.numeric(data$Global_active_power), type='l',
     ylab="Global Active Power", xlab="")
plot( datetime, as.numeric(data$Voltage), type='l',
      ylab="Voltage", xlab="datetime")
plot(datetime.df[,1],nrg[,1],type="n",xlab="", ylab="Energy sub metering")
points(datetime.df[,1],nrg[,1],type='l')
points(datetime.df[,1],nrg[,2],type='l',col="red")
points(datetime.df[,1],nrg[,3],type='l',col="blue")
legend("topright", pch="-",col=c("black","blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot( datetime, as.numeric(data$Global_reactive_power), type='l',
      ylab="Global_reactive_power", xlab="datetime")
dev.off()