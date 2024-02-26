#02/06/2024

#Make a ugly plot with my beautiful skating data so I can use it for something

data<-read.csv("C:\\Users\\caitl\\OneDrive\\Documents\\skating data\\Skating Data\\World-Figure-skating-2023-combined-freeskate.csv")

library(tidyverse)
library(GGally)
#xkcd

#install.packages("ggimage")
#install.packages("gganimate")
#install.packages("patchwork")
#install.packages("gapminder")

library(tidyverse)
library(GGally)
library(ggimage)
library(gganimate)
library(patchwork) # stick plots together yay
library(gapminder)

#using gapminder
glimpse(gapminder)

ha<-gapminder %>% 
  ggplot(mapping = aes( x= lifeExp, y = pop, color=continent))+
  geom_point()+
  stat_ellipse()+
  scale_color_manual(values = c("darkorchid4",
                                "deeppink3",
                                "seagreen3",
                                "steelblue3",
                                "orange2")) 
cursed_ha<-
ha +
  theme_dark()

ha+ cursed_ha
ha*cursed_ha
ha/cursed_ha
ha-cursed_ha

(ha+ cursed_ha)/cursed_ha + plot_annotation("hahaha")+
  plot_annotation(plot_layout(guides='collect'))

gapminder$year %>% range
my_contries<-c("Venezuela","Rwanda", "Nepal", "Iraq", "United States")


p3<-gapminder %>% 
  ggplot(mapping = aes( x= gdpPercap, y = lifeExp, color=continent))+
  geom_point(aes(size=pop))+
  scale_color_manual(values = c("darkorchid4",
                                "deeppink3",
                                "seagreen3",
                                "steelblue3",
                                "orange2")) 
p3+
  transition_time(time=year)+
  labs(title='Year:{frame_time}')

my_contries<-c("Venezuela","Rwanda", "Nepal", "Iraq", "United States")


df<-
  gapminder %>% 
  mutate(mycountries=case_when(country %in% my_contries~country))

p3<-df %>% 
  ggplot(mapping = aes( x= gdpPercap, y = lifeExp, color=continent))+
  geom_point(aes(size=pop))+
  geom_text(aes(label=mycountries))+
  scale_color_manual(values = c("darkorchid4",
                                "deeppink3",
                                "seagreen3",
                                "steelblue3",
                                "orange2")) 
p3+
  transition_time(time=year)+
  labs(title='Year:{frame_time}')

#anim_save("./Notes/gapminder_animation.gif") always.gif
#ggsave("./Notes/plot_example.png", width = a, height= b, dpi=c) for not animated things dimensions are in inches, dpi is resolution 300 is the minimum for printing,

data<-read.csv("C:\\Users\\caitl\\OneDrive\\Documents\\skating data\\Skating Data\\World-Figure-skating-2023-combined-freeskate.csv")

names(data)
data %>% 
  ggplot(mapping = aes(x=Rank, y=Total.Score), color=Country)+
  geom_point()
  
