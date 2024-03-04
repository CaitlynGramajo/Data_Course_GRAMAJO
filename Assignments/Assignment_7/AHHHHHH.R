utah %>% 
  pivot_longer(col = selected_columns,
               names_to = "Religion",
               values_to = "Proportion")
dat1<-
  utah %>% 
  filter( "Buddhism.Mahayana" >0) %>% 
  pivot_longer(col = selected_columns,
               names_to =  "Religion",
               values_to = "Proportion") %>% 
  arrange(desc(Pop_2010))

utah %>%
  pivot_longer(cols = selected_columns,
               names_to = "Religion",
               values_to = "Proportion") %>%
  mutate(buddhist = (Religion == "Buddhism.Mahayana")) %>%
  filter(buddhist & Proportion > 0) %>%
  arrange(desc(Pop_2010)) %>%
  filter(Proportion > 0)