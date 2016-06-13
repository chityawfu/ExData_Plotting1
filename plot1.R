#Name: Fu Chit Yaw
#Date: 12 Jun 2016
#Title: Plot1



"Add long comment here within quotation marks"

if (FALSE)
{
"Put disabled block of code here"     
        
}

rm(list=ls()) #clear all variables
cat("\014") #clear console
setwd("c:/MYDS")



#Download data & unzip file 
if(!file.exists('data')) dir.create('data')
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
temp<-tempfile()
download.file(fileUrl, destfile=temp)
unzip(temp, exdir = './data')
unlink(temp) #delete temp folder
   

#Read subset of large data into R
fp1 <- "./data/household_power_consumption.txt"
matchedlines<-grep("^[1,2]/2/2007",readLines(fp1),value=TRUE) #return lines matching search criteria
dat<- read.table(text=matchedlines, sep=";",col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),stringsAsFactors=FALSE,na.strings = '?')


# Plot 1
par(mfrow=c(1,1)) #make sure mfrow set to default value
with(dat, hist(Global_active_power, xlab = 'Global Active Power (kilowatt)', main = 'Global Active Power', col = 'red'))
dev.copy(png, file="./plot1.png", width=480, height=480)
# close device
dev.off()
cat("Plot1.png has been saved in", getwd(),"\n")