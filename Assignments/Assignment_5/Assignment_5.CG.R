
library(tidyverse)
library(gganimate)
library(ggplot2)
library(ggimage)
library(magick)
library(extrafont)


url<-"https://media1.tenor.com/m/057tLu4ypTAAAAAC/elmo-burning-background.gif"
gif<-"https://media1.tenor.com/m/057tLu4ypTAAAAAC/elmo-burning-background.gif"

data<-read.csv("C:\\Users\\caitl\\OneDrive\\Documents\\skating data\\Skating Data\\World-Figure-skating-2023-combined-freeskate.csv", header = T)


names(data)


cursed2<-data %>% 
  ggplot(mapping=aes(x=Name, y=Total.Score))+
  geom_point( pch = 8, color="deeppink3", size=9)+
  #geom_bgimage(url)+
  #xlim(0, 1000) +
  ylim(69, 100)+
  xlab("不管你叫什麼名字")+ #Chinese for queen Ganlin
  ylab("цифры, да")+ #Russian for queen lindsey
  ggtitle("μαζεύομαι")+ #Greek because it traumatized me
  theme(plot.title = element_text(
    angle = 108,
    hjust = 1, 
    vjust = 0.45, 
    size = 20,
    color = "darkorchid3",
    face = "bold"),
    axis.text.x=element_text(
      angle = -45,
      hjust = 1, 
      vjust = 0.5, 
      size = 3, 
      color = "deeppink3"),
    axis.text.y = element_text(
      color="darkgoldenrod3",
      angle=50
    ))
    

cursed2

la<-cursed2+coord_flip()
la
  
  hehe<-ggbackground(la, url)

hehe+coord_flip()

data %>% 
  ggplot(mapping = aes(x = Total.Score))+
  geom_area()

ggbackground(cursed, url) # for adding elmo

cursed<-data %>% 
  ggplot(mapping=aes(x=Technical.Score, y=Total.Score))+
  geom_point()

ggbackground(cursed2, url)

cursed3<-data %>% 
  ggplot(mapping=aes(x=Name, y=Total.Score, image = sample("https://static.boredpanda.com/blog/wp-content/uploads/2018/02/funny-olympic-figure-skating-faces-3-5a81456ec6309__700.jpg"))+geom_image(aes(image=image)))

ggplot(cursed3, aes(x, y)) + geom_image(aes(image=image), size=.05)

set.seed(2017-02-21)
d <- data.frame(x = rnorm(10),
                y = rnorm(10),
                image = sample("https://static.boredpanda.com/blog/wp-content/uploads/2018/02/funny-olympic-figure-skating-faces-3-5a81456ec6309__700.jpg")
)
# plot2
ggplot(d, aes(x, y)) + geom_image(aes(image=image), size=.05)


#I want elmo to move

#gif
#https://media.tenor.com/NOwYjIULWi4AAAAM/nathan-chen-faceplanting.gif
#https://media1.tenor.com/m/057tLu4ypTAAAAAC/elmo-burning-background.gif

#images
#https://www.reddit.com/media?url=https%3A%2F%2Fpreview.redd.it%2Fthe-non-looping-elmo-fire-meme-has-bothered-me-for-ye-a-rs-v0-yrw5o4098j7a1.gif%3Fformat%3Dpng8%26s%3D677db041e6dc29de555fa7aea7bc47fa28a177f4

#sources 
#https://datacornering.com/how-to-add-gif-animation-to-plot-in-r/
#https://stackoverflow.com/questions/51255832/how-to-add-an-image-on-ggplot-background-not-the-panel

d <- data.frame(data,
                image = sample("https://static.boredpanda.com/blog/wp-content/uploads/2018/02/funny-olympic-figure-skating-faces-3-5a81456ec6309__700.jpg")
)

cursed2<-d %>% 
  ggplot(mapping=aes(x=Name, y=Total.Score))+
  geom_image(aes(image=image), size=0.5)+
  #geom_bgimage(url)+
  #xlim(0, 1000) +
  ylim(69, 100)+
  xlab("不管你叫什麼名字")+ #Chinese for queen Ganlin
  ylab("цифры, да")+ #Russian for queen lindsey
  ggtitle("μαζεύομαι")+ #Greek because it traumatized me
  theme(plot.title = element_text(
    angle = 108,
    hjust = 1, 
    vjust = 0.45, 
    size = 20,
    color = "darkorchid3",
    face = "bold"),
    axis.text.x=element_text(
      angle = -45,
      hjust = 1, 
      vjust = 0.5, 
      size = 3, 
      color = "deeppink3"),
    axis.text.y = element_text(
      color="darkgoldenrod3",
      angle=50
    ))

cursed2

la<-cursed2+coord_flip()
la

hehe<-ggbackground(la, url)

master.piece<-hehe+coord_flip()

#ggsave("my.cursed.master.piece.jpg", plot = master.piece, device = "jpg", width = 6, height = 4, units = "in")
