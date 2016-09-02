#--------
# Quiz W3
#--------

initial_wd <- getwd()
setwd("E:\\_ws\\git_repos\\datasciencecoursera\\R_Programming\\W3")

#----
# Q1:
# There will be an object called 'iris' in your workspace. In this dataset, 
# what is the mean of 'Sepal.Length' for the species virginica? 
# Please round your answer to the nearest whole number.
#----
library(datasets)
data(iris)
?iris
tapply(iris$Sepal.Length, iris$Species, mean, na.rm = TRUE)
# setosa versicolor  virginica 
# 5.006      5.936      6.588 

#----
# Q2:
# Continuing with the 'iris' dataset from the previous Question, what R code 
# returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width',
# 'Petal.Length', and 'Petal.Width'?
#----
apply(iris[, 1:4], 2, mean)     # Good
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 5.843333     3.057333     3.758000     1.199333 

#apply(iris[, 1:4], 1, mean)    # No Good
#colMeans(iris)                 # No Good
#apply(iris, 1, mean)           # No Good
#rowMeans(iris[, 1:4])          # No Good
#apply(iris, 2, mean)           # No Good


#----
# Q3:
# How can one calculate the average miles per gallon (mpg) 
# by number of cylinders in the car (cyl)? Select all that apply.
#----
library(datasets)
data(mtcars)
?mtcars
#mean(mtcars$mpg, mtcars$cyl)               # No Good
tapply(mtcars$mpg, mtcars$cyl, mean)        # Good
sapply(split(mtcars$mpg, mtcars$cyl), mean) # Good
#sapply(mtcars, cyl, mean)                  # No Good
with(mtcars, tapply(mpg, cyl, mean))        # Good
#tapply(mtcars$cyl, mtcars$mpg, mean)       # No Good
#apply(mtcars, 2, mean)                     # No Good
#split(mtcars, mtcars$cyl)                  # No Good
#lapply(mtcars, mean)                       # No Good

#----
# Q4:
# Continuing with the 'mtcars' dataset from the previous Question, 
# what is the absolute difference between the average horsepower of 4-cylinder
# cars and the average horsepower of 8-cylinder cars?
# Please round your final answer to the nearest whole number
#----
hp_by_cyl <- lapply(split(mtcars$hp, mtcars$cyl), mean)
abs(hp_by_cyl$`4` - hp_by_cyl$`8`)
# [1] 126.5779

setwd(initial_wd)