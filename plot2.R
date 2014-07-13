#Assignment 1 - Plot 2

source("getdata.R")

df <- get.data()

# Combine date and time into 1 column & coerce into POSIXct
df$Date <- as.POSIXct(paste(df$Date,df$Time),
                      format="%d/%m/%Y %H:%M:%S")

# set output file
png("plot2.png", width=504, height=504, bg="transparent")

with(df,
  plot(Date, Global_active_power, 
       xlab="", type="l", 
       ylab="Global Active Power (kilowatts)")
  )

dev.off()