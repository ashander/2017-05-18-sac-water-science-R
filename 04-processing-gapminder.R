library(dplyr)

gapminder <- read.csv('data/gapminder-FiveYearData.csv',
                      stringsAsFactors=FALSE)

# how to get mean gdp per country?
gapminder$continent
str(gapminder[gapminder$continent == "Asia", ])
asia_only <- gapminder[gapminder$continent == "Asia", ]

#recall / see a few ways to get out the gdppercap
#str(  gapminder[1, ]$gdpPercap)
#str(gapminder[1, "gdpPercap"])
mean(asia_only$gdpPercap)
# to find for all continents we'd need to reapeat
afr_only <- gapminder[gapminder$continent == "Africa", ]
mean(afr_only$gdpPercap)


# isn't there a better way?

# yes, dplyr
str(filter(gapminder, continent == "Asia"))

# in fact plyr provides several useful 'verbs' to manipulate
# data

# select
year_country_gdp <- select(gapminder, year, 
                           country, gdpPercap)

year_country_gdp_piped <- gapminder %>%
  select(year, country, gdpPercap)
# if we don't store, it's printed
gapminder %>%
  select(year, country, gdpPercap)

# quick challenge
# pipe gapminder into select and select year

# now we stack up these commands, piping the output
# of one into the other
year_country_gdp_euro <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)
# NOTE: order matters!  
  
# Challenge: hint use str

# new 'verb': group_by / summarize
# this will solve our problem of taking
# means across all categories

# group by makes a 'tibble' that prints
str(gapminder %>% group_by())
# undo with %>% data.frame()

gapminder %>% group_by(continent)
str(gapminder %>% group_by(continent))

# next new verb! summarize / summarise
gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdp_pc = mean(gdpPercap),
            median_gdp_pc=median(gdpPercap))

lifeExp_bycountry <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp=mean(lifeExp))

# finding both min and max requires the 
# 'or', which is | in R
lifeExp_bycountry %>% 
  filter(mean_lifeExp == max(mean_lifeExp))


# counting obs and
# helper funcitons for summarize
gapminder %>%
  filter(year == 2002) %>%
  count(continent, sort=TRUE)

# if we want to actually USE the count
# in summarize, we can't use `count` need
gapminder %>%
  group_by(continent) %>%
  summarize(SE_le = sd(lifeExp) / n())

# one last verb! mutate
# how we can actually ADD NEW data
gapminder %>% 
  mutate(total_gdp=gdpPercap * pop) %>%
  group_by(country) %>%
  select(country, year, total_gdp) %>%
  summarize(mean_total = mean(total_gdp))


# what if our data is the wrong shape?
# 'tidyr' to the rescue
gap_wide <- read.csv('data/gapminder_wide.csv')
library(tidyr)
# see slides for wide vs long
# tidyr 'verbs' can be used to move between
# wide and long
# here we go from wide to long
gap_long <- gap_wide %>%
  group_by(country, continent) %>%
  # like dplyr, tidyr can be put in
  # a chain of pipes
  # see help('gather'): the first two arguments
  # are the name of the new columns
  # the next arguments specify which columns NOT
  # to include
  gather(obs_name, obs_value, -1, -2)
gap_long

# this switches to a long format (though some
# data (the year of observation) is still
# stuck in the `obs_name`
