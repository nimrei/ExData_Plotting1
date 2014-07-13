#Assignment 1 - Plot 1

source("getdata.R")

df <- get.data()

# Combine date and time into 1 column
df$Date <- as.POSIXct(paste(df$Date,df$Time),
                      format="%d/%m/%Y %H:%M:%S")

# plot data into "plot1.png" file
png("plot1.png")

with(df,
     hist(Global_active_power, 
          col="red", 
          main="Global Active Power",
          xlab="Global Acitve Power (kilowatts)", 
          ylab="Frequency")     
     )

dev.off()