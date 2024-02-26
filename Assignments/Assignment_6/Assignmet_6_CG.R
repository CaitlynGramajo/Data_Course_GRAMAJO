##Header with summary information####
##02/26/2023
##Caitlyn Gramajo
##BIO 3100
##Assignment 6

## Libraries ####
library(tidyverse)
library(janitor)
library(GGally)
library(leaflet)
library(gganimate)

## Task 1 ####
#Cleans this data into tidy (long) form.

#I am assuming we are starting in the Assignment_6 directory

getwd()
#it gives me "C:/Users/caitl/DataClass/Data_Course_GRAMAJO/Assignments/Assignment_6" so I need to go back 3 levels

file_path <- "../../Data/BioLog_Plate_Data.csv"

dat<-read_csv(file_path)

#what am I doing?

#dat1 is the clean rectangular data (or it should be)

colnames(dat)

dat1<-
  dat %>% 
  pivot_longer(starts_with("HR"),
               names_to = "Hour",
               values_to = "absourbence_values") %>% 
  mutate(Hour=case_when(Hour == "Hr_24"~24,
                        Hour == "Hr_48"~48,
                        Hour == "Hr_144"~144)) %>% 
  mutate(Hour = Hour %>% as.numeric(),
         absourbence_values = absourbence_values %>% as.numeric())


#Creates a new column specifying whether a sample is from soil or water.

#dat2 is the data with the new column specifying whether the sample came from soil or water.

dat2<-
  dat1 %>% 
  mutate(Type=case_when(`Sample ID`%in% c("Clear_Creek", "Waste_Water")~"Water",
                        `Sample ID`%in% c("Soil_1","Soil_2")~"Soil"))

## Task 3 ####
#Generates a plot that matches this one (note just plotting dilution == 0.1):

dat2 %>% 
  filter(Dilution==0.1) %>% 
  ggplot(aes(x = Hour, y = absourbence_values, color = Type))+
  geom_smooth(method = "loess", se = FALSE)+
  facet_wrap(~Substrate)+ #why the titles cut off???
  labs(x = "Time")+
  ggtitle("Just Dilution = 0.1")
scale_y_continuous(name = "Absorbance Values", limits = c(0, 2), breaks = seq(0, 2, by = 0.5)) 

## Task 4 ####
#Generates an animated plot that matches this one (absorbance values are mean of all 3 replicates for each group): This plot is just showing values for the substrate “Itaconic Acid”.

D1<-
  dat2 %>% 
  filter(Dilution == 0.1, Substrate== "Itaconic Acid") %>% 
  group_by(`Sample ID`, Hour) %>% 
  summarise(mean_Sample=mean(absourbence_values)) %>% 
  mutate(Dilution = 0.1)

D2<-
  dat2 %>% 
  filter(Dilution == 0.01,Substrate=="Itaconic Acid") %>% 
  group_by(`Sample ID`, Hour) %>% 
  summarise(mean_Sample=mean(absourbence_values)) %>% 
  mutate(Dilution = 0.01)

D3<-
  dat2 %>% 
  filter(Dilution == 0.001, Substrate=="Itaconic Acid") %>% 
  group_by(`Sample ID`, Hour) %>% 
  summarise(mean_Sample=mean(absourbence_values)) %>% 
  mutate(Dilution = 0.001)

mm<-full_join(D1,D2)
dat3<-full_join(mm,D3)

Task_4_PLot<-
  dat3 %>% 
  ggplot(aes(x=Hour, y=mean_Sample, color=`Sample ID`))+
  geom_line()+
  facet_wrap(~Dilution)+
  labs(x="Time", y = "Mean Absourbence Values")

times_vector <- rep(30, nrow(dat3)) 

#for the moving part
Task_4_PLot+
  # transition_states(states = as.factor(Hour))
  transition_reveal(Hour)  
