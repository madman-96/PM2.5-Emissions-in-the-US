#Plot3

## reading in the data files and libraries
emissions <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#subset data for only Baltimore city (fips == "24510")
em_bal <- emissions[(emissions$fips == 24510),]

#Create a dataframe consisting of total emissions based on year and type
bal_data <- aggregate(em_bal$Emissions, by=list(em_bal$year,em_bal$type), FUN = sum)

names(bal_data) <- c("Year", "Type", "Total_Emission")

#save the plot in a png file adhering to the pixel limits
png("Plot3.png", width=480, height=480)

g <- ggplot(bal_data, aes(Year, Total_Emission))
g + geom_line() + facet_wrap(.~Type) + labs(title = "Emissions in Baltimore City (1999-2008) by pollutant type")+geom_point(data = bal_data, aes(Year, Total_Emission, color = "red"), show.legend = FALSE)

dev.off()

#Conclusion:
# All 4 types of pollutant sources saw a decrease in total emissions from 1999 to 2008

