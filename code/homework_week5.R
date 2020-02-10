# Question 1

library(tidyverse)
surveys <- read_csv("data/raw_data/portal_data_joined.csv")

# Question 2

surveys_2 <- surveys %>% 
  filter(weight > 30 & weight < 60)
surveys_2 <- surveys_2[c(1:6),]
surveys_2

# Question 3

biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(weight_max = max(weight))

biggest_critters %>% arrange(weight_max)
biggest_critters %>%  arrange(desc(weight_max))

# Question 4

surveys %>% 
  filter(complete.cases(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(complete.cases(weight)) %>% 
  group_by(species_id) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(complete.cases(weight)) %>% 
  group_by(year) %>% 
  tally() %>% 
  arrange(desc(n))

# Question 5

surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

# Question 6

surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > mean(weight))

# Question 7

surveys %>% 
  filter(complete.cases(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarize(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)
           