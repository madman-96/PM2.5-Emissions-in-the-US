#Plot1

## reading in the data files and libraries
emissions <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#maybe merge based on scc

#emissisons data from 1999
em_99 <-  emissions[(emissions$year == 1999),]
sum(em_99$Emissions)

#emissisons data from 2002
em_02 <-  emissions[(emissions$year == 2002),]
sum(em_02$Emissions)

#emissisons data from 2005
em_05 <-  emissions[(emissions$year == 2005),]
sum(em_05$Emissions)

#emissisons data from 2008
em_08 <-  emissions[(emissions$year == 2008),]
sum(em_08$Emissions)

df <- data.frame("Year" = c(1999, 2002, 2005, 2008), "Total Em" = c(sum(em_99$Emissions),sum(em_02$Emissions),sum(em_05$Emissions),sum(em_08$Emissions)))

#save the plot in a png file adhering to the pixel limits
png("Plot1.png", width=480, height=480)

par(mar = c(4, 4, 2, 2), oma = c(0, 0, 0, 0))
plot(x=df$Year, y=df$Total.Em, pch = 20, type = "b", col = "green", xlab = "Year",
     ylab = "Total PM2.5 Emissions", main = "Trend in PM2.5 Emissions from 1999 to 2008",
     ylim = c(3000000,8000000))
text(df$Total.Em ~df$Year, labels=df$Year,data=df, cex=0.9, font=2, pos = 1)

dev.off()

#Conclusion:
#It can be observed that the PM2.5 emissions have a decreasing trend from 1999 to 2008