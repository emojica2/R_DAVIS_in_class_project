# Week 8 

# reviewing week_7_homework
library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

str(gapminder)

gapminder_adjusted <- gapminder %>% 
  select(pop, country, year, continent) %>% 
  filter(continent != "Oceania") %>% 
  filter(year %in% c(2002, 2007)) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  mutate(population_change = `2007` - `2002`)

gapminder_adjusted %>% 
  ggplot(mapping = aes(x = reorder(country, population_change), y = population_change)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~ continent, scales = "free") + 
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007") + 
  theme_bw() + 
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

gapminder %>% 
  filter(year %in% c(2002, 2007),
         continent != "Oceania") %>% 
  group_by(country) %>% 
  mutate(pop_diff = diff(pop)) %>% 
  select(country, continent, pop_diff) %>% 
  distinct()


## New lesson: Data import and export

library(tidyverse)
species.dot <- read.csv("data/raw_data/species.csv")
species.dot

species_underscore <- read_csv("data/raw_data/species.csv")
species_underscore

str(species.dot)
# Everything is set to factors in species.dot

surveys.dot2 <- read.csv("data/raw_data/species.csv", stringsAsFactors = FALSE)
str(surveys.dot2)
# Now everything is characters, which is what we want. 


# Challenge - what if a collaborator used a semicolon separated file, and used commas instead of decimals? 

read.csv2()
read.csv(sep = ";")
?read.table


read_csv("data/raw_data/wide_eg.csv")
# you can put in comments in the first row of your data and then have your data start below. but then what you have to tell the function is that you want to skip a couple rows. 

read_csv("data/raw_data/wide_eg.csv", skip = 1) # skip the number of rows you want to skip

read_csv("data/raw_data/wide_eg.csv", skip = 2)


# exporting a CSV

write_csv(x = species.dot, path = "data/cleaned_data/species_dot_written.csv") # has to end with .csv!!!!


# .rda and .rds files

save(species.dot, species_underscore, file = "data/cleaned_data/species_dataframes.rda")


load(file = "data/cleaned_data/species_dataframes.rda")
# you don't have to assign this to an object! it just brings them into your global environment!!! They are the original R objects!

saveRDS()
readRDS()
# these are the functions that do it. With an RDS file, you can only store one object. 

saveRDS(species_underscore, file = "data/cleaned_data/species_underscore.rds")
new_species_underscore <- readRDS(file = "data/cleaned_data/species_underscore.rds")
# another diff with an RDS is that you actually have to assign the output into something



# saving a plot

surveys <- read_csv("data/raw_data/portal_data_joined.csv")

surveys %>% 
  ggplot(aes(x = year, y = hindfoot_length, color = genus)) +
  geom_jitter() 

ggsave(filename = "images/surveys_hindfoot_year_species.jpg", width = 6, height = 6)
?ggsave


# some cool packages

readxl::
googlesheets4::
  # it let's you pull in info directly from google sheets! then it would be live. very nice!!
  
foreign::
  # functions to read very weird data files

rio::
  # has import and export functions. you just give the file name and it detects the type of file that it is and matches it to the right function to bring it in.

read_csv()






## Starting a new lesson


# Datetimes in R!

# Date is a data format that R recognizes

# Three basic time classes in R
# 1. Date: just for dates (2/25/2019)
# 2. Datetime: POSIXct best for dates with times (ct = calendar time). Almost all the time we'll use POSIXct time. 
# 3. POSIXlt (lt = local time)


# PRO TIP! 
# When you enter your data in separate columns for year, month, day, and time

sample_dates_1 <- c("2018-02-01", "2020-02-25", "2019-04-04")
# r reads them in as characters. because we have numbers and symbols. 
# we want to change this to a "date" class

sample_dates_1 <- as.Date(sample_dates_1)
# now the datatype changes to date

# the only reason that worked is because that's the format that R is already looking for: YYYY MM DD


sample_date_2 <- c("02-25-2020", "04-04-1988", "05-05-2019", "06-01-2020")
# first come up as characters

sample_date_2 <- as.Date(sample_date_2)
# we get an error message. R does not like this format. 


sample_date_2 <- as.Date(sample_date_2, format = "%m-%d-%Y")
# see lesson for cheatsheet

# 05A21A1998

# format = "%mA%dA%Y"


# Challenge
# Jul 04, 2019

challenge_date <- c("Jul 04, 2019")
challenge_date <- as.Date(challenge_date, format = "%b %d, %Y")




time <- c("2016-07-24 22:55:01", "2013-04-12 18:50:11")
# nice format that R likes: YYYY MM DD, HH:MM:SS

time <- as.POSIXct(time)
# now the data type is POSIXct
# the time zone that R reports is the time zone that I am in. But what if this isn't correct? 

time <- as.POSIXct(time, tz = "GMT")
# now our time zone has changed in our dataframe!

?as.POSIXct # to find all the time zones. tz = time zone


