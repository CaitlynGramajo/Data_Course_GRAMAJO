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

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(color='darkorchid3')

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_hex()

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_hex()+
  geom_bin_2d()+
  geom_polygon()

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_polygon()+
  geom_hex()+
  geom_bin_2d()


ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_polygon()+
  geom_hex()+
  geom_bin_2d()+
  geom_boxplot()

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_polygon()+
  geom_hex()+
  geom_bin_2d()+
  geom_boxplot()+
  geom_area()


ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_polygon()+
  geom_hex()+
  geom_bin_2d()+
  geom_boxplot()+
  geom_hline(yintercept = 4500, linewidth=69, col="darkorchid4", #I sm going to hell
             linetype='21', alpha=.25)


ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species, alpha =bill_depth_mm))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_polygon()+
  geom_hex()+
  geom_bin_2d()+
  geom_boxplot()+
  geom_hline(yintercept = 4500, linewidth=69, col="darkorchid4", #I sm going to hell
             linetype='21', alpha=.25)+
  geom_point(col="darkorchid3", aes(alpha=bill_depth_mm))+
  theme(axis.title = element_text(face = 'italic', size = 12, angle = 30),
        legend.background = element_rect(fill='deeppink3', color= 'lightpink', linewidth =5))

ggplot(penguins, mapping = aes(x=flipper_length_mm,
                               y = body_mass_g, color=species, alpha =bill_depth_mm))+
  geom_path(aes(group=species))+
  stat_ellipse()+
  geom_point(aes(color=sex))+
  geom_polygon()+
  geom_hex()+
  geom_bin_2d()+
  geom_boxplot()+
  geom_hline(yintercept = 4500, linewidth=69, col="darkorchid4", #I sm going to hell
             linetype='21', alpha=.25)+
  geom_point(col="darkorchid3", aes(alpha=bill_depth_mm))+
  theme(axis.title = element_text(face = 'italic', size = 12, angle = 30),
        legend.background = element_rect(fill='deeppink3', color= 'lightpink', linewidth =5))

