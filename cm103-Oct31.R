library(purrr)
?map_dbl
?map
?lapply

# apply and purrr essentially does the same thing, apply function over the elements
# same as for loop but more efficient

# load packages
library(stringr)
str(fruit)

# task: use map function to split all the fruits that have 2 words

fruit %>%
  map(str_split, " ")

# map_chr(fruit, str_split, " ")

fruit %>%
  map_chr(str_to_upper)

# NEXTEXERCISE: load packages
install.packages("listviewer")
install.packages("repurrrsive")
library(repurrrsive)
library(listviewer)
library(purrr)

# [ ] you can use this to indx elements or to pull out items in a list
jsonedit(gh_users) # jsonedit to look interactively within a list

x <- map(gh_users, `[`, c("login", "name", "id", "location"))
x

y <- map(gh_users, magrittr::extract, c("login", "name") )
y


