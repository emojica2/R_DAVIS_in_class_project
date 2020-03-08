# Week 9 

# Working with Date Times in R using 'lubridate' package

# let's download the NYC_2015_solinst.csv together from the R-DAVIS Website

# load packages

library(tidyverse)
library(lubridate)

nfy1 <- read_csv("data/raw_data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd") # columns as character, char, int, dibble (decimals), dibble

sample_dates <- c("07-15-2019", "12-24-2018", "03-07-2013", "04-04-2019")

sample_dates <- as.Date(sample_dates, format = "%m-%d-%Y")

dt <- c("07-15-2019 14:32:09", "12-24-2018 12:40:01")
dt <- as.POSIXct(dt, format = "%m-%d-%Y %H:%M:%S", tz = "GMT")
dt


# Lubridate!

dates_lub <- lubridate::mdy(sample_dates) # this says "in the lubridate package, call this function

lubridate:: # do this to look at all of the functions in the package
  
sample_dates2 <- c("5A06A17 14:22", "8A17A13 06:33")

sample_dates2_lub <- mdy_hm(sample_dates2, tz = "GMT")
sample_dates2_lub

head(nfy1)

nfy1$Datetime <- paste(nfy1$Date, nfy1$Time, sep = " ")

head(nfy1)

nfy1$Datetime2 <- mdy_hms(nfy1$Datetime, tz = "America/Los_Angeles")
head(nfy1)

tz(nfy1$Datetime)
# weird even though it's a character column

tz(nfy1$Datetime2)
# it's a good idea to check what time zone R thinks your data are in


# Download the Mauna Loa Data

load("data/raw_data/mauna_loa_met_2001_minute.rda")


summary(mloa_2001)

names(mloa_2001)

# create a column with date time pushed together

mloa_2001$Datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

# Tell R this is a datetime column

mloa_2001$Datetime <- ymd_hm(mloa_2001$Datetime, tz = "Pacific/Honolulu")
tz(mloa_2001$Datetime)
















