# cm012 - October 12
# Exploring different type and class of objects in R

# load packages
# library(gapminder)
# library(tidyverse)

# typeof()
typeof(mean) # closure
typeof(1) # double
typeof("hello") # character
typeof(gapminder) # list
# x <- c(1:5) 
typeof(x) # integer
typeof(TRUE) # logical
typeof(lm) # closure
typeof(c) # buildin
# my_plot <- singer_locations %>%
#   ggplot(aes(x=year, y=duration))
typeof(my_plot)

# MATRIX
# all values within has to be the same type
# everything gets turned into a character if there is 1 character value
gap <- as.matrix(gapminder)
?matrix
my_mat <- matrix(c(1,2,3,4), nrow = 2, byrow = TRUE)
matrix(c(1,2,"a","b"), nrow = 2, byrow = TRUE) # this turns everything into character

# but data frames allows you to store different types of values within a row
# character, integers etc.
# but within a column HAS to be the same type!
# row, observation
# variables, column, feature

singerloc_year <- as.numeric(singer_locations$year)
singerloc_lat <- as.character(singer_locations$latitude)

# change column 1, row 7 from integer to numeric
# when you change 1 from one type to another, everything within gets changed to this new type
copy_of_sl <- singer_locations
copy_of_sl[1,8] <- as.character(copy_of_sl[1,8])
summary(copy_of_sl)
singer_locations[1,7] # integer
as.character(singer_locations[1,7])
as.numeric(singer_locations[1,7])

# [-1,]
# negative removes the row
# [,-1]
# this removes the column


# class is general categories, typeof is within class category.
class(mean) # function
class(1) # numeric
class("hello") # character
class(gapminder) #tbl_df, tbl, data frame
class(x) # integer
class(FALSE) # logical
class(lm) # function
class(c) # function 
class(my_plot)

# reading and writing files
?read_csv() # BETTER - guess type of column versus read.csv which does not
?read.csv()
# install.packages("readxl")
# to read excel files
write_csv

# FACTOR
glimpse(gapminder)
# some items within are factors <fctr>
str(gapminder$country)
# levels are in this case, Afghanistan, Albania.. etc.
# there could be more levels than observed countries

library(forcats) # for factors
# as_factor() within forecats

glimpse(singer_locations)
sl <- singer_locations %>%
  mutate(artist_name_factor = as_factor(artist_name)) # forcats packages
glimpse(sl)

sl <- sl %>%
  mutate(artist_name_factor_base = factor(artist_name)) # base r package

# What's the difference between using forcats and baseR?
x <- c("a", "b", "c")
as.factor(x) # keeps the order of the levels - BETTER/SAFER!
factor(x) # BASE R reorders the levels

sl %>%
  mutate(top_an = fct_lump(artist_name_factor, n = 10)) %>%
  count(top_an) %>%
  arrange(-n) # in descending order

sl %>%
  mutate(top_an = fct_lump(artist_name, n = 10)) %>%
  count(top_an) %>%
  arrange(-n) 

# summarize
summarize(mean_duration = mean(duration)) %>%
  ggplot(aes(x= artist_name, ...)) +
?fct_lump # does it have to be inputted as a factor?
?forcats

sl <-  sl %>%
  mutate(city_factor = ifelse(is.na(city), "Missing_information", city),
    city_factor = as_factor(city_factor))

sl %>%
  mutate(top_cities = fct_lump(top_cities, n =7)) %>%
  count(top_cities) %>%
  arrange(-n)

sl %>%
  mutate(top_cities = fct_lump(city, n =7)) %>%
  count(top_cities) %>%
  arrange(-n)

# forcats to clean up cities