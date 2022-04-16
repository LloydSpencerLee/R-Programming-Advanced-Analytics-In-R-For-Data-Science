#---------------- S4_42: Import Data into R

getwd()
setwd("./Weather Data")

Chicago <- read.csv("Chicago-F.csv", row.names = 1)
NewYork <- read.csv("NewYork-F.csv", row.names = 1)
Houston <- read.csv("Houston-F.csv", row.names = 1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names = 1)

#These are dataframes:
is.data.frame(Chicago)

Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)

#Check:
is.matrix(Chicago) #True

#Let's put all of these into a list:
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco=SanFrancisco)
Weather

Weather[3]
Weather[[3]]
Weather$Houston


#---------------- S4_43: R programming: What is the Apply family?
#The Apply Family:
    #apply - use ona  matrix: either the rows or the columns
    #tapply - use on a vector to extract subgroups and apply a function to them
    #by - use on data frames. Same concepts as in group by in SQL
    #eapply - use on environment (E)
    #lapply - apply a function to elements o fa list (L)
    #sapply - a version of lapply. Can simplify (S) the result so it's not presented as a list
    #vapply - has pre-specified type of return value(V)
    #replicate - run a function several times. Usually used with generation of random variables
    #mapply - multivariate (M) version of sapply. Arguments can be recycled
    #rapply - recursive (R) version of lapply


#---------------- S4_44: Using apply()
?apply
Chicago
apply(Chicago, 1, mean)
#analyze one city:
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)

#for practice:
apply(Chicago, 2, max) #Doesn't make much sense, but good exercise
apply(Chicago, 2, min) #Doesn't make much sense, but good exercise

#Compare:
apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFrancisco, 1, mean)
#<<< (nearly) deliverably 1, but there is a faster way

#---------------- S4_45: Recreating the apply function with loops (advanced topic)
Chicago
#find the mean of every row:
#1. via loops
output <- NULL #preparing an empty vector
for(i in 1:5){
    output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
output
#2. via apply function
apply(Chicago,1,mean)

#---------------- S4_46: Using lapply()
?lapply
Chicago
t(Chicago)

lapply(Weather,t) #t(Weather$Chicago), #t(Weather$NewYork), #t(Weather$Houston), #t(Weather$SanFrancisco) 

mynewlist <- lapply(Weather,t)

mynewlist
#example 2
Chicago
rbind(Chicago, NewRow=1:12)

lapply(Weather, rbind, NewRow=1:12)

#example 3
?rowMeans

rowMeans(Chicago) #identical to: apply(Chicago, 1, mean)
lapply(Weather, rowMeans)
    #<<< (nearly) deliv 1: even better, but will improve further

#rowMeans
#ColMeans
#RowSums
#colSums

#---------------- S4_47: Combining lapply() with []
Weather
Weather[[1]][1,1] #Weather[[1]][1,1], Weather[[2]][1,1]
Weather$Chicago[1,1] #Weather$Chicago[1,1], Weather$NewYork[1,1]

lapply(Weather,"[",1,1)
Weather
lapply(Weather,"[",1,)
Weather

lapply(Weather,"[",,"Mar")
Weather

#---------------- S4_48: Adding your own functions


lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])
Weather
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
    #<<Deliv2: temp fluctuations. Will improve

#---------------- S4_49: Using sapply()
?sapply
Weather

#AvgHigh_F for July:
lapply(Weather, "[", 1, 7) #List
sapply(Weather, "[", 1, 7) #Vector (could also turn it into a matrix)

#AvgHigh_F for 4th quarter:
lapply(Weather, "[",1,10:12)
sapply(Weather, "[",1,10:12)

#Another example:
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)

round(sapply(Weather, rowMeans), 2) #<< Delive 1. Awesome!
#Another example:
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))

#By the way:
sapply(Weather, rowMeans, simplify=FALSE) #same as lapply

#---------------- S4_50: Nesting apply() functions
Weather
lapply(Weather, rowMeans)
?rowMeans

Chicago
apply(Chicago, 1, max)
#apply accross whole list:
lapply(Weather, apply, 1, max)
lapply(Weather, function(x) apply(x, 1, max))
#tidy up:
sapply(Weather, apply, 1, max) #<< deliv 3
sapply(Weather, function(x) apply(x, 1, max))


sapply(Weather, apply, 1, min) #<< deliv 4
sapply(Weather, function(x) apply(x, 1, min))


#---------------- S4_51: which.max() and which.min() (advanced topic)
#Very advanced tutorial!
#which.max
?which.max

which.max(Chicago[1,])
names(which.max(Chicago[1,]))
#by the sounsd of it,
#we will have: apply = to iterate over rows of the matrix
#and we will have: lapply or sapply - to iterate over components of the list
apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))











