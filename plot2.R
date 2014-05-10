library("graphics")
library("grDevices")

outputDir <- "ihh_power_data"
folder_char <- "\\"

##read data into R
##assumes that data is in working directory
##first 2 days in February 2007 already filtered)
power_data <- read.table("household_power_consumption_sel.txt", sep=";",header=TRUE,stringsAsFactors=FALSE)

##create subfolder (where output is placed) within working directory if it doesn't exist already
##NOTE: change folder_char when OS not Windows
if(!file.exists(paste(".", folder_char, outputDir, sep=""))){
  dir.create(paste(".", folder_char, outputDir, sep=""))
}

##set the subfolder as the new working directory
setwd(paste(".", folder_char, outputDir, sep=""))

##combine date and time into new variable DateTime
power_data$DateTime <- as.POSIXct(paste(power_data$Date, power_data$Time), format="%d/%m/%Y %H:%M:%S")

##open PNG device - width and height 480px
png(file="plot2.png", width=480, height=480, units="px")

##make the plot
plot(power_data$DateTime,power_data$Global_active_power,ylab="Global Active Power (kilowatts)", type="l", xlab="")

##close PNG device
dev.off()

##reset working directory to parent directory
setwd(paste("..", folder_char, sep=""))