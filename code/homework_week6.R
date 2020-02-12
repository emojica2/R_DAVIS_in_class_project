# Problem 1

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

str(gapminder)

gapminder %>% 
  group_by(continent, year) %>% 
  mutate(mean_life = mean(lifeExp)) %>% 
  ggplot(mapping = aes(x = year, y = mean_life, color = continent)) +
           geom_point() +
  geom_line() 

# Problem 2

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = 0.25) + 
  scale_x_log10() + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# The scale_x_log10() transforms the x-axis data (gdpPercap) into the log10 scale, which compresses large values and spreads small values. The geom_smooth function puts in the trendline. 

# Challenge

ggplot(gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) +
  scale_x_log10() + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# Problem 3

gapminder %>% 
  filter(country == "Brazil" | country == "China" | country == "El Salvador" | country == "Niger" | country == "United States") %>% 
ggplot(mapping = aes(x = country, y = lifeExp)) + 
  geom_boxplot() + 
  geom_jitter(size = 2, color = "indianred") +
  xlab("Country") + 
  ylab("Life Expectancy") + 
  ggtitle("Life Expectancy of Five Countries") +
    theme(plot.title = element_text(hjust = 0.5)) 
