#Tuukka Oikarinen
#11.12.2012
#data wrangling for Longitunal Data- exercise on IODS2022-course

#load dplyr
library(dplyr)

#read in BPRS data
data_BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep =" ")

#check the data set
dim(data_BPRS)
str(data_BPRS)
#40 rows, 11 variables

#read in RATS data
data_RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = "\t")

#check the data set
dim(data_RATS)
str(data_RATS)
#16 rows, 13 variables

#convert data_BPRS variables "treatment" and "subject" to factors for further analysis purposes
data_BPRS$treatment <- factor(data_BPRS$treatment)
data_BPRS$subject <- factor(data_BPRS$subject)

#check data
str(data_BPRS)

#convert data_RATS variables "ID" and "GROUP" to factors for further analysis purposes
data_RATS$ID <- factor(data_RATS$ID)
data_RATS$Group <- factor(data_RATS$Group)

#check data
str(data_RATS)

#change data_BPRS to long format and order by weeks
data_BPRSL <-  pivot_longer(data_BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

#add week variable to data_BPRSL
data_BPRSL <-  data_BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#change data_RATS to long format, mutate "Time" variable to get the week number,
data_RATSL <- pivot_longer(data_RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)

#check data sets
dim(data_BPRSL)
str(data_BPRSL)

dim(data_RATSL)
str(data_RATSL)

#describe data sets
#data_BPRSL has now 360 rows and 5 columns. Separate week columns were transformed to a one weeks column
#The week column was created by extracting the week number from the weeks column
#Treatment variable tells about which treatment group study subjects belonged to.
#Subject has subject number. There were 20 men in treatment 1- group and 20 to treatment 2. Hence the numbers
#bprs is a value for "brief psychiatric rating scale (BPRS)" (quotes from the exercise texts)
#"The BPRS assesses the level of 18 symptom constructs such as hostility, suspiciousness, hallucinations and grandiosity; each of these is rated from one (not present) to seven (extremely severe).
#The scale is used to evaluate patients suspected of having schizophrenia."

#data_RATSL has 176 rows and 5 columns
#info on data set from exercise set:
#data from a nutrition study conducted in three groups of rats. 
#The groups were put on different diets, and each animal’s body weight (grams) was recorded repeatedly (approximately) weekly, except in week seven when two recordings were taken) over a 9-week period."
#ID column is ID of the rat
#Groups-column tells which diet group the rat belonged to
#WD tells which week the weight in weight-column was taken
#weight is recorded body weight in grams
#Time was mutated by extracting week number from WD

#Why longitunal data:
#"To be able to study the possible differences in the bprs value between the treatment groups and the possible change of the value in time"
#combined week/time column with longitunal data makes it possible to use certain statistical methods to study change over time in longitunal data
#therefore the separate week columns are mutated to one long format column

#write the datas
write.csv(data_RATSL, "C:/ODS2022/IODS-project/data\\RATSL.csv", row.names = FALSE)

write.csv(data_BPRSL, "C:/ODS2022/IODS-project/data\\BPRSL.csv", row.names = FALSE)