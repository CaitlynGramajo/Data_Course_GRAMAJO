# 01/25/2024

# Tidyverse ####
library(tidyverse) 

# Penguins ####
#install.packages("palmerpenguins")
library(palmerpenguins)

penguins %>% names

x<-penguins %>% #pipe is your friend
  filter(bill_length_mm>40 & sex =="female") 
mean(x$body_mass_g) # 4192.929

## Find mean mass of female penguins bills longer than 40 ####
penguins %>% #pipeline yay
  filter(bill_length_mm>40 & sex =="female") %>% 
  pluck("body_mass_g") %>% #pluck lets you pull out things by name makes it numeric. Pluck must be in quoted.
  mean

## Do the same but for each species of penguin ####
penguins %>% #pipeline yay
  filter(bill_length_mm>40 & sex =="female") %>%
  group_by(species) %>% #group_by is often followed bu summarize
  #summarise(new_column_name = function(column in orginal data))
  summarise(mean_body_mass = mean(body_mass_g),
            min_body_mass = min(body_mass_g),
            max_body_mass = max(body_mass_g),
            sd_body_mass = sd(body_mass_g),
            Number_of_penguins = n()) %>%  # number of rows that meet grouping requirements 
  arrange(desc(mean_body_mass))  # %>% #arrange the things by some requirement
  write_csv("./Data/penguin_summary.csv") #make a csv yeee

#this is a pivot table
#write_csv is from tidyverse

## Do the same but for each species of penguin and island ####
penguins %>% #pipeline yay
  filter(bill_length_mm>40 & sex =="female") %>%
  group_by(species,island) %>% #group_by is often followed bu summarize
  #summarise(new_column_name = function(column in orginal data))
  summarise(mean_body_mass = mean(body_mass_g),
            min_body_mass = min(body_mass_g),
            max_body_mass = max(body_mass_g),
            sd_body_mass = sd(body_mass_g),
            Number_of_penguins = n()) %>%  # number of rows that meet grouping requirements 
  arrange(desc(mean_body_mass)) # %>% #arrange the things by some requirement
  write_csv("./Data/penguin_summary_island.csv") #make a csv yeee

  ### find fat penguins ####
  
  penguins %>% 
    filter(body_mass_g>5000)
  
  ###count number of male and female #### 
  
  penguins %>% 
    filter(body_mass_g>5000) %>% 
    group_by(sex) %>% 
    summarise(Number_of_penguins = n())
  
  ###return the max body mass for males and females ####
  penguins %>% 
    filter(body_mass_g>5000) %>% 
    group_by(sex) %>% 
    summarise(Number_of_penguins = n(),
              max_fatty_wattly_things = max(body_mass_g))
  
  ###bonus: add colume to penguins that says whether they be chonk####
  penguins %>% 
    filter(body_mass_g>5000) %>% 
    group_by(sex) %>% 
    summarise(Number_of_penguins = n(),
              max_fatty_wattly_things = max(body_mass_g))

penguins %>% 
  mutate(chock_birds = body_mass_g>5000)

#but what if I want the column to say chonk or not chonk

penguins %>% 
  mutate(chock_birds = case_when(body_mass_g>5000~"chonk", 
                                 body_mass_g <=5000 ~ "not chonk"))

# ggplot yay####
x<-penguins %>% 
  mutate(fat_stat = case_when(body_mass_g>5000~"fatty", 
                                 body_mass_g <=5000 ~ "not fatty"))
#plotting time
x %>% 
  filter(!is.na(sex)) %>% 
  ggplot(mapping = aes(x=body_mass_g,
                           y=bill_length_mm,
                           col = fat_stat,
                          shape=fat_stat)) +
  geom_point()+
  geom_smooth()+
  scale_color_manual(values=c("darkorchid3", "deeppink3")) +
  theme_dark()+
  theme(axis.text=element_text(angle=180,face='italic')) 
  #scale_color_viridis_d(option = 'plasma', end=0.8) #colorblind friendly

# ggmap ####



             

  