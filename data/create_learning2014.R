#Tuukka Oikarinen
#09.11.2022
#Creating analysis data set from Learning2014 data for ODS2022 course

#libraries
library(tidyverse)

#reading in the data
lrn14 <- read.table(file = "C:/ODS2022/IODS-project/data/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#explore the structure and dimensions of the data. Write short code comments describing the output of these explorations.
dim(lrn14)
str(lrn14)

#There are 183 rows and 60 columns. Most of the variables are integers but at least "gender" is character.

#attitude
lrn14$attitude <- lrn14$Attitude / 10

#deep
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])

#surf
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])

#stra
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

#keep columns
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

#changing column names
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

#Exclude observations where the exam points variable is zero.
learning2014 <- filter(learning2014, points > 0)

#set working directory
setwd("C:/ODS2022/IODS-project/data")

#check wd
getwd()

#write csv
write.csv(learning2014,"C:/ODS2022/IODS-project/data\\learning2014.csv", row.names = FALSE)

#demonstrating read.csv
learning2014_demonstration <- read_csv(file = 'C:/ODS2022/IODS-project/data\\learning2014.csv')

str(learning2014_demonstration)
head(learning2014_demonstration)