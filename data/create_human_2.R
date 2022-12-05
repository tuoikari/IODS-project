#Create human script, part2
#Tuukka Oikarinen
#30.11.2022

#
library(tidyverse)

#read in data
human <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", sep=",", header=TRUE)

str(human)
dim(human)

#Data contains 195 observations/rows and 19 variables. It contains two character variables (Country, GNI). Others are integers and numerical variables.
#It contains information 195 countries on their HDI-rank and factors affecting to their HDI-index
#it contains information on life expectancy, expected education yers, Gross National Income (GNI) per Capita, labour force participation etc.

#edit file so that it does not include commas
human$GNI <- str_replace(human$GNI, pattern=",", replace ="")
#check if worked
human$GNI

#change to numeric
human$GNI <- as.numeric(human$GNI)

#check if worked
human$GNI
class(human$GNI)

human <- human %>% select("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
head(human)

human <- filter(human, complete.cases(human))
human

#remove 
last <- nrow(human) - 7
human <- human[1:last, ]

rownames(human) <- human$Country
human <- select(human, -Country)
str(human)

write.csv(human,"C:/ODS2022/IODS-project/data\\human.csv", row.names = FALSE)
