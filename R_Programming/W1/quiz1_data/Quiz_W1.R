#--------
# Quiz W1
#--------

initial_wd <- getwd()
setwd("E:\\_ws\\git_repos\\datasciencecoursera\\quiz1_data")

my_df <- read.csv("hw1_data.csv")

# Q11 - what are the column names of the dataset?
names(my_df)

# Q12 - Extract the first 2 rows
head(my_df, 2)
my_df[1:2,]

# Q13 - How many observations (i.e. rows)?
nrow(my_df) # or first element of dim(my_df)

# Q14 - Extract the  last 2 rows
tail(my_df, 2)

# Q15 - What is the value of Ozone in the 47th row?
my_df[47,]

# Q16 - How many missing values are in the Ozone?
sum(is.na(my_df$Ozone))

# Q17 - What is the mean of the Ozone column in this dataset? Exclude missing values.
mean(my_df$Ozone, na.rm = TRUE)

# Q18 - Extract the subset of rows of the data frame where Ozone values are above 31
#       and Temp values are above 90. What is the mean of Solar.R in this subset?
my_indexes <- my_df$Ozone > 31 & my_df$Temp > 90
my_subset <- my_df[my_indexes,]
mean(my_subset$Solar.R, na.rm = TRUE)

# Q19 - What is the mean of "Temp" when "Month" is equal to 6?
my_indexes <- my_df$Month == 6
my_subset <- my_df[my_indexes,]

# Q20 - What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
my_indexes <- my_df$Month == 5
my_subset <- my_df[my_indexes,]


setwd(initial_wd)

