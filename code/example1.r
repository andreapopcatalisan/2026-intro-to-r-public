

#================================== CLASS 1 ====================================

1+1

1+
  1

1

#===================#===================#===================#===================

5 + 1
x <- 5 # Assigning the value
x + 1
x
x <- x + 1 # Assigning a new value

?getwd()


getwd()

#############################.    EXAMPLE 1.   #################################


rm(list = ls())

library(tidyverse)
library(dplyr)


library(readxl)

#You can check your current path
getwd()

#You need to set your own path:
##On macbook your path will be similar to this:
setwd("/Users/andreapop/Desktop")

##On Windows your path will be similar to this:
#setwd("C:/Users/yourname/Desktop/01_happyR.xls")


df <- read_excel("01_happyR.xls")
View(df)


#we could also do:
df1 <- read_excel("~/Desktop/class1/01_happyR.xls")
#if I want to import other datasets:
#df2 <- read_excel("~/Documents/Desktop/02_happyR.xls")



summary(df[, c("life_expectancy", "social_support", "wine")])

#summary(df[1:10, c("life_expectancy", "social_support", "wine")])


summary(df$life_expectancy)


####check for the outliers:
boxplot(df$life_expectancy)

hist(df$life_expectancy,
     main = "Distribution of life_expectancy",
     xlab = "life_expectancy")

#which country is it that the life_expectancy is 140?
df[df$life_expectancy >= 140, ]

#what type of variable is life_expectancy?
#class(df$life_expectancy)

#that value is wrong/outlier, replace with missing:
df$life_expectancy[df$life_expectancy >= 140] <- NA

#check if it worked:
df$life_expectancy[df$life_expectancy >= 140]

#now make the histogram again:
hist(df$life_expectancy,
     main = "Distribution of life_expectancy",
     xlab = "life_expectancy")


##save the new dataset:
save(df, file = "happy.RData")


