# cm011 - October 11
# working again with gather, spread, reshape2::dcast
# exploring errors/exceptions when this doesn't work
# let's talk objects and terminology in r 

library(tidyverse)
library(singer)
data("singer_locations")
View(singer_locations)

# artist_hottness, artist_familiarity, duration

hfd_y <- singer_locations %>%
  select(year, duration:artist_familiarity) %>%
  gather(key = "Measures", value = "My_values",
         duration:artist_familiarity)

plot <- hfd_y %>%
  filter(year > 1950) %>%
  ggplot(aes(x=year, y = My_values)) +
  geom_point() +
  facet_wrap(~ Measures, scales = "free_y") # free the y axis or "free" for x and y axis

# Bring hfd_y into the wide format
hfd_y %>%
  spread(key = Measures, value = My_values)
# you get an error because there are duplicate rows 
# ex; in 2008, there are multiple artist hotttnesss scores

hfd_y_2 <- singer_locations %>%
  select(year, artist_id, song_id, duration:artist_familiarity) %>%
  gather(key = "Measures", value = "My_values",
        duration:artist_familiarity, -c(song_id, artist_id))

# NOTE TO SELF: SPREAD NEVER GOES WITH -C
# -C ONLY WORKS IN GATHER WHICH MEANS KEEP IT WITHIN DATA FRAME BUT DO NOT GATHER IT
# IT IS ASSUME WHATEVER IS NOT UNDER KEY OR VALUE STAYS AS IS, UNIQUE KEY
hfd_y_2 %>%
  spread(key = Measures, value = My_values, -c(year, artist_id, song_id))

hfd_y_2 %>%
  spread(Measures, My_values)

# reshape tool
install.packages("reshape2")
library(reshape2)
# resource: http://seananderson.ca/2013/10/19/reshape.html

# function aggregate could be sum, vars
hfd_y_2 %>%
  dcast(year ~ Measures, # keep year as unique, spread out Measures across columns
        value.var = "My_values", # fill it with the values from this column
        fun.aggregate = mean, na.rm = TRUE) 
# because there are multiple non-unique, we place only the mean
# aka 1 unique value per year per measures column

hfd_y_2 %>%
  dcast(year ~ Measures,
        value.var = "My_values",
        fun.aggregate = var, na.rm = TRUE)
# variance gives us NA because only 1 value that matches this cell (year, artist familiarity)
# or you could use group_by and summarize

##############################################################
# Type of objects in R
# data frames, functions, characters...etc.

typeof(hfd_y_2) # low level
class(hfd_y_2)  # higher level

typeof("hello")
class("hello") # could be the same type and class if lower level

typeof(4)
class(4) # numeric or double

typeof(5L) # L signifies that 5 is an integer
class(5L)

# What's the difference between numeric and integer?
# integers are a class within numeric that are to the whole number
# you can add a L after a number to ensure it is a whole number

class(plot) # ggplot
typeof(plot) # list

class(`%>%`) # function
typeof(`%>%`) # closure

class(`<-`) # function
typeof(`<-`) # special

y <- 1:14
y[2]
y
# [[what are double brackets]]