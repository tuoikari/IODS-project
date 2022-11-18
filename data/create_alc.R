#Tuukka Oikarinen
#14.11.2022
#Data wrangling UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) https://archive.ics.uci.edu/ml/datasets/Student+Performance

#Read in math data
data_math <- read.table(file = "C:/ODS2022/IODS-project/data/student-mat.csv", sep=";", header=TRUE)

#Read in Portuguese class questionaire data
data_por <- read.table(file = "C:/ODS2022/IODS-project/data/student-por.csv", sep=";", header=TRUE)

#Explore math data
str(data_math)
dim(data_math)
str(data_math_por)
dim(data_math_por)
#Explore Portuguese data
str(data_por)
dim(data_por)

# give the columns that vary in the two data sets
varying_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
joining_cols <- setdiff(colnames(data_por), varying_cols)

# join the two data sets by the selected identifiers
data_math_por <- inner_join(data_math, data_por, by = joining_cols, suffix = c(".math", ".por"))

#Explore new data set
str(data_math_por)
dim(data_math_por)



# print out the column names of 'data_math_por'
colnames(data_math_por)

# create a new data frame with only the joined columns
data_alc <- select(data_math_por, all_of(joining_cols))

# print out the columns not used for joining (those that varied in the two data sets)
varying_cols

# for every column name not used for joining...
for(col_name in varying_cols) {
  # select two columns from 'data_math_por' with the same original name
  two_cols <- select(data_math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the data_alc data frame
    data_alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the data_alc data frame
    data_alc[col_name] <- first_col
  }
}

#take average of daily and weekend alcohol use and create new column "alc_use"
data_alc <- mutate(data_alc, alc_use = (Dalc + Walc) / 2)

#create high_use column which has values TRUE/FALSE depending on the value in alc_use-column
data_alc <- mutate(data_alc, high_use = alc_use > 2)

#glimpse the data set and its structure
head(data_alc)
dim(data_alc)
str(data_alc)
#The data set now has 370 rows/observations and 35 variables