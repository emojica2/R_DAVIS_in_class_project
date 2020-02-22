# Homework Week 7

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

str(gapminder)

gapminder_adjusted <- gapminder %>% 
  select(pop, country, year, continent) %>% 
  filter(continent != "Oceania") %>% 
  filter(year > 2001) %>% 
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
