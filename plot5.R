## Read data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# merge data sets
NEISCC <- merge(NEI, SCC, by="SCC")

library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

neiSubset <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggTotalByYear <- aggregate(Emissions ~ year, neiSubset, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(aggTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()