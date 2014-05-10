##Read in file
temp<-read.table("household_power_consumption.txt", sep=";", header=T, 
                 stringsAsFactors=F)

##Subset data
data<-subset(temp, temp$Date=="1/2/2007" | temp$Date=="2/2/2007")

## Create a variable of date and time and convert to POSIXct
datetime<-paste(data$Date, data$Time)
datetime<-as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S")

## Make the variables and data frames to make the plot.  I tried to make this
## plot just using the datetime variable and different versions on nrg, but
## R would not do it because the x and y were different lengths.  The only way I
## could get it work was to make data frames of both variables.  There is probably
## a much more elegant and/or efficient way to do this, though.

nrg1<-as.numeric(data$Sub_metering_1)
nrg2<-as.numeric(data$Sub_metering_2)
nrg3<-as.numeric(data$Sub_metering_3)
nrg<-data.frame(nrg1,nrg2,nrg3)
datetime.df<-data.frame(datetime,datetime,datetime)

## Make the line plot of Energy sub metering as a png
png(file="plot3.png")
plot(datetime.df[,1],nrg[,1],type="n",xlab="", ylab="Energy sub metering")
points(datetime.df[,1],nrg[,1],type='l')
points(datetime.df[,1],nrg[,2],type='l',col="red")
points(datetime.df[,1],nrg[,3],type='l',col="blue")
legend("topright", pch="-",col=c("black","blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()