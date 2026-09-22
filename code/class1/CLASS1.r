

################################################################################
a <- 100

class(a)


e <- "4"
a + e

###vector
c("Hello world", 35, FALSE)


v1 <- c(1, 2, 3)
v1
v1 / 3
v1 %*% v1 # Matrix multiplication


df <- data.frame(hello = 1:3)


#############################.    EXAMPLE 2.   #################################


rm(list = ls())


#install.packages("here") # Install the package
library(here)

getwd()


#here("01_imdb-top250-french.csv") 

imdb <- read.csv(here("01_imdb-top250-french.csv"))

str(imdb)
imdb$Name


# Exploring the data
head(imdb, 4)
tail(imdb, 3)
View(imdb) 

#correct:

imdb <- read.csv(
  here("01_imdb-top250-french.csv"),
  encoding = "UTF-8"
)



#Let's explore the dataset with function str()
str(imdb)

imdb$Name

imdb$new_var <- c(250:1) # sequence going backwards from 250 to 1.

imdb[1, c("Name", "Year")]
imdb[1, c(2, 4)]



#First row and cols "Name" and "Year":

#First 10 rows, all columns:
imdb[1:10,] 
imdb[1:10, c("Name")] 
imdb[1, c("Name", "Year")]
imdb[1, c(2, 4)]

vector <- c(Name = 10, Age = 20, Year = 2020)
vector["Name"]


#Name of the movies ranked 11-14 :
names(imdb)

imdb[Rank < 15 & Rank > 10, "Name" ] 
# This doesn't work. Why?
#R looks for an object called Rank in your environment.

#But Rank isn't a separate object. It's a column inside the imdb dataframe:
imdb[imdb$Rank < 15 & 
       imdb$Rank > 10, "Name"]




#####################Exercise
#all durations:
imdb$Duration

#min duration
min(imdb$Duration)


as.numeric(imdb$Duration)


imdb$Duration <- substr(imdb$Duration, start = 1, stop = 3) # Get first 3 characters
imdb$Duration <- as.numeric(imdb$Duration)                  # Convert to numeric
min(imdb$Duration)                                          # Get minimum duration

###create the variable that shows the units
imdb$Unit <- "min"


#There are 6 movies that last 104 minutes, what are they called?
imdb[imdb$Duration == 104, "Name"]


#######                   MAIN FUNCTIONS IN dplyr

library(dplyr)
imdb %>% 
  select(Name, Rank, Duration) 



# Create a new variable
imdb <- imdb %>%
  mutate(top50 = Rank <= 50)




# Modify existing var
imdb <- imdb %>%
  mutate(Duration =
           as.numeric(substr(Duration, 1, 3)))     

# Keep/drop certain rows
imdb <- imdb %>%
  filter(Name != "Amélie") 


# Sort rows
imdb <- imdb %>%
  arrange(Rank) 

# Aggregate into statistics
abc <-  imdb %>%
  summarise(
    avg_dur = mean(Duration),
    min_dur = min(Duration),
    max_dur = max(Duration)
  )


imdb %>%
  summarise(
    avg_rank = mean(Rank),
    min_rank = min(Rank),
    max_rank = max(Rank)
  )




#what happens if we do this:
#imdb <- imdb %>%
 # summarise(
  #  avg_dur = mean(Duration),
  #  min_dur = min(Duration),
   # max_dur = max(Duration)
 # )

  
  

# we can put the code together as well:
#imdb %>% 
# select(Name, Rank, Duration)  %>% 
#mutate(top50 = Rank <= 50) %>% 
#mutate(Duration =
#        as.numeric(substr(Duration, 1, 3)))     




##EXERCISE
imdb <- imdb %>%
  mutate(Duration =
           as.numeric(substr(Duration, 1, 3)))     


imdb %>%
  mutate(duration = as.numeric(substr(Duration, 1, 3))) %>%
  mutate(category = if_else(duration < 40,
                            "short",
                            "long")) %>%
  group_by(category) %>%
  mutate(cat_rank = rank(Rank)) %>%
  select(Name, category, duration, Rank, cat_rank)


##if we want to save the variable:
imdb <- imdb %>%
  mutate(duration = as.numeric(substr(Duration, 1, 3))) %>%
  mutate(category = if_else(duration < 40,
                            "short",
                            "long"))


########################################################################################

#rename
#imdb <- imdb |> 
#  rename(Title = Name)
