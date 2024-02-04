#02/03/2024
#Caitlyn Gramajo
#Assignment 4 

library(tidyverse)

#TASK 5 ####


#Data can be found here####
#https://www.kaggle.com/datasets/mitchellfriess/fsscores?resource=download

data<-read.csv(".\\Data\\WC_Scores_Men.csv")

data$Quads.in.FS<-as.numeric(data$Quads.in.FS)

names(data)

data %>% 
ggplot(mapping = aes(x =Year, y = Quads.in.FS)) +
  geom_bar(stat = "identity", fill = "darkorchid4") +
  labs(x = "Year", y = "Number of Quads Done") +
  ggtitle("Number of Quads Done per Year") +
  theme_minimal()

#It is observed that the number of Quadruple jumps done in the Free skate increases over time.