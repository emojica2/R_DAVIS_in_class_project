# Week 9 Optional Homework

library(tidyverse)
library(lubridate)

load("data/raw_data/mauna_loa_met_2001_minute.rda")

mloa_2001$datetime <- ymd_hm(paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min), tz = "Pacific/Honolulu")

head(mloa_2001$datetime)

mloa_2001 <- mloa_2001 %>% 
  filter(!rel_humid == -99, !temp_C_2m == -999.9, !windSpeed_m_s == -99.9) %>% 
  mutate(mon = month(datetime, label = TRUE, abbr = TRUE))

mloa_2001 <- mloa_2001 %>% 
  group_by(mon) %>% 
  summarize(avg_temp_2m = mean(temp_C_2m))

mloa_2001 %>% 
  ggplot(mapping = aes(x = mon, y = avg_temp_2m)) + 
  geom_point() +
  ylab("Average Montly Temperature (C)") +
  xlab("Month")

