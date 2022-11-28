#Tuukka Oikarinen
#Data wrangling for next's week IODS-course.
#28.11.2022

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#Explore hd-data
dim(hd)
str(hd)
summary(hd)

#Explore gii-data
dim(gii)
str(gii)
summary(gii)

library(tidyverse)

#Renaming variables based on the metadata-file
hd <- hd %>% 
  rename(
    "GNI" = "Gross National Income (GNI) per Capita",
    "Life.Exp" = "Life Expectancy at Birth",
    "Edu.Exp" = "Expected Years of Education")

gii <- gii %>%
  rename("Mat.Mor" = "Maternal Mortality Ratio",
         "Ado.Birth" = "Adolescent Birth Rate")

gii <- gii %>%
  rename("Parli.F" = "Percent Representation in Parliament",
         "Edu2.F" = "Population with Secondary Education (Female)",
         "Edu2.M" = "Population with Secondary Education (Male)",
         "Labo.F" = "Labour Force Participation Rate (Female)",
         "Labo.M" = "Labour Force Participation Rate (Male)")

gii <- gii %>%
  mutate("Edu2.FM" = Edu2.F / Edu2.M)

gii <- gii %>%
  mutate("Labo.FM" = Labo.F / Labo.M)

human <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))

write.csv(human,"C:/ODS2022/IODS-project/data\\human.csv", row.names = FALSE)