#Plot6

## reading in the data files and libraries
emissions <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#subset data for only Baltimore city (fips == "24510") & LA (fips == "06037")
em_bal_la <- emissions[(emissions$fips == "24510" | emissions$fips == "06037" ),]

#remove unnecessary columns from scc
scc_lim <- scc[,c("SCC", "Short.Name")]

#merge emissions and scc_lim based on scc number
em_new <- merge(em_bal_la, scc_lim,by="SCC")

#subset only motor vehicle related sources from short name
veh_data <- em_new[grepl("Veh", em_new$Short.Name), ]

#aggregate veh data based on total emissions per year
veh_em <- aggregate(veh_data$Emissions, by = list(veh_data$year, veh_data$fips), FUN = sum)

names(veh_em) <- c("Year","City", "Total.Vehicle.Emission")

#Replace city codes with city names
veh_em$City <- gsub("06037", "LA", veh_em$City)
veh_em$City <- gsub("24510", "Baltimore", veh_em$City)

#save the plot in a png file adhering to the pixel limits
png("Plot6.png", width=480, height=480)

g <- ggplot(veh_em, aes(Year, Total.Vehicle.Emission))
g + geom_line(aes(color = City)) + ylab("Total Emissions from motor vehicles (tons)")
      + labs(title = "Vehicle Emissions LA vs Baltimore City (1999-2008)") 
      + theme(plot.title = element_text(hjust = 0.5))

dev.off()

#Difference in emissions from 1999-2008
diff_la <- veh_em[(veh_em$City == "LA" & veh_em$Year == "2008"),3] - veh_em[(veh_em$City == "LA" & veh_em$Year == "1999"),3]
diff_bal <- veh_em[(veh_em$City == "Baltimore" & veh_em$Year == "2008"),3] - veh_em[(veh_em$City == "Baltimore" & veh_em$Year == "1999"),3]

#Conclusion
#The greatest magnitude of change in motor vehicle emissions occurred in Baltimore City
#which experienced a decrease of 258.5445426 tons, while Los Angeles experienced an 
#increase of 163.43998 tons during the 1999-2008 period.

