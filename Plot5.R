#Plot5

# reading in the data files and libraries
emissions <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#subset data for only Baltimore city (fips == "24510")
em_bal <- emissions[(emissions$fips == 24510),]

#remove unnecessary columns from scc
scc_lim <- scc[,c("SCC", "Short.Name")]

#merge emissions and scc_lim based on scc number
em_new <- merge(em_bal, scc_lim,by="SCC")

#subset only motor vehicle related sources from short name
veh_data <- em_new[grepl("Veh", em_new$Short.Name), ]

#aggregate veh data based on total emissions per year
veh_em <- aggregate(veh_data$Emissions, by = list(veh_data$year), FUN = sum)

names(veh_em) <- c("Year","Total.Vehicle.Emission")

#save the plot in a png file adhering to the pixel limits
png("Plot5.png", width=480, height=480)

g <- ggplot(veh_em, aes(Year, Total.Vehicle.Emission))
g + geom_line() + ggtitle("Vehicle PM2.5 Emissions in Baltimore City (1999-2008)")+geom_point(data = veh_em, aes(Year, Total.Vehicle.Emission, color = "red"), show.legend = FALSE) + theme(plot.title = element_text(hjust = 0.5))

dev.off()

#Conclusion:
# Decrease in motor vehicle emissions from 1999 to 2008

