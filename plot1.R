#Sourcing the data from my working directory

energy <- read.table("household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     na.strings="?")

#(FILTERING) Create a new dataframe with only the requested 2 day's data

energy$help <- ifelse(energy$Date == "1/2/2007",1, ifelse(energy$Date == "2/2/2007",1,0) )

energy2 <- energy[(energy$help == 1),]


#Creating the plot

energy2$Global_active_power <- as.numeric(energy2$Global_active_power)

hist(energy2$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")


#Saving the png

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()