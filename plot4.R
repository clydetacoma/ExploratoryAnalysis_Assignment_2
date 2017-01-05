## Read data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# merge data sets
NEISCC <- merge(NEI, SCC, by="SCC")

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

coal  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
neisccSubset <- NEISCC[coal, ]

aggTotalByYear <- aggregate(Emissions ~ year, neisccSubset, sum)

png("plot4.png", width=640, height=480)
g <- ggplot(aggTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()