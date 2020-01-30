# Problem 1

surveys_base <- read.csv("data/raw_data/portal_data_joined.csv")
colnames(surveys_base)
surveys_base <- surveys_base[1:60,c(6, 9, 13)]
surveys_base$species_id <- as.character(surveys_base$species_id)
surveys_base$plot_type <- as.character(surveys_base$plot_type)
surveys_base <- surveys_base[complete.cases(surveys_base), ]
str(surveys_base)
colnames(surveys_base)

challenge_base <- surveys_base[(surveys_base[, 2]>150), ]

# Problem 2

library(tidyverse)
surveys2 <- read_csv("data/raw_data/portal_data_joined.csv")

surveys_tidy <- select(surveys2, species_id, hindfoot_length, year)

surveys_tidy <- surveys2 %>% 
  filter(!is.na(hindfoot_length)) %>% 
  select(species_id, hindfoot_length, year)

nrow(surveys_tidy)

surveys_tidy <- surveys_tidy[c(31338:31438),]

colnames(surveys2)

challenge_tidy <- surveys2 %>% 
  filter(species_id == "RM") %>% 
  filter(year == 1997)
