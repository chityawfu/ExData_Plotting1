#Name: Fu Chit Yaw
#Date: 12 Jun 2016
#Title: Plot4



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


# Plot 3
# convert data and time to specific format
dat$Date <- as.Date(dat$Date, format = '%d/%m/%Y')
dat$datetime <- strptime(paste(dat$Date,dat$Time), "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2))

plot(dat$datetime, dat$Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatt)', type = 'l')
plot(dat$datetime, dat$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
plot(dat$datetime, dat$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
lines(dat$datetime, dat$Sub_metering_2, col = 'red')
lines(dat$datetime, dat$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
plot(dat$datetime, dat$Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')

dev.copy(png, file="./plot4.png", width=480, height=480)
dev.off()
cat("Plot4.png has been saved in", getwd(),"\n")