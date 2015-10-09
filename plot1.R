#reading data
mydata = read.table("household_power_consumption.txt",head= TRUE, sep=";") 
#formatting dates 
install.packages("lubridate")
library("lubridate")
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y") 
tm1.lub <- ymd(mydata$Date)
#subsetting data to only include 2 days
data_final <- subset(mydata,
year(tm1.lub)==2007 &
month(tm1.lub)==2 &
(day(tm1.lub)== 1 |
day(tm1.lub)== 2 )
)
#graphing (multiplied by 2/1000 to scale)
png("plot1.png", 480, 480)
hist((as.numeric(data_final$Global_active_power)*2/1000), col="red", 
main="Global Active Power", xlab="Global Active Power (kilowatts)", 
ylim=c(0,1250))
dev.off()
  