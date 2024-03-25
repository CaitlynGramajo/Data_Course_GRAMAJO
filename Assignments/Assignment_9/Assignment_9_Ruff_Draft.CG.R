## Date, Name, Class, Assignment Number ####

#03/21/2024
#Caitlyn Gramajo
#BIO 3100  Assignment 9

##Library####
library(tidyverse)
library(caret)
library(easystats)
library(modelr)
library(MASS)

##Part 1####
#Using the data set “/Data/GradSchool_Admissions.csv” you will explore and model the predictors of graduate school admission the “admit” column is coded as 1=success and 0=failure (that’s binary, so model appropriately) the other columns are the GRE score, the GPA, and the rank of the undergraduate institution, where I is “top-tier.

data<-read_csv("GradSchool_Admissions.csv")

colnames(data)

data %>% 
  ggplot(aes(x=gpa, y=gre, color = as.factor(admit)))+
  geom_point()

#we can see that there is more rejections to acceptations and that the acceptations are more spread out than the rejections. I wonder if the acceptance points that are lower correlatie to lower rank schools.

ggplot(data, aes(x = gpa, fill = as.factor(admit))) +
  geom_density(alpha = 0.5) +
  labs(x = "GPA", y = "Density", fill = "Admit Status") +
  theme_minimal()

#we can see that the mean GPA or students who were admitted is higher than that of the GPA of students where rejected but the two curves are very similar.

ggplot(data, aes(x = gre, fill = as.factor(admit))) +
  geom_density(alpha = 0.5) +
  labs(x = "GRE", y = "Density", fill = "Admit Status") +
  theme_minimal()

#we can see that the mean gre or students who were admitted is a little higher than that of the gre of students where rejected. The two density curves overlap so much that I am suspicious that gre does not matter so much

ggplot(data, aes(x = as.factor(rank), fill = as.factor(admit))) +
  geom_bar(alpha = 0.5) +
  labs(x = "Rank", y = "Count", fill = "Admit Status") +
  theme_minimal()

#we can see that all but rank 1 schools reject more than the accept I wonder if lower rank schools get more applicants.

#Split data into train and test

id<-createDataPartition(data$admit, p = 0.8, list = F) 
train<-data[id,]
test<-data[-id,]

#making some models

mod1<-glm(data = train, 
          formula = as.logical(admit) ~ gre + gpa + factor(rank),
          family = binomial)

mod2<-glm(data = train, 
          formula = as.logical(admit) ~ gpa + factor(rank),
          family = binomial)

mod3<-glm(data = train, 
          formula = as.logical(admit) ~ gre + factor(rank),
          family = binomial)

mod4<-glm(data = train, 
          formula = as.logical(admit) ~ gpa + gre,
          family = binomial)

mod5<-glm(data = train, 
          formula = as.logical(admit) ~ as.factor(rank),
          family = binomial)

#Comparing the models
compare_performance(mod1,mod2,mod3,mod4,mod5) %>% plot
compare_performance(mod1,mod2,mod3,mod4,mod5)

#No model is the best in categories but I choose model 1 because it has the lowest AIC and AICc dispite being the most complex. All models have the same Sigma but model 1 gets more predictions correct than the other models and has the lowest RMSE of the. It also explains the most this is shown by the the R2

check_model(mod1)

#Looking at the residuals we can see that they are normally distributed very strongly up until 2 but even then they are not too far away. We can see in the influential observations plot that are no observations with high leverage meaning that no one observation is changing anything. We can also see that all of the predictors are within the green zone for colinearity meaning they are not influencing each other too much.

#Using model 1 to predict with the test data
test$pred <- predict(mod1, newdata = test, type = "response")

#Plotting them
test %>% 
  ggplot(aes( x = gpa, y = pred, color = as.factor(rank)))+
  geom_point(alpha = 0.55)+
  geom_smooth()

#How many are correct
test1<-
  test %>% 
  mutate(outcome = case_when(pred >= 0.5 ~ "Accept",
                             pred < 0.5 ~ "Reject")) %>% 
  mutate(correct = case_when(admit == "1" & outcome == "Accept" ~ TRUE,
                             admit != "1" & outcome == "Reject" ~ TRUE,
                             TRUE ~ FALSE))

#How many are correct?
test1 %>% 
  pluck("correct") %>% 
  sum()/nrow(test) 

#0.7125

#Plotting predictions and coloring by whether or not they are correct

test1 %>% 
  ggplot(aes( x = gpa, y = pred, color = as.factor(correct)))+
  geom_point(alpha = 0.55)+
  geom_smooth()

#Holy smokes look at the variability.

report(mod1) #my lord and savior 

##Part 2####
#Document your data explorations, figures, and conclusions in a reproducible R-markdown report. That means I want to see, in your html report, your process of model evaluation and selection.

##Part 3####
#Upload your self-contained R project, including knitted HTML report, to GitHub in your Assignment_9 directory