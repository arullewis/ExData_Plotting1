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

#Check if the data exist in the environment

if(!'powerdata'%in% ls())
   {
setAs("character","PDate", function(from) as.Date(from, format="%d/%m/%Y") )
setClass("PDate")
tableColClass<- c('PDate','character','numeric','numeric','numeric', 'numeric','numeric','numeric','numeric')

powerdata<-read.csv("./data/household_power_consumption.txt", 
                    colClasses = tableColClass,header=TRUE, sep=';' ,na.strings="?")

#filter
powerdata<-powerdata[powerdata$Date>=as.Date("2007-02-01") & powerdata$Date<=as.Date("2007-02-02"),]


}

#add date & time together
powerdata<-mutate(powerdata, obsdatetime = ymd_hms(paste(Date,Time)))


#plot 
png(filename="plot2.png", width=480, height=480, units="px")
plot(powerdata$obsdatetime,powerdata$Global_active_power, type='l', xlab='', ylab='Global Active Power(kilowatts)')
dev.off()


          
         