#02/08/2024

library(ggplot2)
library(tidyverse)

getwd()
data<-read_csv("./Data/wide_income_rent.csv")

n<-length(data)

data2<-as.data.frame(t(data[,2:n]))

names(data)

data2 %>% 
  ggplot(mapping = aes(x="V2"))+
  geom_bar(col="darkorchid3") # it is a box

#ggmagnify 

data<-read_csv("./Data/wide_income_rent.csv")
data3<-t(data) # it is now a matrix with characters inside oof
data4<-data3[-1,]
data4$State<-row.names(data4)


df<-read_csv("./Data/wide_income_rent.csv")
df2<-t(df) %>% as.data.frame
df2<-df2[-1,]
df2$State<-row.names(df2)

df %>% 
  pivot_longer(-variable ,names_to="state", values_to="amount") %>% 
  ggplot( aes(x="state",y="amount", color="variable"))+
  gemo_point(size=3)

df1<-df %>% 
  pivot_longer(-variable ,names_to="state", values_to="amount") %>%
  pivot_wider(names_from=variable, 
              values_from=amount)
df1

#if one variable is across multiple columns use pivot longer
#if multiple variables are in a single column use pivot wider

df %>% 
  pivot_longer(-variable ,names_to="state", values_to="amount") %>%
  pivot_wider(names_from=variable, 
              values_from=amount) %>% 
  ggplot(aes(x=state,y=rent))+
  geom_col()+ #I want it to be purple
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5, size=7))+
  ggtitle("Rent by State")+
  ylab("Rent in USD")+
  xlab("State")

table1
table2

table2 %>% 
  pivot_wider(names_from=type,
              values_from=count)

table3
table3 %>% 
  separate(rate, into = c("cases", "population"))

table4a
table4b

x<-table4a %>% 
  pivot_longer(-country, names_to = "year", 
               values_to="cases")

y<-table4b %>% 
  pivot_longer(-country, names_to = "year", 
               values_to="population")

full_join(x,y)

table5

table5 %>% 
  separate(rate, into = c("cases ","population"), convert = T) %>%
  mutate(year = paste0(century, year) %>% as.numeric()) %>% 
  select(-century)

library(readxl)
dat<-read_xlsx("./Data/messy_bp.xlsx", skip=3) 

bp<-
  dat %>% 
  select(-starts_with("HR")) #no HR

bp1<-
  dat %>% 
  select(starts_with("HR")) #only hr

#Always separate dates into month day year 

bp %>% 
  pivot_longer(starts_with("BP"),
               names_to = "visit",
               values_to = "bp") %>% 
  mutate(visit=case_when(visit=="BP...8"~1,
                         visit=="BP...10"~2,
                         visit=="BP...12"~3))
