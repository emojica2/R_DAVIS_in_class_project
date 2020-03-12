# Week 10 

# intro to writing functions

my_sum <- function(a, b){
  the_sum <- a + b
  return(the_sum)
}

my_sum(a = 5, b = 10) # the object my_sum is self-contained within this function
the_sum_2 <- 10 + 4 # this output appears in global environment

a <- 20
b <- 2
my_sum() # my_sum can't find a and b from the global environment, you need to give them as arguments

my_sum(10, 35)

my_sum2 <- function(a = 2, b = 5){
  the_sum <- a + b
  return(the_sum)
}

my_sum2() # now it gives us 7 because we have defaults. 

my_sum2(12)
my_sum2(b = 25)
my_sum2(4, 1)


# functions to convert temperatures

F_to_K <- function(temp){
  K <- ((temp - 32) * (5/9)) + 273.15
  return(K)
}

F_to_K(32)
F_to_K(212)


# source()-ing functions

source("code/functions.R")


# Challenge
# making a function that returns a line plot of pop over time for a single country

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

plot_pop_growth <- function(data, plot_country){
  plot <- data %>% 
    filter(country == plot_country) %>% 
    ggplot(mapping = aes(x = year, y = pop)) + 
    geom_line()
  return(plot)
}

plot_pop_growth(data = gapminder, plot_country = "Afghanistan")



# Intro to Iteration

# lots of base functions are already vectorized

x <- 1:10

log(x)


# for loops

for(i in 1:10){
  print(i)
}

1:10

# these two above are different. for loop prints 10 different times. 



# multiple lines of code in one loop

for(i in 1:10){
  print(i)
  print(i^2)
}

# using i as an index to subset

for(i in 1:10){
  print(letters[i])
  print(mtcars$mpg[i])
}


for(cat in 1:10){
  print(letters[cat])
  print(mtcars$mpg[cat])
}


# making an empty results vector and filling it in

results <- rep(NA, nrow(mtcars))

for(i in seq_along(results)){
  results[i] <- mtcars$wt[i] * 1000
}

results

countries <- unique(gapminder$country)[1:10]

for(i in seq_along(countries)){
  plot_pop_growth(data = gapminder, plot_country = i)
}



# conditional statements

# sometimes you want to run some code, but only if a certain condition is met


for(i in 1:10){
  if(i < 5){
    print(paste(i, "is less than 5"))
  } else {
    print(paste(i, "is greater than or equal to 5"))
  }
}


# case_when is a nested conditional 

mtcars %>% 
  mutate(car_size = case_when(
    wt > 3.5 ~ "big",
    wt > 2.5 ~ "medium",
    TRUE ~ "small"
  )) # this evaluates in order!!!! so you say the top level thing first

mtcars %>% 
  mutate(car_size = case_when(
    wt > 3.5 | cyl == 8 ~ "big",
    wt > 2.5 ~ "medium",
    TRUE ~ "small"
  ))


