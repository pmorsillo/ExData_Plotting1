plot3<-function() {
          library(readr)
          library(dplyr)
          
          ## If a /data directory does not exist, create one before downloading the file from the class 
          ## website.  Once downloaded, unzip the file, and read into power.
          
          if (!dir.exists("./data")) {
                    dir.create("./data")
          }
          if (!file.exists("./data/household_power_consumption.txt")) {
                    fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                    download.file(fileUrl, destfile="./data/powerconsump.zip")
                    unzip(zipfile="./data/powerconsump.zip", exdir="./data")          
          }
          power<- read_csv2("./data/household_power_consumption.txt", col_types="ccccccccc", na="?",col_names=TRUE)
          
          ## format the Date column as type Date
          power$Date<-as.Date(power$Date, format="%d/%m/%Y")
          
          ## subset the file to use only date from February 1st and 2nd of 2007
          powersub<-filter(power, (Date=="2007-02-01")|(Date=="2007-02-02"))
          
          ## create a new column, datetime, a combination of Date and Time columns
          powersub <- transform(powersub, datetime=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %S")
          
          ## format the Sub metering columns to numeric
          powersub$Sub_metering_1<-as.numeric(powersub$Sub_metering_1)
          powersub$Sub_metering_2<-as.numeric(powersub$Sub_metering_2)
          powersub$Sub_metering_3<-as.numeric(powersub$Sub_metering_3)
          
          ## open a .png file for the plot
          png(filename="./data/plot3.png", width=480, height=480)
          ## create the histogram in red, using the Global_active_power column as data, and label appropriately
          with(powersub, {
                    plot(datetime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
                    lines(datetime, Sub_metering_2, col="orange", type="l")
                    lines(datetime, Sub_metering_3, col="blue", type="l")
                    legend("topright", lty=1, col=c("black", "orange", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
          })
          
          ## turn off png device
          dev.off()
}


