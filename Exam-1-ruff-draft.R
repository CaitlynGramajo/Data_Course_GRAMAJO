#02/01/2024
#Caitlyn Gramajo
#BIO 3100 Exam 1

library(tidyverse)

# Task 1 ####
#Read the cleaned_covid_data.csv file into an R data frame. (20 pts)

data<-read.csv("C:\\Users\\caitl\\DataClass\\Data_Course_GRAMAJO\\EXAMS\\Exam_1\\cleaned_covid_data.csv")

# Task 2 ####
#Subset the data set to just show states that begin with "A" and save this as an object called A_states. (20 pts)

# Use the *tidyverse* suite of packages
# Selecting rows where the state starts with "A" is tricky (you can use the grepl() function or just a vector of those states if you prefer)

A_states <- data[grepl("^A", data$Province_State), ]
A_states

# Task 3 ####
#Create a plot _of that subset_ showing Deaths over time, with a separate facet for each state. (20 pts)**

#Create a scatterplot
#Add loess curves WITHOUT standard error shading
#Keep scales "free" in each facet

A_states %>% 
ggplot(mapping=aes(x =Last_Update, y = Deaths)) +
  geom_point(col="darkorchid4") +
  geom_smooth(method = "loess", se = FALSE) + 
  facet_wrap(~Province_State, scales = "free") + 
  ggtitle("Deaths over time for States that start with the letter A")+
  labs(x = "Time", y = "Deaths") + 
  theme_minimal() 

# Task 4 #### 
#(Back to the full dataset)
#Find the "peak" of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)**

#Im looking for a new data frame with 2 columns:

#"Province_State"
#"Maximum_Fatality_Ratio"
#Arrange the new data frame in descending order by Maximum_Fatality_Ratio

#This might take a few steps. Be careful about how you deal with missing values!

state_max_fatality_rate <- data %>%
  group_by(Province_State) %>%
  summarize(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE))

state_max_fatality_rate <- state_max_fatality_rate %>%
  arrange(desc(Maximum_Fatality_Ratio))

print(state_max_fatality_rate)

# Task 5 ####
#Use that new data frame from task IV to create another plot. (20 pts)

#X-axis is Province_State
#Y-axis is Maximum_Fatality_Ratio
#bar plot
#x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
#X-axis labels turned to 90 deg to be readable

#Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.

state_max_fatality_rate$Province_State <- factor(state_max_fatality_rate$Province_State, levels = state_max_fatality_rate$Province_State)

state_max_fatality_rate %>% 
ggplot(mapping= aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = "identity", col="darkorchid4",fill="darkorchid3") +
  labs(x = "Province_State", y = "Maximum_Fatality_Ratio") +
  ggtitle("Maximum Fatality Ratio by State")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# Task 6 #### (BONUS 10 pts)
#Using the FULL data set, plot cumulative deaths for the entire US over time**

#You'll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.