library(tidyverse)
library(readxl)
library(janitor)
path<-"C:\\Users\\caitl\\Downloads\\CW_CameraData_2019.xlsx"

sites<-c("South Oak Spring Site 2")

sites[1] %>% str_replace_all(" ", "_")

trap_days<-read_xlsx(path,sheet=sites[1], range="B17:I17", col_names = F)

South_Ouks_Spring_2<-
  read_xlsx(path,sheet=sites[1], range="A2:I12") %>%
  clean_names() %>% 
  pivot_longer(-species,
               names_to = "month",
               values_to = "obs_count") %>% 
  mutate(site=sites[1],
         month=str_to_sentence(month),
         species=str_to_sentence((species)))
  
data.frame(month=South_Ouks_Spring_2$month %>% unique,
           trap_days=trap_days[1,] %>% as.numeric())

South_Ouks_Spring_2<-
  South_Ouks_Spring_2 %>% 
  full_join(
    data.frame(month=South_Ouks_Spring_2$month %>% unique,
            trap_days=trap_days[1,] %>% as.numeric())
  )
read_trap_data<-
  function(path,sheet,range1,range2)
{
  trap_days<-read_xlsx(path,sheet=sheet, range=range1, col_names = F)
  
  X<-
    read_xlsx(path,sheet=sheet, range=range2) %>%
    clean_names() %>% 
    mutate(across(-species,as.numeric)) %>% 
    pivot_longer(-species,
                 names_to = "month",
                 values_to = "obs_count") %>% 
    mutate(site=sheet,
           month=str_to_sentence(month),
           species=str_to_sentence(species) %>% 
             mutate(month=case_when(str_detect(month,"[J,j]an")~"January",
                                    str_detect(month,"[F,f]eb")~"Febuary",
                                    str_detect(month,"[M,m]ar")~"March",
                                    str_detect(month,"[A,a]pr")~"April",
                                    str_detect(month,"[M,m]ay")~"May",
                                    str_detect(month,"[J,j]un")~"June",
                                    str_detect(month,"[J,j],ul")~"July",
                                    str_detect(month,"[A,a]ug")~"August",
                                    str_detect(month,"[O,o]ct")~"October",
                                    str_detect(month,"[N,n]ov")~"November",
                                    str_detect(month,"[D,d]ec")~"December")
                    ))
  
  data.frame(month=X$month %>% unique,
             trap_days=trap_days[1,] %>% as.numeric())
  
  X<-
   X %>% 
    full_join(
      data.frame(month=X$month %>% unique,
                 trap_days=trap_days[1,] %>% as.numeric())
    )
  return(X)
  }

sites<-c("South Oaks Spring Site 2",
         )

South_Ouks_Spring_2<-
read_trap_data(path=path,
               sheet=sites[1], 
               range1 = "B17:I17", 
               range2="A2:I12")

North_Oaks_Spring_Site_1<-
  read_trap_data(path=path,
                 sheet=sites[2], 
                 range1 = "B15:I15", 
                 range2="A2:I12")

Oak_Springs<-
  read_trap_data(path=path,
                 sites=sheet[3],
                 range1="B18:I18",
                  range2="A2:I12")