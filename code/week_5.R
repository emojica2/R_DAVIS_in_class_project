# Week 5

surveys <- read.csv("data/raw_data/portal_data_joined.csv")
surveys_new <- surveys[1:60, c(6,9,13)]
surveys_new$species_id <- as.character(surveys_new$species_id)
surveys_new$plot_type <- as.character(surveys_new$plot_type)
surveys_new <- surveys_new[complete.cases(surveys_new)]
# other ways to remove NAs
# is.na, ! = is not, !is.na
# na.rm


# Challenge part of HW 4
surveys_challenge <- surveys_new[(surveys_new[,2] > 150),]


# read.csv is all comes in as factors. 


# Tidyverse Homework
# load the package
library(tidyverse)

surveys2 <- read_csv("data/raw_data/portal_data_joined.csv")

surveys_tidy <- select(surveys2, species_id, hindfoot_length, year)

surveys_tidy <- surveys2 %>% 
  filter(!is.na(hindfoot_length)) %>% 
  select(species_id, hindfoot_length, year)

nrow(surveys_tidy)

surveys_tidy <- surveys_tidy[c(31338:31438),]

colnames(surveys2)

challenge_tidy <- surveys_tidy %>% 
  filter(species_id == "RM", year == 1997)



# Mutate Function!
# use read_csv to load the surveys dataframe
surveys <- read_csv("data/raw_data/portal_data_joined.csv")

# making new columns based of columns already in your dataframe

surveys_mut <- surveys %>% 
  mutate(weight_kg = weight/1000) # first argument is what you want your new column name to be # second argument is how you create this column
# mutate always adds this column at the very end of your dataset

surveys_mut <- surveys %>% 
  mutate(weight_kg = weight/1000, weight_kg2 = weight_kg * 2)
# the order of these arguments matter because if I do second argument first, the weight_kg column wouldn't exist yet. 

surveys_mut2 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000)
# now we don't have any NA's is that column

surveys_mut3 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  filter(species_id != "NL") %>% # != means "does not equal". so it will remove all the NL species 
  mutate(weight_kg = weight / 1000)

unique(surveys_mut3$species_id) # check what's in a single column...


## CHALLENGE

surveys_hindfoot_half <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length / 2) %>% 
  select(species_id, hindfoot_half) %>%
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half < 30)

# Split, Apply, Combine

# using two different functions, group_by, and summarize

surveys_group <- surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) # making a new column called mean_weight

# we can group by multiple things at once if we want

surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# calculate multiple things within a single summarize function

surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight, na.rm = TRUE))

# What's the difference between summarize and mutate? 
# They both create new columns. We can use group_by within a mutate as well

sum_surveys <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

mut_surveys <- surveys %>% 
  group_by(sex, species_id) %>% 
  mutate(mean_weight = mean(weight, na.rm = TRUE))
# mut_surveys, mutate didn't cut down our dataframe. It gives us the same value of mean_weight over and over again for each sex and species_id. Summarize function cuts this down so you get a nice small table. 


# you can summarize on multiple things

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(min_weight = min(weight), 
            max_weight = max(weight))
# this remembers the grouping that was associated with it. This usually doesn't matter, BUT you can sometimes get an error down the road with this! If you're ever running into a weird function after having group_by somewhere your code, ungroup()

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(min_weight = min(weight), 
            max_weight = max(weight)) %>% 
  ungroup()


# Joins

# jenny bryan joins tutorial

tail <- read_csv("data/raw_data/tail_length.csv")
tail

summary(surveys$record_id)
summary(tail$record_id)

# basic structure of a join
# join_function(first_data, second_data, by = column_to_join_by)

# the columns in common have to be named the same thing. Uppercase matters! You can use the rename() function for things like this. 

# a left join
# if there's a row in one column that doesn't have a match in the second, it will keep that row and the other column will get an NA, that it doesn't exist in that dataset. 

surveys_join <- left_join(surveys, tail, by = "record_id")

NL_data <- surveys %>% 
  filter(species_id == "NL")

NL_data_tail <- left_join(NL_data, tail, by = "record_id")
# it's the size of NL_data with all the values from tail that match these values

# in left_join, you have a target dataset, and you're just adding something from this other dataset. We're not interested in everything from the tail dataset, but instead the data in NL_data, and we want to add matching values from tail to that dataset. 

# you need a unique identifier, and sometimes that's going to be multiple columns. 



# joining by multiple columns
# join_function(first_data, second_data, by = c("year", "month", "day"))




# Reshaping data
# pivot_longer, pivot_wider


# pivoting with tidyr

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

str(surveys_mz)

# goal here is to have a column for every genus

unique(surveys_mz$genus)
# so we have ten genera here

n_distinct(surveys_mz$genus)
# this does the same as above. The number of distinct values in there

n_distinct(surveys_mz$plot_id)
# 24 plot_id values

wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = "genus", values_from = "mean_weight") # names_from is what column in our surveys_mz do we want to get the names of the new column from

# one row for each plot id, and it has 11 columns. one for each of the ten genera, and one for out plot_id



# pivoting from wide to long

wide_survey %>% 
  pivot_longer(cols = -plot_id, names_to = "genus", values_to = "mean_weight") # this means that we want to collapse all of the columns except plot_id into one column. 

surveys_mz
# in our pivot_longer surveys, it is longer than surveys_mz because it filled in NAs. In plot_id 1, for example, there was no Sigmodon. 

