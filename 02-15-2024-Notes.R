#02/15/2024
library(tidyverse)
library(janitor)

df<-read_csv("./Data/Bird_Measurements.csv") #tis gross looking oh nor
# there are multiple pivot longer situations 
#first break it up into three different data frames male, female and un-sexed
#then put them back together

library(skimr)

skim(df) #whitespace tells you if there is weird spacing yay!

#My attempt (it was wrong)
colnames(df)

df<-clean_names(df) # fix gross names
colnames(df)

#the female
df_female<-
  df %>% 
  select(starts_with("f_"))
df_female


path<-
#the male one
df_male<-
  df %>% 
  select(starts_with("m"))
df_male

#the unsexed one
df_unsexed<-
  df %>% 
  select(starts_with("u"))
df_unsexed

df_female %>% 
select(-ends_with("_n")) #drop the _n

#Zhan here to save me yee

keepers<-c("Family", "Species_number", "Species_name", "English_name", "Clutch_size", "Egg_mass", "Mating_System") %>% 
  str_to_lower()

male<-
  df %>%  clean_names() %>% 
  select(keepers, starts_with("m_"), -ends_with("_n")) %>% 
  mutate(sex ="male") %>% 
  
  names(male)<- names(male) %>% str_remove("m_")

female<-
  df %>% clean_names() %>% 
  select(keepers, starts_with("f_"), -ends_with("_n")) %>% 
  mutate(sex ="female")

names(female)<- names(female) %>% str_remove("f_")

unsexed<-
  df %>% clean_names() %>% 
  select(keepers, starts_with("u"), -ends_with("_n")) %>% 
  mutate(sex ="unsexed")

names(unsexed)<- names(unsexed) %>% str_remove("unsexed_")

clean<-
  male %>% 
  full_join(female) %>% 
  full_join(unsexed)

clean
library(readxl)
path<-"C:\\Users\\caitl\\Downloads\\Worst Data Storage Ever.xlsx"
x<-read_xlsx(path, sheet = 1, range ="A1:K10")
x2<-read_xlsx(path, sheet = 1, range ="A1:K10")

#cleannames works on other languages kind of