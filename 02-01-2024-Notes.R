#02/01/2024
#no attach
#what can I do with the space data??? What would be interesting to me???

library(tidyverse)
library(palmerpenguins)

names(penguins)

pengiuns<-penguins

penguins %>% 
ggplot(mapping = aes(x=flipper_length_mm, 
                               y=body_mass_g, 
                               color=species))+
geom_point()+
stat_ellipse()+
  scale_color_manual(values = c("darkorchid4",
                                "deeppink3",
                                "seagreen3"))

#install.packages("leaflet")
library(leaflet)
#eww
penguins %>% 
  ggplot(aes(x=year,
             y= body_mass_g)) +
  geom_boxplot()
#ewwww
penguins %>% 
  ggplot(aes(x=year,
             y= body_mass_g)) +
  geom_point()

penguins %>% 
  ggplot(aes(x=species,
             y= body_mass_g)) +
  geom_boxplot()+
  geom_point()

penguins %>% 
  ggplot(aes(x=species,
             y= body_mass_g)) +
  geom_boxplot()+
  geom_jitter()

penguins %>% 
  ggplot(aes(x=species,
             y= body_mass_g)) +
  geom_boxplot()+
  geom_jitter(height=0,width=0.1, alpha=0.2)
       
penguins %>% 
  ggplot(aes(x=body_mass_g,fill=species))+
  geom_density(alpha=0.25)

penguins %>% 
  ggplot(aes(x=body_mass_g,fill=species))+
  geom_histogram(alpha=0.5)

#don't have data
#have a goal
#plot the data before doing stats

df<-read_delim("./Data/DatasaurusDozen.tsv")

df %>% 
  group_by(dataset) %>% 
  summarise(meanx=mean(x),
            sdx=sd(x),
            minx=min(x),
            maxx=max(x),
            medianx=median(x))

df %>% 
  ggplot(aes(x=x, fill=dataset))+
  geom_density(alpha=0.3)

df %>% 
  ggplot(aes(x=x, y=y))+
  geom_point(alpha=0.3)+
  facet_wrap(~dataset) #need on test

#install.packages("GGally")
library(GGally)
GGally::
  ggpairs(pengiuns)
names(penguins)
#body_mass_g and flipper_lenth
penguins %>% 
  ggplot(mapping=aes(x=bill_depth_mm, y=flipper_length_mm,color=sex))+
  geom_point()+
  scale_color_manual(values = c("darkorchid4",
                                "deeppink3"))

penguins %>% 
  ggplot(mapping=aes(x=bill_depth_mm, y=flipper_length_mm,color=island))+
  geom_point(size=5,alpha=0.5)+
  #stat_ellipse()+
  facet_wrap(~species) +
  scale_color_manual(values = c("darkorchid4",
                                "deeppink3",
                                "seagreen3")) #yay colors
