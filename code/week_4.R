# Week 4 R-DAVIS

# Factors as data: 
# Basically integers that have a character name assigned

sex <- as.factor(c("male", "female", "male", "male"))

sex
class(sex)
typeof(sex)
# we get integer here. Factors are really just integer vectors with characters attached to them. 

# Reordering factor
sex <- factor(sex, levels = c("male", "female"))

# converting factors to characters

as.character(sex)

year_fct <- as.factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)
# it doesn't work. it assigned each position a numeric value. 
# we have to convert factor to character, then to numeric. 

as.numeric(as.character(year_fct))
# remember, R works from the inside to the outside.
# This worked!

year_fct <- as.numeric(as.character(year_fct))
# you have to reassign it to get it to change in the global environment

# Renaming factors and levels within factors

levels(sex)
# Pull something from vector with square brackets

levels(sex)[1]
# R knows that we want "male"

levels(sex)[1] <- "MALE"
levels(sex)

## Challenge

levels(sex)[1] <- "M"
# or could do levels(sex) <- c("M", "F")
levels(sex)[2] <- "F"
levels(sex)
sex <- factor(sex, levels = c("F", "M"))
levels(sex)
str(sex)



## Starting with Data
surveys <- read.csv("data/raw_data/portal_data_joined.csv") # this is a data.frame

class(surveys)
# a data.frame is a bunch of vectors that are all exactly the same length
# every column is a single data type

nrow(surveys)
# number of rows in the data.frame
head(surveys) # the first 6 rows

colnames(surveys)
# gives us the name of all of the columns as characters

summary(surveys)
# gives us a summary of everything in the data.frame. tells us about every column. We can see that there are a ton of NA's in the hindfoot_length column, for example. 

str(surveys)
# Questions: 1) Class of the object surveys is data.frame. 2) There are 13 columns and 34786 rows in this data.frame. 3) Character data are represented as factor in this data.frame. 4) 48 species have been recorded in these surveys. 
# you could make a mistake here. species had 40 levels, species id had 48 levels. you can use a command called unique(). 

surveys$species_id <- as.character(surveys$species_id)
str(surveys)

# pulling out unique identifiers in a column

length(unique(surveys$species_id))
unique(surveys$species)

# The dollar sign is for pulling out single columns in a data.frame



# Indexing and subsetting data.frames

# Brackets have two dimensions for dataframe 
# [row, column]

surveys[1,1]

# first element in the sixth column
surveys[1, 6]

# pull out all the rows but just the third column
surveys[,3]
# if there is a blank space R thinks we want everything

# first three elements of 7th column
surveys[1:3, 7]

head(surveys)

# all columns, rows 1-6
surveys[1:6,]

# exclude the first column

surveys[ , -1]
# put a minus sign. This gives us back everything except that first column

surveys[-c(7:34786),] # this is the same as head, just the first six rows


# also call columns by their names

surveys["species_id"]
# this HAS to be in quotations! Pulling out all rows

surveys[1:6, "species_id"]


# Challenge: subsetting a dataframe

surveys_200 <- surveys[200,]
nrow(surveys)
surveys[34786,]
tail(surveys)
surveys_last <- surveys[34786,]
n_row <- nrow(surveys)
surveys_middle <- surveys[(34786/2),]
surveys_middle <- surveys[(n_row/2),]
surveys[-c(7:34786),]

surveys_head <- surveys[-c(7:n_row),]

surveys[mean(n_rows),] # doesn't work because I'm taking the mean of just one number



## TIDYVERSE HUZZAH

# install.packages("tidyverse")
# comment your install.packages line of code out once you've run the code once :) 

# how to load a package
library(tidyverse)

surveys <- read_csv("data/raw_data/portal_data_joined.csv")
# not read.csv. This function comes from package readr, which is in tidyverse

# character columns are coming in as characters instead of factors!!! This is a very nice thing. The col_double() is another way that tidyverse thinks about what is in our data. 

surveys
# this is called a "tibble" which is another word for a data.frame

class(surveys)
#one of them is a data.frame. A tbl or "tibble" is the same as a data frame but in tidyverse and a pretty way to read it in. We also see tbl_df or tbl. wait tbl is table? 


# dplyr is an awesome package. So nice for subsetting! They introduced a thing called a pipe. Allows you to do multiple functions on the same dataframe at once. 

# Select and filter. These are two functions in dplyr universe

# select is for columns, and filter is for rows


surveys_new <- select(surveys, plot_id, species_id, weight)
# didn't have to put these in quotations

surveys_plot3 <- filter(surveys, plot_id == 3)

# Let's talk about pipes

# I want all weights greater than 5 and only the columns, species_id, sex, and weight

surveys2 <- filter(surveys, weight > 5)

surveys_sml <- select(surveys2, species_id, sex, weight)

# you can also use a pipe to do this in one step
# a pipe looks like this %>% 
# there are keyboard shortcuts for this. cntrl + shift + m

surveys_sml2 <- surveys %>% 
  filter(weight > 5) %>% 
  select(species_id, sex, weight)

surveys %>% 
  filter(weight > 5) %>% 
  select(species_id, sex, weight)




