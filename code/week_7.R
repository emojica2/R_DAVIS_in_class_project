#Week 7

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

# homework review, question 1

gapminder %>% 
  rename(Continent = continent) %>% 
  group_by(Continent, year) %>% 
  summarise(mean_LifeExp = mean(lifeExp)) %>% 
  ggplot(mapping = aes(x = year, y = mean_LifeExp, color = Continent)) +
           geom_point() + 
           geom_line()

# Lesson for week 7

# load survey data in 

surveys_complete <- read_csv("data/raw_data/portal_data_joined.csv") %>% 
  filter(complete.cases(.)) # shortcut for saying all columns is a period


yearly_counts <- surveys_complete %>% 
  count(year, species_id)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line()
# This puts all the lines together

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line(aes(color = species_id))
# each species gets its own line

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line()
# gives us the same plot, just without color

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, linetype = species_id)) +
  geom_line()


# Faceting

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)


# Challenge

yearly_counts_sex <- surveys_complete %>% 
  count(species_id, year, sex) # create new data frame to tally up each sex/species id/year

yearly_counts_sex %>% 
  ggplot(mapping = aes(x = year, y = n)) +
  geom_line(aes(color = sex)) + 
  facet_wrap(~ species_id) + 
  theme_bw() +
  scale_color_viridis_d()

# ggthemes package has many color palette options. 
# viridis package is also great! color blind friendly. 

scale_color_viridis_d() # d for discrete, c for continuous



# Intro to publishing plots with cowplot


library(cowplot)

plot.diamonds <- diamonds %>% 
  ggplot(aes(x = clarity, fill = cut)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5))

plot.cars <- mtcars %>% 
  ggplot(aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 2) + 
  theme_minimal()
 
plot.cars2 <- mpg %>% 
  ggplot(aes(x = cty, y = hwy, color = factor(manufacturer))) + 
  geom_point()

# now using cowplot to stitch them together

plot_grid(plot.cars, plot.diamonds, plot.cars2, labels = c("A", "B", "C"), ncol = 2, nrow = 2)

# patchwork package does something similar, and even simpler. 


# plotly for interactive plots

library(plotly)

plot.cars %>% 
  ggplotly()

ggplot(mtcars, mapping = aes(x = wt, y = mpg)) + 
  geom_point() + 
  geom_smooth(method = "lm", aes(group=factor(cyl), color = factor(cyl))) + 
  theme(text = element_text(size = 25, family = "Roboto Condensed"))
# linear regression line

# you can plot the output of some complex regression function



plot.diamonds + my_theme

# you can save theme components and save it to an object to reuse that theme

