plot1<-function(){
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
          power<- read_csv2("./data/household_power_consumption.txt", na="?",col_names=TRUE)
          
          ## format the Date column as type Date
          power$Date<-as.Date(power$Date, format="%d/%m/%Y")
          
          ## subset the file to use only date from February 1st and 2nd of 2007
          powersub<-filter(power, (Date=="2007-02-01")|(Date=="2007-02-02"))
          
          ## format Global_active_power column as type numeric (double)
          powersub$Global_active_power<-as.numeric(powersub$Global_active_power)
          
          ## open a .png file for the plot
          png(filename="./data/plot1.png", width=480, height=480)
          ## create the histogram in red, using the Global_active_power column as data, and label appropriately
          hist(powersub$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
          ## turn off png device
          dev.off()
          
}



