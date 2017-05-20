# load data --- i externally edited to create the data
cats <- read.csv('data/feline-data.csv')

# quick challenge: do this with gapminder data
# stored in gapminder-FiveYearData.csv
data <- read.csv('data/gapminder-FiveYearData.csv')


# manipulate and view data
cats$weight
## transform the weight
cats$weight * 2.2
# working with paste, 'vector recycling' means
# we don't have to type out start and end of 
# sentence more than once
paste("I have a", cats$coat, "cat")
# this is an example of R's ability to work on
# vectors and do multiple operations in a simple way

# inspecting data
typeof(cats$weight)
typeof(cats$likes_string)
typeof(cats$coat)
typeof('banana')

## this is hard can't we do something quicker
# see what's in the dataframe use the `string`ture
str(cats)

## determine the data types in gap minder 
# using str
str(data)

# deeper into vectors
combined_vector <- c(2, 6, 3)
combined_vector

# jargon for when we combine different data
# types is 'type coercion'
what_kind_of_vector <- c(2, 6, "3")

# new operator (?) integer
typeof(1L)
typeof(1)
ivec <- c(1L, 2L)
# 
mixedvec <- c(1L, 2L, 3)

## more vectors


# data frames

## manipulating /adding data
cats$sample <- c(1, 1, 1)


