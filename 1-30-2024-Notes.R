#01/30/2024

library(tidyverse)

unique(stringr::str_to_title(iris$Species))
#with %>% 
iris$Species %>% 
  stringr::str_to_title() %>% 
  unique()

#or

iris %>% 
  pluck("Species") %>% 
  stringr::str_to_title() %>% 
  unique()

max(round(iris$Sepal.Length),0)



median(round(seq(1,100,0.01),1))
#with %>% 
seq(1,100,0.01) %>% 
  round(1) %>% 
  median

mean(abs(rnorm(100,0,5)))
#with %>% 
rnorm(100,0,5) %>% 
  abs ()%>% 
  mean()

x<-penguins
names(penguins)
ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, fill=species))+
  geom_col()

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, fill=species))+
  geom_col(position = 'dodge')

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_line(aes(group=species))