
#############################.    CLASS 3.   #################################


rm(list = ls())


#install.packages("here")

# Install the package
library(here)

getwd()

names <- read.csv(
  here("data", "fichier_prenoms.csv"),
  sep = ";",
  encoding = "UTF-8"
)

str(names)

####

library(tidyverse)
library(dplyr)
library(ggplot2)

#1) Recode the sexe variable with Male and Female instead of 1 and 2
names %>%
  mutate(sex = ifelse(sexe == 1, "Male", "Female"))


names <- names %>%
  mutate(sex = ifelse(sexe == 1, "Male", "Female"))

#2) Filter out observations for which annais is XXXX and convert annais to numeric
names %>%
  mutate(sex = ifelse(sexe == 1, "Male", "Female")) %>%
  filter(annais != "XXXX") %>%
  mutate(annais = as.numeric(annais))


#3) Summarise your data into the total number of births per year
names %>%
  mutate(sex = ifelse(sexe == 1, "Male", "Female")) %>%
  filter(annais != "XXXX") %>%
  mutate(annais = as.numeric(annais)) %>%
  group_by(annais) %>%
  summarise(n = sum(nombre))


#4) Plot the evolution of the number of births over time using a line geometry
names %>%
  mutate(sex = ifelse(sexe == 1, "Male", "Female")) %>%
  filter(annais != "XXXX") %>%
  mutate(annais = as.numeric(annais)) %>%
  group_by(annais) %>%
  summarise(n = sum(nombre)) %>%
  ggplot(aes(x = annais, y = n)) +
  geom_line()
