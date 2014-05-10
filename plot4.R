library("graphics")
library("grDevices")

outputDir <- "ihh_power_data"
folder_char <- "\\"

##read data into R
##assumes that data is in working directory
##first 2 days in February 2007 already filtered)
power_data <- read.table("household_power_consumption_sel.txt", sep=";",header=TRUE,stringsAsFactors=FALSE)

##create subfolder within working directory if it doesn't exist already
##NOTE: change folder_char when OS not Windows
if(!file.exists(paste(".", folder_char, outputDir, sep=""))){
  dir.create(paste(".", folder_char, outputDir, sep=""))
}

##set the subfolder as the new working directory
setwd(paste(".", folder_char, outputDir, sep=""))

##combine date and time into new variable DateTime
power_data$DateTime <- as.POSIXct(paste(power_data$Date, power_data$Time), format="%d/%m/%Y %H:%M:%S")

##open PNG device - width and height 480px
png(file="plot4.png", width=480, height=480, units="px")

##set mfrow to output 4 plots in once
par(mfrow = c(2,2), mar=c(4,4,2,1))

##make upper left plot (1)
plot(power_data$DateTime,power_data$Global_active_power,ylab="Global Active Power", type="l", xlab="")
##make upper right plot (2)
plot(power_data$DateTime,power_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
##make the lower left plot (3)
##do not output anything yet
with(power_data, plot(DateTime,Sub_metering_1,xlab="",ylab="Energy sub metering", type="n"))
#add the three lines to the plot
with(power_data, lines(DateTime,Sub_metering_1,col="black"))
with(power_data, lines(DateTime,Sub_metering_2,col="red"))
with(power_data, lines(DateTime,Sub_metering_3, col="blue"))
##add the legend topright, with line symbols
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1, 1), col=c("black","red","blue"))
##make the lower right plot (4)
plot(power_data$DateTime,power_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##close PNG device
dev.off()

##reset working directory to parent directory
setwd(paste("..", folder_char, sep=""))
