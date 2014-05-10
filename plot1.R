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

##open PNG device - width and height 480px
png(file="plot1.png", width=480, height=480, units="px")

##make the histogram and annotate
hist(power_data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

##close PNG device
dev.off()

##reset working directory to parent directory
setwd(paste("..", folder_char, sep=""))
