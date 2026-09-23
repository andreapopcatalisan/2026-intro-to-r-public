

#######class 2########


rm(list = ls())


#install.packages("here")

# Install the package
library(here)
library(tidyverse)
library(dplyr)

getwd()


#here("01_imdb-top250-french.csv") 


imdb <- read.csv(
  here("data", "01_imdb-top250-french.csv"),
  encoding = "UTF-8"
)


glimpse(imdb)

imdb$Year[1:50]

#correct:
imdb <- imdb %>% 
  mutate(
    year = if_else(
      str_length(Year) == 5,   # If format is "-YYYY"
      str_sub(Year, 2, 5),     # extract positions 2-5
      str_sub(Year, 6, 9)      # otherwise extract positions 6-9
    ),
    year = as.numeric(year)    # Convert to numeric
  )

head(imdb)




# Create an "older than average" indicator 
imdb <- imdb %>%
  mutate(
    avg_year = mean(year, na.rm = TRUE),
    older_than_avg = year < avg_year
  ) %>%
  select(Name, year, avg_year, older_than_avg, Rating)

head(imdb)



#imdb <-
 #imdb %>% 
  # Fix year variable 
  #mutate(year = if_else(str_length(Year) == 5,   # If format is "-YYYY",
                     #   str_sub(Year, 2, 5),     #  extract positions 2-5
                      #  str_sub(Year, 6, 9)),    #  otherwise it's "(I) (YYYY)"  
         #  so, keep positions 6-9
   #      year = as.numeric(year)) %>%            # Convert to numeric
  # Create an "older than average" indicator 
  #mutate(avg_year = mean(year),                  # Calculate average year
   #      older_than_avg = year < avg_year) %>%   # Create indicator 
  # select(Name, year, avg_year, older_than_avg, Rating )




#3) Create a table with the average rating by decade (start from the 50s).

 imdb %>% 
  # Create decade indicator 
  mutate(decade = case_when(year %in% c(1950:1959) ~ "50s",
                            year %in% c(1960:1969) ~ "60s",
                            year %in% c(1970:1979) ~ "70s",
                            year %in% c(1980:1989) ~ "80s",
                            year %in% c(1990:1999) ~ "90s",
                            year %in% c(2000:2009) ~ "2000s",
                            year %in% c(2010:2019) ~ "2010s",
                            year %in% c(2019:2029) ~ "2020s",
                            .default = "40s or older")) %>% 
  # Create a table with average rating by decade 
  group_by(decade) %>% 
  summarise(avg_rating = mean(Rating)) 
# %>%  arrange(-avg_rating)
#



imdb <- imdb %>% 
  mutate(decade = floor(year / 10) * 10)

################################################################################
                    #############example 2################
################################################################################

rm(list = ls())

library(here)
library(tidyverse)
library(dplyr)

ts <- read.csv(here("data", "02_taylor-swift-spotify.csv"))
glimpse(ts)


###Use summarise() to compute for each album the average danceability and 
#the the number of songs included (1 row per song)

ts %>% 
  group_by(album) %>% 
  summarise(avg_danceability = mean(danceability),
            songs = n())

##Create a subset of the data called maxpopcontaining the variables album, 
#release_date, danceability and popularity for the 10 most popular songs.

maxpop <-
  ts %>% 
  arrange(-popularity) %>%          # Order by popularity (descending)
  select(album, release_date, danceability, popularity) %>% 
  filter(row_number() <= 10)        # Keep first 10 rows 
maxpop

################################################################################
                    #############example 3################
################################################################################

rm(list = ls())

library(here)
library(dplyr)

wid <- read.csv(here("data", "02_wid.csv"))
glimpse(wid)

#install.packages("ggplot2")
library(ggplot2)
ggplot()

ggplot(data = wid, # Data
       aes(x = inc_head, # Aesthetics
           y = top1)) +
  geom_point() # Geometry


ggplot(wid,
       aes(inc_head, top1)) +
geom_point() 
  
  #We can also apply ggplot() to our data with the pipe %>%
wid %>% # Data
  ggplot(aes(x = inc_head, # Aesthetics
             y = top1)) +
  geom_point() 


wid %>%
  ggplot(aes(top1, inc_head)) +
  geom_point()


wid %>%
  ggplot(aes(inc_head, fshare)) +
  geom_point()


wid %>%
  filter(country == "Italy") %>%
  ggplot(aes(year, fshare)) +
  geom_line()


wid %>%
  filter(year == "2010") %>%
  ggplot(aes(inc_head)) +
  geom_histogram()

#binwidth = 5

####AESTHETICS


wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point() +
  xlab("Income per adult") +
  ylab("Income share among top 1%")

wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point() +
  xlab(NULL) +
  ylab("") 

##THEME
wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point() +
  xlab(NULL) +
  ylab("")  +
  theme_gray(base_size = 10)

 # theme_dark(base_size = 10)
 # theme_void(base_size = 10)

#AESTHETICS GEOM ATTRIBUTES

df <- data.frame(x = rnorm(15000), y = rnorm(15000))
norm <-
  df %>%
  ggplot(aes(x,y))
norm + geom_point()



par(mar = c(3, 3, .1, .1))
norm + geom_point(size = 3)
norm + geom_point(size = 2)
norm + geom_point(size = 1)



par(mar = c(3, 3, .1, .1))
norm + geom_point(size =3)
norm + geom_point(size = 3,
                  shape = 1)
norm + geom_point(size = 3,
                  shape = "X")


par(mar = c(3, 3, .1, .1))
norm + geom_point(size =3)
norm + geom_point(size = 3,
                  shape = 1)
norm + geom_point(size = 3,
                  shape = "B")



par(mar = c(3, 3, .1, .1))
norm + geom_point(size = 3)
norm + geom_point(size = 3,
                  alpha = 1 / 2)
norm + geom_point(size = 3,
                  alpha = 0.1)

######ADDING DIMENSIONS

wid %>%
  ggplot(aes(inc_head, top1,
             color = continent)) +
  geom_point()

wid %>%
  ggplot(aes(inc_head, top1,
             color = fshare)) +
  geom_point(alpha = 0.3)

##Setting: Defining a fixed value
wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point(color = "darkblue")


##Mapping: Relating an aesthetic to a variable
wid %>%
  ggplot(aes(inc_head, top1,
             color = continent)) +
  geom_point()
# Equivalent to this:
wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point(aes(color = continent))


#What about this?
wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point(aes(color = "darkblue"))


wid %>%
  mutate(colour = "darkblue") %>%
  ggplot(aes(inc_head, top1,
             color = colour)) +
  geom_point()



#######FACETTING
wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point(alpha = 0.3) +
  facet_wrap(~continent)

wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point(alpha = 0.3) +
  facet_wrap(~continent,
             ncol = 6,
             scales = "free_x")
ggsave(here("outputs", "myplot.png"), # Where
                                            plot = last_plot(), # What
                                            width = 16, # Dimensions
                                            height = 9,
                                            unit = "cm")


#######AXES

wid %>%
  ggplot(aes(inc_head, top1)) +
  geom_point() +
  scale_x_continuous(name = "Income per adult",
                     limits = c(0, 150000)) +
  scale_y_continuous(name = "Share of income among top 1%")


################################################################################
                ############# example 4 ################
################################################################################

rm(list = ls())

library(here)
library(tidyverse)
library(dplyr)

balance <- read.csv(here("data", "02_playfair-balance.csv"))
glimpse(balance)


balance %>%
  ggplot(aes(x = year, y = exports)) +
  geom_line(aes(y = exports), # First layer
            color = "red") +
  geom_line(aes(y = imports), # Second layer
            color = "orange") +
  theme_minimal(base_size = 20) 

ggsave(here("outputs", "myplot2.png"), # Where
       plot = last_plot(), # What
       width = 16, # Dimensions
       height = 9,
       unit = "cm")




balance %>%
  ggplot(aes(x = year, y = exports)) +
  geom_line(aes(y = exports), color = "red") +
  theme_minimal(base_size = 20)


balance %>%
  ggplot(aes(x = year, y = exports)) +
  geom_line(aes(y = exports), color = "red") +
  geom_line(aes(y = imports), color = "gold") +
  theme_minimal(base_size = 20)

##LABELING EACH LAYER
balance %>% 
  ggplot(aes(x = year, y = exports)) + 
  geom_line(aes(y = exports,
                color = "Exports")) +
  geom_line(aes(y = imports,
                color = "Imports")) +
  theme_minimal() +
  scale_color_manual(values = c("red", "orange"),
                     name = NULL)


###Let's save this plot to add more things to it later:
balance_plot <-
  balance %>%
  ggplot(aes(x = year, y = exports)) +
  geom_line(aes(y = exports,
                color = "Exports")) +
  geom_line(aes(y = imports,
                color = "Imports")) +
  theme_minimal() +
  scale_color_manual(values = c("red", "orange"),
                     name = NULL)
balance_plot

###LABELS
bal_labels <- # Keep only the data for three years
  balance %>%
  filter(year %in% c(1702, 1740, 1764))

 # now run the plot
balance_plot +
  geom_point(data = bal_labels) +
  geom_text(aes(x = year, y = exports,
                label = exports),
            data = bal_labels)

##fix it
bal_labels <-
  balance %>%
  filter(year %in% c(1702, 1740, 1764)) # Keep only these
balance_plot +
  geom_point(data = bal_labels) +
  geom_text(aes(x = year, y = exports,
                label = exports),
            data = bal_labels,
            nudge_y = 4,
            nudge_x = -2)


#ANNOTATIONS
balance_plot +
  geom_vline(xintercept = 1707,
             linetype = "dashed")


balance_plot +
  geom_vline(xintercept = 1707,
             linetype = "dashed") +
  annotate("text", x = 1716, y = 150,
           label = "Acts of Union between \n
England and Scotland")


############EXERCISE##################

rm(list = ls())

library(here)
library(tidyverse)
library(dplyr)

ts <- read.csv(here("data", "02_taylor-swift-spotify.csv"))
glimpse(ts)

ts %>%
  ggplot(aes(x = popularity, y = album))

ts %>%
  ggplot(aes(x = popularity, y = album)) +
  geom_point(size = 6)

ts %>%
  ggplot(aes(x = popularity, y = album,
             shape = as.factor(is_taylors_version),
             alpha = danceability)) +
  geom_point(size = 6)


ts %>%
  ggplot(aes(x = popularity, y = album,
             shape = as.factor(is_taylors_version),
             alpha = danceability)) +
  geom_point(size = 6) +
  scale_shape_manual(values = c(15, 18))


ts %>%
  ggplot(aes(x = popularity, y = album,
             shape = as.factor(is_taylors_version),
             alpha = danceability)) +
  geom_point(size = 6) +
  scale_shape_manual(values = c(15, 16)) +
  theme_minimal(base_size = 20)


ts %>%
  ggplot(aes(x = popularity, y = album,
             shape = as.factor(is_taylors_version),
             alpha = danceability)) +
  geom_point(size = 6) +
  scale_shape_manual(values = c(15, 16)) +
  theme_minimal(base_size = 20) +
  theme(legend.position = "bottom")


###############Statistical summaries

ts %>%
  # Create summary statistic
  group_by(album) %>%
  summarise(popularity =
              mean(popularity)) %>%
  # Plot
  ggplot(aes(x = album,
             y = popularity)) +
  geom_bar(stat = "identity") +
  # Rotate axis labels
  theme(axis.text.x =
          element_text(angle = -40,
                       vjust = 1,
                       hjust = 0))


ts %>%
  filter(!is.na(album)) %>%
  ggplot(aes(x = album,
             y = popularity)) +
  geom_violin(fill = "lightblue",
              alpha = 0.5) +
  geom_boxplot(width = .1,
               alpha = 0.4)
