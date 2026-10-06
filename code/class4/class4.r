

rm(list = ls())


#install.packages("here")

# Install the package
library(here)
library(tidyverse)
library(dplyr)


getwd()


#here("01_imdb-top250-french.csv") 


cps <- read.csv(
  here("04_202308_cps.csv")
)


str(cps)


####regressions
lm(earnings ~ hours, cps)
lm(earnings ~ hours, data = cps)

#complete description of our regression
mod <- lm(earnings ~ hours, cps)
summary(mod)

sum_mod <- summary(mod)
str(sum_mod, give.attr = F)

sum_mod$coefficients
sum_mod$coefficients[2,1]
sum_mod$coefficients[,"Std. Error"]

##We can use this to compute the fitted values y= α+ βx
alpha <- sum_mod$coefficients[1,1]
beta  <- sum_mod$coefficients[2,1] 
cps$hat_earnings <- alpha + (beta * cps$hours)

#or you can create the new column like this: 
cps <- cps %>%
  mutate(hat_earnings = alpha + (beta * hours))


#We can easily plot the distribution of our residuals

cps <- cps %>%
  mutate(
    hat_earnings = alpha + beta * hours,
    residual = earnings - hat_earnings
  )

#we can plot the distribution of the residuals
cps %>%
  ggplot(aes(x = residual)) +
  geom_density() +
  geom_vline(xintercept = 0, linetype = "dashed")


#we can also plot the fitted valus
cps %>% 
  ggplot(aes(x = hours, y = earnings)) +
  geom_point() +
  geom_smooth(method = "lm")


##############PRACTICE 1###############

cps %>% 
  mutate(beta = cov(hours, earnings) / var(hours),
         alpha = mean(earnings) - beta * mean(hours),
         y_hat = alpha + beta * hours,
         res = earnings - y_hat)


cps %>% 
  mutate(beta = cov(hours, earnings) / var(hours),
         alpha = mean(earnings) - beta * mean(hours),
         y_hat = alpha + beta * hours,
         res = earnings - y_hat) %>% 
  summarise(alpha = first(alpha),
            beta = first(beta),
            r2 = 1 - sum(res^2) / sum((earnings - mean(earnings))^2))


sum_mod$coefficients[,"Estimate"]

mod <- lm(earnings ~ hours, cps)
summary(mod)
sum_mod$r.squared

#############################

###USING BINARY AND CATEGORICAL VARIABLES
cps$sex

lm(earnings ~ sex, data = cps)

cps %>% 
  group_by(sex) %>% 
  summarise(y_bar = mean(earnings)) %>% 
  mutate(dif = y_bar - y_bar[1])

lm(earnings ~ sex, data = cps)

unique(cps$educ)

cps %>% 
  group_by(educ) %>% 
  summarise(y_bar = mean(earnings)) %>% 
  mutate(dif = y_bar - y_bar[1])


x <- c("Man", "Male", "Man", "Lady", "Female")
## Map from 4 different values to only two levels:
xf <- factor(x, levels = c("Male", "Man" , "Lady",   "Female"),
             labels = c("Male", "Male", "Female", "Female"))
xf


levels(as.factor(cps$educ)) # Default order is alphabetical

cps <-
  cps %>% 
  mutate(educf = factor(educ, levels = c("No high school", "High school",
                                         "Associate degree", "Bachelor's degree")))
levels(cps$educf)

cps <-
  cps %>% 
  mutate(educf = relevel(as.factor(educ), ref = "No high school"))
levels(cps$educf)

#We can also modify our educ variable directly in the regression call:
lm(earnings ~ relevel(as.factor(educ), ref = "No high school"), data = cps)
#or
lm(earnings ~ factor(educ, levels = c("No high school", "High school", 
                                      "Associate degree", "Bachelor's degree")),
   data = cps)


##############PRACTICE 2###############

lm(earnings ~ age, data = cps) %>% 
  summary()

lm(earnings ~ as.factor(age), data = cps) %>% 
  summary()


cps <- cps %>% 
  mutate(educ_nohs  = as.numeric(educ == "No high school"),
         educ_hs    = as.numeric(educ == "High school"),
         educ_assoc = as.numeric(educ == "Associate degree"),
         educ_bach  = as.numeric(educ == "Bachelor's degree"))

lm(earnings ~ educ_hs + educ_assoc + educ_bach, data = cps)

y <- as.matrix(cps$earnings)
X <- cps %>% 
  mutate(constant = 1) %>% 
  select(constant, contains("educ_")) %>%  
  as.matrix()
dim(y)

##remove one category:

X <- cps %>% 
  mutate(constant = 1) %>% 
  select(constant, educ_hs, 
         educ_assoc, educ_bach) %>%  
  as.matrix()
solve(t(X) %*% X) %*% (t(X) %*% y)

lm(earnings ~ educ_hs + 
     educ_assoc + educ_bach, 
   cps)

#Actually, if we don't drop anything lm() would still work:
lm(earnings ~ educ_nohs + educ_hs + educ_assoc + educ_bach, 
   cps)

########################
#Variable transformation

ggplot(cps, aes(x = earnings)) + 
  geom_density()

ggplot(cps, aes(x = log(earnings))) + 
  geom_density()

cps %>% 
  ggplot(aes(x = hours, y = log(earnings) )) +
  geom_point() +
  geom_smooth(method = "lm")

#FUNCTIONAL FORM
cps %>% 
  ggplot(aes(x = hours, y = log(earnings) )) +
  geom_point() +
  geom_smooth(method = "lm",
              formula = y ~ poly(x, 2))


cps <- cps %>%
  mutate(logearnings = log(earnings),
         sqhours = hours^2)

lm(logearnings ~ hours + sqhours, cps )

##control variables
cps <- 
  cps %>% 
  mutate(male = 
           as.numeric(sex == "Male"))
lm(hours ~ male, cps)


lm(logearnings ~ hours + sqhours + male, cps)

#INTERACTION TERMS
mod <- lm(logearnings ~ hours + sqhours + male + male*hours, cps)
results <- summary(mod)$coefficients

#HYPOTHESIS TESTING
linearHypothesis(
  lm(logearnings ~ hours + sqhours + male + hours*male, cps),
  c("male = 0"))

linearHypothesis(
  lm(logearnings ~ hours + sqhours + male + hours*male, cps),
  c("hours = 0", "sqhours = 0", "male = 0", "hours:male = 0"))

#install.packages("huxtable")
library(huxtable)
##EXPORTING RESULTS
outreg <- huxreg(Baseline = lm(logearnings ~ hours, cps),
                 lm(logearnings ~ hours + sqhours, cps),
                 lm(logearnings ~ hours + sqhours + male, cps),
                 lm(logearnings ~ hours + sqhours + male + male*hours, cps),
                 error_format = "({std.error})",
                 error_pos = "below",
                 statistics = c(N = "nobs", R2 = "r.squared"),
                 stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.1),
                 note = "Dependent variable: log weekly earnings. {stars}")

outreg
quick_latex(outreg, here(file = "output", "./04_regtable.tex"))


##############PRACTICE 3###############

#Use the functions huxreg(), insert_row() and merge_cells() to reproduce this table and export it to html.



huxreg(lm(logearnings ~ hours, cps),
       lm(logearnings ~ hours + sqhours, cps),
       lm(logearnings ~ hours + sqhours + male, cps),
       lm(logearnings ~ hours + sqhours + male + male*hours, cps),
       error_format = "({p.value})",
       error_pos = "below",
       statistics = c(N = "nobs", "R2 adj." = "adj.r.squared"),
       stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.1),
       coefs = c("Hours worked" = "hours",
                 "(Hours worked)²" = "sqhours",
                 "Male" = "male",
                 "Hours worked x Male" = "hours:male",
                 "Constant" = "(Intercept)"),
       note = "P-values in parentheses. {stars}",
       align = "c") %>% 
  insert_row(c("", "Dependent variable: Log weekly earnings", rep("", 3))) %>% 
  merge_cells(1, 2:5) %>% 
  set_align(1, 2, "center")


##plot
install.packages("jtools")
install.packages("purrr")
library(jtools)
library(purrr)
library(ggplot2)

plot_summs(lm(logearnings ~ hours + sqhours, cps),
           lm(logearnings ~ hours + sqhours + male, cps),
           lm(logearnings ~ hours + sqhours + male + educ_hs + educ_assoc + educ_bach, cps),
           omit.coefs = "(Intercept)",
           ci_level = 0.99,
           colors = c( "#296EB4","#D84727","#69995D")) + 
  geom_hline(yintercept = 3.5, linetype = "dotted")




