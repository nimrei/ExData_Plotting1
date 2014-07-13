#Assignment 1 - Plot 4

source("getdata.R")

df <- get.data()

# Combine date and time into 1 column & coerce into POSIXct
df$Date <- as.POSIXct(paste(df$Date,df$Time),
                      format="%d/%m/%Y %H:%M:%S")

# set output file
png("plot4.png")

attach(df)

par(mfrow=c(2,2))

#top-left
plot(Date, Global_active_power, 
     xlab="", type="l", ylab="Global Active Power")

#top-right
plot(Date, Voltage, xlab="datetime", type="l")

#bottom-left
plot(Date, Sub_metering_1, 
     xlab="", type="l", ylab="Energy sub metering");
lines(Date, Sub_metering_2,col="red")
lines(Date, Sub_metering_3,col="blue")

legend("topright", cex=1, col=c("black", "red", "blue"), 
       lwd=1,
       y.intersp=1,xjust=1,
       text.width = strwidth("Sub_metering_1"),
       legend=c("Sub_metering_1", 
                "Sub_metering_2", 
                "Sub_metering_3"))

#bottom-right
plot(Date, Global_reactive_power,  xlab="datetime", type="l")

detach(df)

dev.off()