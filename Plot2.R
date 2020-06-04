#Plot2

## reading in the data files and libraries
emissions <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#subset data for only Baltimore city (fips == "24510")
em_bal <- emissions[(emissions$fips == 24510),]

#emissisons data in Baltimore City from 1999
em_99 <-  em_bal[(em_bal$year == 1999),]
sum(em_99$Emissions)

#emissisons data in Baltimore City from 2002
em_02 <-  em_bal[(em_bal$year == 2002),]
sum(em_02$Emissions)

#emissisons data in Baltimore City from 2005
em_05 <-  em_bal[(em_bal$year == 2005),]
sum(em_05$Emissions)

#emissisons data in Baltimore City from 2008
em_08 <-  em_bal[(em_bal$year == 2008),]
sum(em_08$Emissions)

df <- data.frame("Year" = c(1999, 2002, 2005, 2008), "Total Em" = c(sum(em_99$Emissions),sum(em_02$Emissions),sum(em_05$Emissions),sum(em_08$Emissions)))

#save the plot in a png file adhering to the pixel limits
png("Plot2.png", width=480, height=480)

par(mar = c(4, 4, 2, 2), oma = c(0, 0, 0, 0))
plot(x=df$Year, y=df$Total.Em, pch = 20, type = "b", col = "green", xlab = "Year",
     ylab = "Total PM2.5 Emissions", 
     main = "Trend in PM2.5 Emissions from 1999 to 2008 (Baltimore City)",
     lwd = 3,
     ylim = c(1500,3500))
text(df$Total.Em ~df$Year, labels=df$Year,data=df, cex=0.9, font=2, pos = 3)

dev.off()

#Conclusion:
#It can be observed that the PM2.5 emissions in Baltimore City have a decreasing 
#trend from 1999 to 2008 with an exception between 2002 to 2005 where there was an 
#uptick in emissions.





