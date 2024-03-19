## Date, Name, Class, Assignment Number ####

#03/11/2024
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
  geom_point()

data %>% 
  ggplot(mapping = aes(x=Species, y=GrowthRate, color = factor(Light)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=Nitrogen, y=GrowthRate, color = factor(Nitrogen)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=Temperature, y=GrowthRate, color = factor(Temperature)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=Humidity, y=GrowthRate, color = factor(Humidity)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=seq_along(GrowthRate), y = GrowthRate, color = factor(Light)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=seq_along(GrowthRate), y = GrowthRate, color = factor(Humidity)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=seq_along(GrowthRate), y = GrowthRate, color = factor(Temperature)))+
  geom_point()

data %>% 
  ggplot(mapping = aes(x=seq_along(GrowthRate), y = GrowthRate, color = factor(Species)))+
  geom_point()

###Task 3####
#defines at least 4 models that explain the dependent variable “GrowthRate”

mod1<-glm(data = data,
          formula = GrowthRate ~ Species * Light * Nitrogen * Humidity * Temperature)
summary(mod1)

mod2<-glm(data = data,
          formula = GrowthRate ~ Species + Light + Nitrogen + Humidity + Temperature)
summary(mod2)

mod3<-glm(data = data,
          formula = GrowthRate ~ Light + Species + Humidity)
summary(mod3)

mod4<-glm(data = data,
          formula = GrowthRate ~ Light + Species:Light +Light:Temperature +Species:Light:Temperature)

summary(mod4)

mod5<-glm(data = data,
          formula = GrowthRate ~ Light)
summary(mod5)

mod6<-glm(data = data,
          formula = log(GrowthRate) ~ as.factor(Humidity))
summary(mod6)

mod7<-glm(data = data,
          formula = log(GrowthRate) ~ Nitrogen)
summary(mod7)

mod8<-glm(data = data,
          formula = log(GrowthRate) ~ as.factor(Species))
summary(mod8)

mod9<-glm(data = data,
          formula = log(GrowthRate) ~ Light)

mod9<-glm(data = data,
          formula = log(GrowthRate) ~ Temperature)


###Task 4####
#calculates the mean sq. error of each model

compare_models(mod1,mod2,mod3,mod4,mod5)
compare_performance(mod1,mod2,mod3,mod4,mod5)

compare_models(mod5,mod6,mod7,mod8,mod9)
compare_performance(mod5,mod6,mod7,mod8,mod9)

#mod1 RMSE 71.73
#mod2 RMSE 48.295
#mod3 RMSE 72.413
#mod4 RMSE 81.35
#mod5 RMSE 87.766

###Task 5 ####
#selects the best model you tried

compare_performance(mod1,mod2,mod3,mod4,mod5) %>% plot

compare_performance(mod5,mod6,mod7,mod8,mod9) %>% plot

#Model 2 is the best

###Task 6####
#adds predictions based on new hypothetical values for the independent variables used in your model

df <- data %>% 
  add_predictions(mod2) 
df %>% dplyr::select("GrowthRate","pred")

new_Species<-data.frame(Species=c("P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae"))

new_Light<-data.frame(Light = c(0,10,20,0,10,20,0,10,20,0,10,20,0,10,20,0,10,20))

new_Nitrogen<-data.frame(Nitrogen = c(0,5,10,20,25,30,35,40,45,0,5,10,20,25,30,35,40,45))

new_Humidity<-data.frame(Humidity = c("Low","High","Low","High","Low","High","Low","High","Low","High","Low","High","Low","High","Low","High","Low","High"))

new_Temperature<-data.frame(Temperature = c(20,25,20,25,20,25,20,25,20,25,20,25,20,25,20,25,20,25))

newdf<-as.data.frame(c(new_Species, new_Light, new_Nitrogen, new_Temperature, new_Humidity))

pred <- predict(mod2, newdata = newdf)

hyp_pred<-data.frame(Species = newdf$Species,
                     Light = newdf$Light,
                     Humidity = newdf$Humidity,
                     Temperature = newdf$Temperature,
                     Nitrogen = newdf$Nitrogen,
                     pred = pred)
df$PredictionType <- "Real"
hyp_pred$PredictionType <- "Hypothetical"
fullpred<-full_join(df,hyp_pred)

###Task 7####
#plots these predictions alongside the real data

fullpred %>% 
  ggplot(aes(x=pred, y = pred, color=PredictionType))+
  geom_point()+
  geom_point(aes(y=GrowthRate), color = "darkorchid3", alpha = 0.5)+
  theme_minimal()

##Part 2####
#Upload responses to the following as a numbered plaintext document to Canvas:

###Question 1####
#Are any of your predicted response values from your best model scientifically meaningless? Explain.

#Yes some of them are negative which does not make sense in this context unless the plants are dying I hope they are not.

###Question 2####
#In your plots, did you find any non-linear relationships? Do a bit of research online and give a link to at least one resource explaining how to deal with modeling non-linear relationships in R.

#Yes the final plot shows that the Growth Rate seems to have an curved relationship probably exponential in nature

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

#try poly or transform data
