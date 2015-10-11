library(sqldf)
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
png(filename="plot1.png", width=480, height=480, units="px")
hist(powerdata$Global_active_power, main='Global Active Power', xlab='Global Active Power (kilowatts)', ylab = 'Frequency', col="red")
dev.off()


          
         