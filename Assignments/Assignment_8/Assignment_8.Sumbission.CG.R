## Date, Name, Class, Assignment Number ####

#03/19/2024
#Caitlyn Gramajo
#BIO 3100  Assignment 8

##Library####
library(tidyverse)
library(easystats)
library(modelr)
library(MASS)

##Tasks####

###Task 1####
#loads the “/Data/mushroom_growth.csv” data set
data<-read_csv("./mushroom_growth.csv")

###Task 2####
#creates several plots exploring relationships between the response and predictors

colnames(data)

data %>% 
  ggplot(mapping = aes(x=Species, y=GrowthRate, color = factor(Species)))+
  geom_point()+
  ggtitle("GrowthRate split by Species")

#P.cornucopiae seems to have some higher growth rates and it more spread out at growth rate increases. P.osteotus has less variation and seems to max out at about 250.

data %>% 
  ggplot(mapping = aes(x=Species, y=GrowthRate, color = factor(Light)))+
  geom_point()+
  ggtitle("GrowthRate split by Species colored by Light")

#Adding in light we see that more light seems to lead to a higher growth rate because when light is at 20 for both species it is higher than when it is as 0 or 10.

data %>% 
  ggplot(mapping = aes(x=Nitrogen, y=GrowthRate, color = factor(Nitrogen)))+
  geom_point()+
  ggtitle("GrowthRate V Nitrogen")

#Plotting Growth Rate against Nitrigen we can see a curve that implys that growth rate seems to have a max at 25. It also seems to have a non linear relationships

data %>% 
  ggplot(mapping = aes(x=Temperature, y=GrowthRate, color = factor(Temperature)))+
  geom_point()+
  ggtitle("GrowthRate v Temperature")

#Plotting growth rate against temperature we see that lower temperature can lead to a higher growth rate with more variability that higher temperature.

data %>% 
  ggplot(mapping = aes(x=Temperature, y=GrowthRate, color = factor(Light)))+
  geom_point()+
  ggtitle("GrowthRate v Temperature colored by Light")

#Plotting growth rate against temperature colored by light we see that lower temperature can lead to a higher growth rate with more variability that higher temperature and that more light seems to lead to more growth in both groups.
  
data %>% 
  ggplot(mapping = aes(x=Humidity, y=GrowthRate, color = factor(Humidity)))+
  geom_point()+
  ggtitle("GrowthRate v Humidity")

#Plotting growth rate against humidity see that higher humidity can lead to a higher growth rate with more variability than lower humidity.

###Task 3####
#defines at least 4 models that explain the dependent variable “GrowthRate”

mod1<-glm(data = data,
          formula = log(GrowthRate) ~ Species + Light + Temperature)
summary(mod1)

mod2<-glm(data = data,
          formula = log(GrowthRate)~Nitrogen)

mod3<-glm(data = data,
          formula = log(GrowthRate)~factor(Species))

mod4<-glm(data = data,
          formula = log(GrowthRate)~Light)

mod5<-glm(data = data,
          formula = log(GrowthRate)~factor(Humidity))

mod6<-glm(data = data,
          formula = log(GrowthRate)~Temperature)

compare_models(mod1,mod2,mod3,mod4,mod5,mod6)
compare_performance(mod1,mod2,mod3,mod4,mod5,mod6) 

###Task 4####
#calculates the mean sq. error of each model

compare_models(mod1,mod2,mod3,mod4,mod5,mod6)
compare_performance(mod1,mod2,mod3,mod4,mod5,mod6) 

#mod1 RMSE 0.678 on the log scale
#mod2 RMSE 0.815 on the log scale
#mod3 RMSE 0.805 on the log scale
#mod4 RMSE 0.689 on the log scale
#mod5 RMSE 0.715 on the log scale
#mod6 RMSE 0.815 on the log scale

###Task 5 ####
#selects the best model you tried

compare_performance(mod1,mod2,mod3,mod4,mod5,mod6) %>% plot

#Model 1 is the best in every category besides BIC_wt. I am going to use model 1.

###Task 6####
#adds predictions based on new hypothetical values for the independent variables used in your model

df <- data %>% 
  add_predictions(mod1) 
df %>% dplyr::select("GrowthRate","pred")

new_Species<-data.frame(Species=c("P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae"))

new_Light<-data.frame(Light = c(0,10,20,0,10,20,0,10,20,0,10,20,0,10,20,0,10,20))

new_Temperature<-data.frame(Temperature = c(20,25,20,25,20,25,20,25,20,25,20,25,20,25,20,25,20,25))

newdf<-as.data.frame(c(new_Species, new_Light, new_Temperature))

pred <- predict(mod1, newdata = newdf)

hyp_pred<-data.frame(Species = newdf$Species,
                     Light = newdf$Light,
                     Temperature = newdf$Temperature,
                     pred = pred)
df$PredictionType <- "Real"
hyp_pred$PredictionType <- "Hypothetical"
fullpred<-full_join(df,hyp_pred)

###Task 7####
#plots these predictions alongside the real data

fullpred %>%
  mutate(GrowthRate = log(GrowthRate)) %>%
  ggplot(aes(x = Light, y = pred, color = PredictionType)) +
  geom_point(alpha = 0.75) +
  geom_point(aes(y = GrowthRate), color = "darkorchid3", alpha = 0.25) +
  theme_minimal()+
  ggtitle("Predicted GrowthRate V Light")

fullpred %>%
  mutate(GrowthRate = log(GrowthRate)) %>%
  ggplot(aes(x = Species, y = pred, color = PredictionType)) +
  geom_point(alpha = 0.75) +
  geom_point(aes(y = GrowthRate), color = "darkorchid3", alpha = 0.25) +
  theme_minimal()+
  ggtitle("Predicted GrowthRate V Species")

fullpred %>%
  mutate(GrowthRate = log(GrowthRate)) %>%
  ggplot(aes(x = Temperature, y = pred, color = PredictionType)) +
  geom_point(alpha = 0.75) +
  geom_point(aes(y = GrowthRate), color = "darkorchid3", alpha = 0.25) +
  theme_minimal()+
  ggtitle("Predicted GrowthRate V Temperature")

##Part 2####
#Upload responses to the following as a numbered plaintext document to Canvas:

###Question 1####
#Are any of your predicted response values from your best model scientifically meaningless? Explain.

#All of the predictions make sense in context. They are all positive meaning that the plant is growing and not dying.

###Question 2####
#In your plots, did you find any non-linear relationships? Do a bit of research online and give a link to at least one resource explaining how to deal with modeling non-linear relationships in R.

#Yes in the GrowthRate V Nitrogen plot a curve shows up indicating a non-linear relationship.

#https://www.geeksforgeeks.org/non-linear-regression-in-r/

###Question 3####
#Write the code you would use to model the data found in “/Data/non_linear_relationship.csv” with a linear model (there are a few ways of doing this)

#copying over the non_linear_relationshop.csv to this project

data2<-read_csv("./non_linear_relationship.csv")
data2 %>% 
  ggplot(mapping = aes(x=predictor, y = response))+
  geom_point(color="darkorchid3")+
  theme_minimal()

mod10<-glm(data = data2,
           formula = response ~ predictor)

boxcox_result<-boxcox(mod10)

lambda <- boxcox_result$x[which.max(boxcox_result$y)]

transformed_y <- if (lambda == 0) log(data2$response) else ((data2$response^lambda - 1) / lambda)

data3 <- data.frame(predictor = data2$predictor, transformed_y)

mod10.2 <- glm(data = data3,
               formula = transformed_y ~ predictor)
summary(mod10.2)

#The new linear model will be modeling the transformed variable as a response of the predictor x
