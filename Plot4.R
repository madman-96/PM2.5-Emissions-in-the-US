#Plot4

# reading in the data files and libraries
emissions <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#remove unnecessary columns
scc_lim <- scc[,c("SCC", "Short.Name")]

#merge emissions and scc_lim based on scc number
em_new <- merge(emissions, scc_lim,by="SCC")

#subset only coal combustion related sources from short name
coal_data <- em_new[grepl("Coal", em_new$Short.Name), ]

#aggregate coal data based on total emissions per year
coal_comb <- aggregate(coal_data$Emissions, by = list(coal_data$year), FUN = sum)

names(coal_comb) <- c("Year","Total.Coal.Emission")

#save the plot in a png file adhering to the pixel limits
png("Plot4.png", width=480, height=480)

par(mar = c(4, 4, 2, 2), oma = c(0, 0, 0, 0))
plot(x=coal_comb$Year, y=coal_comb$Total.Coal.Emission, pch = 20, type = "b", col = "green", xlab = "Year",
     ylab = "Total PM2.5 Coal Emissions", 
     main = "Trend in PM2.5 Coal Emissions from 1999 to 2008",
     lwd = 3,
     ylim = c(340000,600000))
text(coal_comb$Total.Coal.Emission ~ coal_comb$Year, labels=coal_comb$Year,data=coal_comb, cex=0.7, font=2, pos = 1)

dev.off()

#Conclusion:
# Coal emissions saw a decrease from 1999 to 2008 with the exception of 2005.


