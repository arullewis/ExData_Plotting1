library(dplyr)
library(lubridate)
#create data directory

if(!file.exists("data")){
        dir.create("data")
}

#download & extract the file - first time only
if(!file.exists("./data/housepowercon.zip"))
{
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data/housepowercon.zip")
unzip("./data/housepowercon.zip",exdir="./data")
        

}

if(!'powerdata'%in% ls())
   {
setAs("character","PDate", function(from) as.Date(from, format="%d/%m/%Y") )
setClass("PDate")
tableColClass<- c('PDate','character','numeric','numeric','numeric', 'numeric','numeric','numeric','numeric')

powerdata<-read.csv("./data/household_power_consumption.txt", 
                    colClasses = tableColClass,header=TRUE, sep=';' ,na.strings="?")

powerdata<-powerdata[powerdata$Date>=as.Date("2007-02-01") & powerdata$Date<=as.Date("2007-02-02"),]



}
powerdata<-mutate(powerdata, obsdatetime = ymd_hms(paste(Date,Time)))


png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
plot(powerdata$obsdatetime,powerdata$Global_active_power, type='l', xlab='', ylab='Global Active Power(kilowatts)')
plot(powerdata$obsdatetime,powerdata$Voltage, type='l', xlab='datetime', ylab='Voltage')
plot(powerdata$obsdatetime,powerdata$Sub_metering_1,type="l", xlab = '', ylab='Energy sub metering')
lines(powerdata$obsdatetime,powerdata$Sub_metering_2,type="l", col="red")
lines(powerdata$obsdatetime,powerdata$Sub_metering_3,type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lwd=2 ,bty="n")
plot(powerdata$obsdatetime,powerdata$Global_reactive_power,type="l", xlab = 'datetime', ylab='Global_relative_power')
dev.off()


          
         