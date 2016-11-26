#Sourcing the data from my working directory

energy <- read.table("household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     na.strings="?")

#(FILTERING) Create a new dataframe with only the requested 2 day's data

energy$help <- ifelse(energy$Date == "1/2/2007",1, ifelse(energy$Date == "2/2/2007",1,0) )

energy2 <- energy[(energy$help == 1),]


## Set the dates
energy2$Date <- as.Date(energy2$Date, format="%d/%m/%Y")
energy2$Datetime <- as.POSIXct(paste(as.Date(energy2$Date), energy2$Time))

#Creating the plot
#Please be advised that on the x axis the "cs" "P", "SZ" refers to "Thu", "Fri", "Sat" which is the shorten of the appropriate day names in Hungarian (Csütörtök - Thuesday, Péntek - Friday, Szombat - Saturday)

energy2$Global_active_power <- as.numeric(energy2$Global_active_power)



par(mfrow=c(2,2), mar=c(4,4,4,4))


#PLOT1

plot(energy2$Global_active_power ~ energy2$Datetime, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")

#PLOT2

plot(energy2$Voltage ~ energy2$Datetime, type = "l", xlab = "datetime", ylab = "Voltage")

##PLOT 3

with(energy2, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", col = "black")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.3, pt.cex = 2)

##PLOT4

plot(energy2$Global_reactive_power ~ energy2$Datetime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")



#Saving the png

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


