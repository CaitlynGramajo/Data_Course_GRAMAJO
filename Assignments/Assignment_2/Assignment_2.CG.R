# BIO 3100
# Assignment 2
# 01/16/2024
# Caitlyn Gramajo

# Task 4 
# Find the cvs files and save as an object csv_files
csv_files<-list.files(path ="Data",pattern=".csv", recursive=T,full.names = TRUE)

# Task 5
# Find how many files match that description using the length() function
length(csv_files)

# Task 6
# Open the wingspan_vs_mass.csv and store the contents as an R objects named "df"
list.files(pattern="wingspan_vs_mass.csv", recursive = T) 
df<-read.csv(list.files(pattern="wingspan_vs_mass.csv", recursive = T))

#Task 7: Inspect the first 5 lines using the first head function
head(df, 5)

# Task 8
# Find any files (recursively) in the Data/ directory that begin with the letter “b” (lowercase)
bfiles<-list.files(path="Data", pattern = "^b", recursive = TRUE, full.names = TRUE)

# Task 9
# Write a command that displays the first line of each of those “b” files (this is tricky… use a for-loop)
readLines(bfiles[1], n = 1)

#for loop
for(i in bfiles){
  print(readLines(i[1], n = 1))
}

# Task 10
# Do the same thing for all files that end in “.csv” 
for(i in csv_files){
  print(readLines(i, n = 1))
}