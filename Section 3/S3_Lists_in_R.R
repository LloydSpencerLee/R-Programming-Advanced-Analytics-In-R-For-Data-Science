#---------------- S3_31: Import Data Into R

#Lists in R
#Deliverable - a list with following components:
#Character: Machine name
#Vector: (min, mean, max) Utilization for the month (excluding unknown hours)
#Logical: Has utilization ever fallen below 90# ? TRUE/FALSE
#Vector: All hours where utilization is unknown (NA's)
#Dataframe: For this machine
#Plot: For all machines


getwd()

util <- read.csv("Machine Utilization.csv")

head(util, 12)
str(util)
summary(util)

#Derive utilization column
util$Utilization = 1 - util$Percent.Idle
head(util, 12)
tail(util)


#---------------- S3_32: Handling Data-Times in R
#date appears to be DD/MM/YYYY
#Handling Date-Times in R
?POSIXct

util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util)
summary(util) #PosixTime is recognized as a number
#TIP: how to rearrange columns in a df:
util$Timestamp <- NULL
head(util, 12)

util <- util[c(4,1,2,3)]
head(util, 12)


#---------------- S3_33: R Programming: What is a List?
summary(util)

RL1 <- util[util$Machine=="RL1",]
summary(RL1) # still shows other Machine factors (RL2, SR1, etc)

RL1$Machine <- factor(RL1$Machine) #now it is removed and only RL1 factor left
summary(RL1)
#Construct list:
#Character: Machine name
#Vector: (min, mean, max) Utilization for the month (excluding unknown hours)
#Logical: Has utilization ever fallen below 90# ? TRUE/FALSE

util_stats_rl1 <- c(min(RL1$Utilization, na.rm=T), 
                    mean(RL1$Utilization, na.rm=T), 
                    max(RL1$Utilization, na.rm=T))
util_stats_rl1

length(which(RL1$Utilization < 0.90)) > 0

util_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag

list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)

list_rl1



#---------------- S3_34: Naming components of a list
list_rl1
names(list_rl1)

names(list_rl1) <- c("Machine", "Stats", "LowThreshold")
list_rl1

#Another way. Like with dataframes:
rm(list_rl1)
list_rl1
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
list_rl1


#---------------- S3_35: Extracting components lists: [] vs [[]] vs $
#three ways:
#[] - wil lalways return a list
#[[]] - will return the actual object
#$ - same as [[]] but prettier
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine


list_rl1[2]
typeof(list_rl1[2]) #a list

list_rl1[[2]]
typeof(list_rl1[[2]]) #a double

list_rl1$Stats 
typeof(list_rl1$Stats) #a double

#how would you access the 3rd element of the vector (max utilization)?
list_rl1[[2]][3]
list_rl1$Stats[3]


#---------------- S3_36: Adding and deleting components
list_rl1
list_rl1[4] <- "New Information"
list_rl1

#Another way to add a component - via the $
#We will add:
#Vector: All hours where utilization is unknown (NA's)
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]
list_rl1

#Remove a component. Use the NULL method:
list_rl1[4] <- NULL
list_rl1
#!!Notice: numeration has shifted
list_rl1[4]

#Add another component:
#Dataframe: for this machine
list_rl1$Data <- RL1

list_rl1

summary(list_rl1)
str(list_rl1)


#---------------- S3_37: Subsetting a list
list_rl1

list_rl1$UnknownHours[1]

list_rl1
list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine","Stats")]
sublist_rl1
sublist_rl1[[2]][2]

#Double Square Brackets Are NOT for subsetting:
list_rl1[[1:3]] # This will give an ERROR

#---------------- S3_38: Creating a Timeseries Plot
library(ggplot2)
p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime, y=Utilization,
                  colour=Machine), size=1.2) +
    facet_grid(Machine~.) +
    geom_hline(yintercept = 0.90,
               colour="Gray", size =1.2,
               linetype=3)
myplot <- p + geom_line(aes(x=PosixTime, y=Utilization,
                            colour=Machine), size=1.2) +
    facet_grid(Machine~.) +
    geom_hline(yintercept = 0.90,
               colour="Gray", size =1.2,
               linetype=3)

list_rl1$Plot <- myplot

list_rl1
summary(list_rl1)
str(list_rl1)













