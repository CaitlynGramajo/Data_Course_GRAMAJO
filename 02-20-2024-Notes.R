#02-20-2024

library(tidyverse)
library(readxl)

#colorblindr package on github


dat<-read_xlsx("./Data/messy_bp.xlsx", skip=3)

bp<-
  dat %>% 
  select(-starts_with("HR"))

names(bp)

n.visits<-bp %>% 
  select(starts_with("BP")) %>% 
  length()

names(bp)[which(grepl("^BP",names(bp)))]<-paste0("visit",1:n.visits)

bp<-
  bp %>% 
  pivot_longer(starts_with("visit"),
               names_to = "visit",
               values_to = "bp",
               names_prefix = "visit",
               names_transform = as.numeric) %>% 
  separate(bp, into=c("systolic", "diastolic")) 

hr <-   
  dat %>%   
  select(-starts_with("BP")) 

n.visits<-hr %>% 
  select(starts_with("HR")) %>% 
  length()

names(hr)[which(grepl("^HR",names(hr)))]<-paste0("visit",1:n.visits)

hr<- 
  hr%>%   
  pivot_longer(starts_with("visit"),
               names_to = "visit", 
               values_to = "hr",
               names_prefix = "visit",
               names_transform = as.numeric)


df<-full_join(bp,hr)

df


paste0("visit",1:n.visits) # paste visit1 visist2 visist3

which(grepl("^BP",names(bp))) #find the column numbers whose names start with BP

names(bp)[which(grepl("^BP",names(bp)))]<-paste0("visit",1:n.visits)
