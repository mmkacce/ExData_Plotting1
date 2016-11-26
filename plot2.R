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

plot(energy2$Global_active_power ~ energy2$Datetime, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")


#Saving the png

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()