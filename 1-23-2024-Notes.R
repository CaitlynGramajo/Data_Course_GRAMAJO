# 01/23/2024

mtcars # the car data

#(1)
cars.4.cylinders<-mtcars[mtcars$cyl>4,] # cars with more than 4 cylinders

#(2)
Miles.per.gal<-cars.4.cylinders$mpg
car.4.average<-mean(Miles.per.gal) #16.64762
car.4.min<-min(Miles.per.gal) #10.4
car.4.max<-max(Miles.per.gal) #21.4
summary(cars.4.cylinders$mpg) #or do this to get all the things at once.

# object types refresher #### 
## Logical vector ####
c(TRUE,TRUE,FALSE,FALSE)
## Numeric vector ####
1:10
## Character vector ####
letters[3]
## Integer vector ####
c(1L,2L,3L)
## Data.Frame ####
mtcars[mtcars$cyl>4,] #[] make is a data frame
## factor ####
as.factor(letters) # used for categorical data but R stores it as Levels
hair.colors<-c("brown", "blonde", "black", "red", "red","black")
as.factor(hair.colors)

#adding dark orchid3 it does not know what to do with it
c(as.factor(hair.colors), "darkorchid3")
as.numeric(as.factor(hair.colors), "darkorchid3") #dark orchid is rejected
as.character(c(as.factor(hair.colors), "darkorchid3")) #yay 
hair_colors<-as.factor(hair.colors)
hair_colors[7]<-"darkorchid3"
hair_colors
levels(hair_colors)

# Type conversions ####
1:5 # this is numeric
as.character(1:5) #now it is a character
as.numeric(letters) # gives NA means not there not able etc
as.numeric(c("1","b","35")) # does its best
x<-as.logical(c("true", "t", "F", "FALSE","T" )) # does its best t does not work for true
x
sum(x)
sum(TRUE)
TRUE+TRUE # true is 2
FALSE + 3 #false is 0
NA+2 # spits of NA, NA is missing data

# dealing with NA
sum(x,na.rm = TRUE)

# data frames ####
str(mtcars) #structure
names(mtcars) #gives the column names
as.character(mtcars) #it is no longer a data frame and looks weird

#turn columns into characters but keep the data frame
mtcars[,"mpg"]
for (col in names(mtcars)){
  mtcars[,col]<-as.character(mtcars[,col])
}
mtcars
str(mtcars)
data("mtcars") #resets built in data frame

"./Data/"

path<-("C:/Users/caitl/DataClass/Data_Course_GRAMAJO/Data/cleaned_bird_data.csv")
bird<-read.csv(path)
for (col in names(bird)){
  bird[,col]<-as.character(bird[,col])
}
bird
getwd() #make sure you are in "C:/Users/caitl/DataClass/Data_Course_GRAMAJO"

#not using the full path hehehe
# convert all columns to characters yeee

path2<-("./Data/cleaned_bird_data.csv")
bird2<-read.csv(path)
for (col in names(bird2)){
  bird2[,col]<-as.character(bird2[,col])
}
bird2
#write a new csv file to computer
write.csv(bird2, file="./Data/cleaned_bird_data_character.csv")

# apply family functions ####
data("mtcars")
apply(mtcars,2,as.character) # faster way to change columns to character
s
#others versions of apply
#lapply(list,function)
#sapply(list, function)
#vapply(list, function, FUN.VALUE = type,...)

apply(mtcars,2,as.character)
apply(mtcars,2,as.factor)

# Packages ####
## tidyverse ####
library(tidyverse) # I need to update my R boooo
# stats::filter() use filter from the stats package
# dplyer::filter use filter from the dplyer package

# %>%  need tidyverse to use
mtacrs %>% #control + shift + m
  filter(mpg>19)

# %>% pipe
# thing on first side becomes the first argument
mtcars$mpg %>% mean()
abs(mean(mtcars$mpg))

mtcars %>% 
  mean() %>% 
  abs() %>%
mtcars %>% 
  filter(mpg>19 & vs == 1)
