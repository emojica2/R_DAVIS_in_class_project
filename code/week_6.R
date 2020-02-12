# Week 6

# Starting with ggplot2

library(tidyverse)
surveys_complete <- read_csv("Data/raw_data/portal_data_joined.csv") %>% 
  filter(complete.cases(.)) # the period tells R to put the pipe right into that place, instead of before complete.cases. 

surveys_complete

# Basic ggplot building

# ggplot(data = DATA, mapping = aes(MAPPINGS)) + geom_function()

ggplot(data = surveys_complete)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) 

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()

# we can store whole plots or parts of plots as objects
# assigning part of a plot to an object

surveys_plot <- ggplot(data = surveys_complete,
                       mapping = aes(x = weight, 
                                     y = hindfoot_length))
surveys_plot


surveys_plot + geom_point()


ggplot() + 
  geom_point(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
# this gives us the same plot, but only geom_point can see this data! It's like geom_point's little secret stuff that it can do with it. 
# if you put everything in ggplot, the data are universal so every following function works off of it


# modify a specific geom by itself

ggplot(data = surveys_complete, 
       mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1) # alpha is the transparency value...
# each point is given the same transparency. 

ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "plum4")

# color by species_id
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))
# using aes call in geom_point to assign a different color to all species_id in the dataframe


# can also include color within the ggplot call. Gives us the same plot as above
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point(alpha = 0.1)

# challenge

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight, color = plot_type)) +
  geom_point()

ggplot(data = surveys_complete,
       mapping = aes(x = plot_type, y = weight, color = species_id)) +
  geom_point()

# let's make a boxplot of weight on Y axis and species_id on the X axis


surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) +
  geom_boxplot() + 
  geom_jitter(alpha = 0.3, color = "tomato")

# flip order so boxplot is on top

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, aes(color = plot_type)) + 
  geom_boxplot(color = "blue") 

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3) + 
  geom_boxplot(aes(color = genus)) 


# Challenge 2

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) + 
  geom_violin()

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) +
  geom_violin() + 
  scale_y_log10()

# make a plot with just species NL and PF where we want distribution of hindfoot_length
surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) +
  geom_violin() + 
  scale_y_log10()


surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) + 
  geom_jitter(alpha = 0.3, aes(color = as.factor(plot_id))) +
  geom_boxplot(alpha = 0.5) 

# two color aes, color and fill
# you can do fill = NA, which makes the fill of the boxplot clear. 

surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) + 
  geom_jitter(alpha = 0.3, aes(color = as.factor(plot_id))) +
  geom_boxplot(fill = NA) 
