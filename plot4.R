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
#concatenating date and time and creating single date object
data_final$fulldate<- paste(data_final$Date, data_final$Time)
tm2.lub <- ymd_hms(data_final$fulldate)
#creating formatted time variable for graphs
data_final$time_for_graph <- (day(tm2.lub)-1)+hour(tm2.lub)/24+minute(tm2.lub)/(24*60)

#graphing
png("plot4.png", 480, 480)
par(mfrow= c(2,2))
with(data_final, {

#adding 1st graph
plot( data_final$time_for_graph , (as.numeric(data_final$Global_active_power)*2/1000), type="l",
ylab="Global Active Power (kilowatts)",xlab ="", xaxt="n"
)
axis(1, at=c(0,1,2),tick = TRUE, lab=c("Thu","Fri","Sat"))

#adding  2nd graph
plot( data_final$time_for_graph , as.numeric(data_final$Voltage), type="l",
ylab="Voltage",xlab ="", xaxt="n"
)
axis(1, at=c(0,1,2),tick = TRUE, lab=c("Thu","Fri","Sat"))

#adding 3rd graph
plot( data_final$time_for_graph , as.numeric(data_final$Sub_metering_1), type="l",
ylab="Energy sub metering",xlab ="", xaxt="n")

lines( data_final$time_for_graph , as.numeric(data_final$Sub_metering_2), type="l",
ylab="Energy sub metering",xlab ="", xaxt="n", col = "red")

lines( data_final$time_for_graph , as.numeric(data_final$Sub_metering_3), type="l",
ylab="Energy sub metering",xlab ="", xaxt="n", col = "blue")


legend(1.3,34,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
cex=0.8, lty=c(1,1,1), col=c("black","blue","red")   )
axis(1, at=c(0,1,2),tick = TRUE, lab=c("Thu","Fri","Sat"))

#adding 4th graph
plot( data_final$time_for_graph , as.numeric(data_final$Global_reactive_power), type="l",
ylab="Global_reactive_power",xlab ="", xaxt="n"
)
axis(1, at=c(0,1,2),tick = TRUE, lab=c("Thu","Fri","Sat"))

})

dev.off()