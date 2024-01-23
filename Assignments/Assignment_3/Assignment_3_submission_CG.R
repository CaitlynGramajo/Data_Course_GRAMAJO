# BIO 3100
# Assignment 3
# 01/23/2024
# Caitlyn Gramajo

# Task 1 #### 
# Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150

even.iris<-iris[seq(2,150,2),]
even.iris

# Task 2 ####
# Create a new object called iris_chr which is a copy of iris, except where every column is a character class

iris_chr<-apply(iris,2,as.character)
iris_chr

# Task 3 ####
#Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width

data("iris")
Sepal.Area<-iris$Sepal.Length*iris$Sepal.Width
Sepal.Area

# Task 4 ####
# Add Sepal.Area to the iris data frame as a new column

IRIS<-cbind(iris,Sepal.Area)

#  Task 5 ####  
# Create a new dataframe that is a subset of iris using only rows where Sepal.Area is greater than 20 
# (name it big_area_iris)

big_area_iris<-IRIS[IRIS$Sepal.Area>20,]
big_area_iris

# Task 6 ####  
# Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
# to canvas
# I should be able to run your R script and get all the right objects generated
