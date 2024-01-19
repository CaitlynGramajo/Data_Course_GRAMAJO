
#1/18/2024

#Write a for-loop that prints the results of 1+x for each number
x<-c(1,2,3,4,5)
for (i in x){
  print(x=i+1)
}

x+1

x^3

1:5 # generates all the numbers between 1 to 5

seq(1,100,by=2) # generate al the numbers from 1 to 100, by control the difference between each number

class(x) #numeric

length(x) #5

length(length(x)) #is 5 because the length of x is a numeric thing

class(class(x)) #if in "" its class is character

#everything in a vector must have the same class
c(1,"a") # turns 1 into a character

# A vector #
# Has a class (numeric, character, integer, data.frame)
# Has one dimension
# all things in vector must have the same class
# length can be = 0 
length(c()) # gives 0


#QR code package
#url<-"" insert link
#qr<-qrcode::qr_code(url)
#plot(qr)

a<-1:10
b<-2:11
c<-letters

#get first ten letters
head(letters, n =10)
#or
c<-letters[1:10]

c<-letters[c(1,3,5)]# 1 3 and 5 letter must have c() or it gives dimesion error

a<-1:10
b<-2:11
c<-letters[1:10]
#put the things together preserve numbers
cbind(a,b,c) #no
data.frame(a,b,c) #yes
z<-data.frame(a,b,c) #only works if the lengths are the same

class(z)
length(z) # gives number of columns for data frames
dim(z) #find dimensions of thing

#a data frame is a list of vectors

rep(TRUE,10)

d<-rep(TRUE, 10)
zz<-data.frame(a,b,c,d)
class(zz) #gives logical
dim(zz)
length(zz)

#logic
1>0
0>=0
3<1
1==1 #is thing = to thing
1!=1 # is thing not equal to thing

5>a

#find rows where a<5
a[5>a] 
z[5>a,]#this works

#data frames have 2 dimensions [row,column]

#pull out all rows where c = the letter b
z[c=="b",]

iris
dim(iris)
length(iris)

#Give all the rows where sepal length > 5
iris[iris$Sepal.Length>5,]

#how many iris had sepal > 5
dim(iris[iris$Sepal.Length>5,]) # 118
dim(iris[iris$Sepal.Length>5,])[1] #give me dim but only the first 1
nrow(iris[iris$Sepal.Length>5,]) #better

big_iris<-iris[iris$Sepal.Length>5,] #made a subset with a condition yay

#add new column to big iris that is sepal area = length*wide
area<-big_iris$Sepal.Length*big_iris$Petal.Width
cbind(big_iris,area)

#or
big_iris$Sepal.Area<-big_iris$Sepal.Length*big_iris$Petal.Width

big_iris$Sepal.Area<-"AHHHHHHH" #or nor this is no bueno so rerun
big_iris$Sepal.Area<-big_iris$Sepal.Length*big_iris$Petal.Width

#show just setosa from big iris
big_setosa<-big_iris[big_iris$Species=="setosa",]
mean(big_setosa$Sepal.Area)
big_setosa

plot(big_setosa$Sepal.Length,big_setosa$Sepal.Width)

#mean, sd, min, max, summary, cumsum, cumprod

mean(big_setosa$Sepal.Area)
min(big_setosa$Sepal.Area)
max(big_setosa$Sepal.Area)
sd(big_setosa$Sepal.Area)
summary(big_setosa$Sepal.Area)
cumsum(big_setosa$Sepal.Area)
cumprod(big_setosa$Sepal.Area)
