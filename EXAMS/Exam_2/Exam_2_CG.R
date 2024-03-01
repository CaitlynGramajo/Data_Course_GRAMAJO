## Date, Name, Class, Exam Number ####

#02/29/2024
#Caitlyn Gramajo
#BIO 3100 Exam 2

## Library ####

library(tidyverse)
library(readxl)
library(easystats)
library(dplyr)

## Task 1 ####

#Read in the unicef data (10 pts)

#read in the unicef data

dat<-read_csv("unicef-u5mr.csv")

## Task 2 ####

#Get into tidy format (10 pts)

colnames(dat)

selected_columns<-(select(dat, starts_with("U5MR")))

selected_columns<-str(selected_columns)

selected_columns <- colnames(select(dat, starts_with("U5MR")))

dat1<-
  dat %>%
  pivot_longer(cols = selected_columns,
               names_to = "Year",
               values_to = "USMR") %>% 
  mutate(Year = gsub("U5MR\\.", "", Year),
         Year = as.numeric(Year))

## Task 3 ####

#Plot each country’s U5MR over time (20 pts)
  
task_3_plot<-
  dat1 %>% 
    ggplot( aes( x=Year, y = USMR, group=CountryName))+
    geom_line(color="darkorchid4")+
    facet_wrap(~Continent)+
    labs(x = "Year", y = "Under-5 Mortality Rate") +
    theme_minimal()+
    ggtitle("U5MR Over Time by Continent")
  scale_x_continuous(breaks = c(1960,1980,2000)) 
  
task_3_plot
  
## Task 4 ####
  
#Save this plot as LASTNAME_Plot_1.png (5 pts)
  
ggsave("GRAMAJO_Plot_1.png", task_3_plot)
    
## Task 5 ####
  
#Create another plot that shows the mean U5MR for all the countries within a given continent at each year (20 pts)
colnames(dat1)

dat2<-
  dat1 %>% 
  group_by(Continent, Year) %>% 
  summarise(Mean_USMR=mean(USMR, na.rm = T))

task_5_plot<-
  dat2 %>% 
  ggplot( aes( x= Year, y =Mean_USMR, group=Continent, color=Continent))+
  geom_line(size = 1.5)+
  labs(x = "Year", y = " Mean Under-5 Mortality Rate") +
  theme_minimal()+
  ggtitle("Mean U5MR Over Time by Continent")

task_5_plot

## Task 6 ####

#Save that plot as LASTNAME_Plot_2.png (5 pts)

ggsave("GRAMAJO_Plot_2.png", task_5_plot)

## Task 7 ####

# Create three models of U5MR (20 pts)
#- mod1 should account for only Year
#- mod2 should account for Year and Continent
#- mod3 should account for Year, Continent, and their interaction term\

mod1<-glm(data=dat1,
          formula= USMR ~ Year)

mod2<-glm(data= dat1,
          formula = USMR ~ Year + Continent)

mod3<-glm(data= dat1,
          formula = USMR ~ Year * Continent)

## Task 8 ####

#Compare the three models with respect to their performance
#- Your code should do the comparing
#- Include a comment line explaining which of these three models you think is best

compare_performance(mod1,mod2,mod3)
compare_performance(mod1,mod2,mod3) %>% plot

#It is clearly shown in the plot that model 3 is the best model. This is becauseit has the highest R2 meaning the improvement it gives over guess based on the mean is better than the others, lowest RMSE meaning the line is closer to the points on average, the lowest Sigma, and its AIC, AICc, BIC are at least at small if not smaller than the other models.

## Task 9 ####

#Plot the 3 models’ predictions like so: (10 pts)

dat1$pred_mod1<-predict(mod1,dat1)
dat1$pred_mod2<-predict(mod2,dat1)
dat1$pred_mod3<-predict(mod3,dat1)

task_9_plot<-
  dat1 %>% 
  pivot_longer(starts_with("pred")) %>% 
  ggplot(aes(x=Year, y = USMR, color = factor(Continent)))+
  geom_point(aes(y=value))+
  facet_wrap(~name)+
  labs(x = "Year", y = " Predicted Under-5 Mortality Rate") +
  theme_minimal()+
  ggtitle("Model Predictions")

task_9_plot

## Task 10 ####

#Using your preferred model, predict what the U5MR would be for Ecuador in the year 2020. The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live births. How far off was your model prediction???
#Your code should predict the value using the model and calculate the difference between the model prediction and the real value (13).
#Create any model of your choosing that improves upon this “Ecuadorian measure of model correctness.”

dat1$Year %>% range()

#This prediction cannot be done since 2020 is not within the range of the data set if it was done it would not make sense.

#If we did the prediction anyway (which we should NOT DO) it would look like this

truth<-13

new_data <- data.frame(Year = 2020, Continent = "Americas")

# Predict U5MR for the new data using mod3
prediction <- predict(mod3, newdata = new_data)

# Print the prediction
print(prediction) 

#The prediction is negative which does not make sense in the context of Under 5 Mortality Rates

truth-prediction
#The difference between the true value and the predicted value is 23.58018 

#I cannot make a new model that improves upon a prediction I cannot do but if I wanted to make a new model I would do it like this.
colnames(dat1)
mod3<-glm(data= dat1,
          formula = USMR ~ Year * Continent)

mod4<-glm(data= dat1,
          formula = USMR ~ Year * Region)

compare_performance(mod3, mod4)
compare_performance(mod3, mod4) %>% plot

#I tried doing USMR ~ Year * Region and it is shown in the comparison of model performance Indices that it has a higher R2 lower Sigma and RMSE and it has smaller BIC, AIC, and AICc values. The graph backs this up by showing how it is better than model three in each category.
