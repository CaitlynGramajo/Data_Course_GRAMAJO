#02/13/2024
library(tidyverse)
library(readxl)

dat<-read_xlsx("./Data/messy_bp.xlsx", skip=3) 

bp<-
  dat %>% 
  select(-starts_with("HR")) #no HR

bp1<-
  dat %>% 
  select(starts_with("HR")) #only hr

#Always separate dates into month day year 
bp<-
bp %>% 
  pivot_longer(starts_with("BP"),
               names_to = "visit",
               values_to = "bp") %>% 
  mutate(visit=case_when(visit=="BP...8"~1,
                         visit=="BP...10"~2,
                         visit=="BP...12"~3)) %>% 
  separate(bp, into=c("systolic", "diastolic")) # blood pressure has two things in it so we needed to separate them

hr <-   
  dat %>%   
  select(-starts_with("BP")) 
hr<- 
  hr%>%   
  pivot_longer(starts_with("HR"),
               names_to = "visit", 
               values_to = "hr")%>%   
  mutate(visit=case_when(visit == "HR...9"~1,
                         visit == "HR...11"~2,                          
                         visit == "HR...13"~3))

df<-full_join(bp,hr)

library("janitor")
#janitor::clean_names() #clean up column names to be sane and not evil yee
df<-df %>% 
  clean_names()

df$race %>% unique()

df<-
  df %>% 
  mutate(race = case_when (race == "Caucasian"| race == "WHITE"~"White",
                           TRUE ~ race)) %>% 
  mutate(birthdate = paste(year_birth,month_of_birth,day_birth, sep="-") %>% as.POSIXct()) %>% 
  mutate(systolic = systolic %>% as.numeric(),
         diastolic = diastolic %>% as.numeric()) %>% 
  select(-pat_id, month_of_birth, year_birth, day_birth) %>% 
  mutate(hispanic = case_when(hispanic == "Hispanic" ~ TRUE,
                                TRUE ~ FALSE)) %>% 
  # pivot_longer(cols= c("systolic","diastolic"), names_to = "bp_type", values_to = "bp")
  #run this for the last two plots to work


#Use true so it leaves everything else alone Dr Zahn does not approve of this logic but oh well

# The universal format for Dates is YYYY-MM-DD HH:mm:ss
# m is minutes, s is seconds

#%>% pluck("sex") %>% unique() check one column and see how many things there are

##Plot Time
df %>% 
  ggplot(aes(x = visit, y = hr, color = sex))+
  geom_path()+
  facet_wrap(~race)

df %>% 
  ggplot(aes(x = visit, y = systolic, color = sex))+
  geom_path()+
  facet_wrap(~race)
  
df %>% 
  ggplot(aes(x = visit, y = diastolic, color = sex))+
  geom_path()+
  facet_wrap(~race)

df %>% 
  ggplot(aes(x = visit, color = sex))+
  geom_path(aes(y=systolic))+
  geom_path(aes(y=diastolic))+
  facet_wrap(~race)

df %>% 
  ggplot(aes(x=visit, y = bp, color=bp_type))+
  geom_path()+
  facet_wrap(~race)

df %>% 
  ggplot(aes(x=visit, y = bp, color=bp_type))+
  geom_path()+
  facet_wrap(~hispanic)