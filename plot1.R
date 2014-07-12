#Assignment 1

#CONFIGURATION

#location on the web of our zip file
source.web <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
source.local <- tail(unlist(strsplit(source.web,split="/")),n=1)

#new datafile name based on our filtering criteria
data.file <- "proj1.txt"


#download our file if we don't have it
if (!file.exists(source.local)) {
  download.file(source.web, source.local)
}

#get the actual filename from the unzipped version
source.unzip <- unzip(source.local, list=T)$Name


#rewrite a filtered version of the unzipped file to data.file
file.connection <- file(source.unzip, "r")

cat(grep("(^Date)|(^[1|2]/2/2007)",
         readLines(file.connection), 
         value=TRUE), 
    sep="\n", 
    file=data.file)

close(file.connection)


# Now read the full file
df <- read.table(data.file, header=T, sep=";", na.strings="?")

# Combine date and time into 1 column
df$Date <- as.POSIXct(paste(df$Date,df$Time),format="%d/%m/%Y %H:%M:%S")
df$Time <- NULL
# df$Date <- as.POSIXct(df$Date,format="%d/%m/%Y")
# df$Time <- as.POSIXct(df$Time,format="%H:%M:%S")
df$Weekday <- factor(format(df$Date,'%a'),levels=c("Mon","Tue","Wed","Thu","Fri","Sat","Sun"))


# plot data into "plot1.png" file
png("plot1.png")



#1
hist(df$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Acitve Power (kilowatts)", ylab="Frequency")

#2
plot(as.POSIXct(df$Date), df$Global_active_power, 
     xlab="", type="l", ylab="Global Active Power (kilowatts)")

#3
plot(as.POSIXct(df$Date),df$Sub_metering_1, 
     xlab="", type="l", ylab="Energy sub metering")
# add more lines to the same plot
lines(as.POSIXct(df$Date),df$Sub_metering_2,col="red")
lines(as.POSIXct(df$Date),df$Sub_metering_3,col="blue") 
# add a legend 
legend("topright", cex=1, col=c("black", "red", "blue"), 
       lwd=1,y.intersp=1,xjust=1,text.width = strwidth("Sub_metering_1"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4
par(mfrow=c(2,2))
# plot topleft
with(df, plot(Date, Global_active_power, 
                 xlab="", type="l", ylab="Global Active Power"))
# plot topright
with(df, plot(Date,Voltage, type="l"))    
# plot bottomleft 
with(df, plot(Date,Sub_metering_1, xlab="", type="l", ylab="Energy sub metering"))
with(df, lines(Date,Sub_metering_2,col="red"))
with(df, lines(Date,Sub_metering_3,col="blue"))
legend("topright", cex=1, col=c("black", "red", "blue"),lwd=2,bty="n",
                 y.intersp=0.8,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# plot bottomright
with(df, plot(Date, Global_reactive_power, type="l"))



dev.off()


# required.vars <- list(Date="character",
#                       Time="character",
#                       Global_active_power="numeric",
#                       Global_reactive_power="numeric",
#                       Voltage="numeric",
#                       Global_intensity="numeric",
#                       Sub_metering_1="numeric",
#                       Sub_metering_2="numeric",
#                       Sub_metering_3="numeric")

