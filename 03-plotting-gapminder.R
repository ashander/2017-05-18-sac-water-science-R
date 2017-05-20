library(ggplot2)

# quick challenge: do this with gapminder data
# stored in gapminder-FiveYearData.csv
gapminder <- read.csv('data/gapminder-FiveYearData.csv',
                      stringsAsFactors = FALSE)

# recall: what's in here?
str(gapminder)

# basics of ggplot2
# quick reminder
# help(package='ggplot2')

# first plot
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point()

# first, we need to tell ggplot where to find our data
# ggplot(gapminder)
# alone this creates a blank canvas. next wee

# next we need to tell ggplot what 
# to put on on the plot
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point()


ggplot(gapminder,
       aes(x=year, y=lifeExp, color=continent)) +
  geom_point()

## other geoms: showing trends over time

ggplot(gapminder,
       aes(x=year, y=lifeExp, color=continent,
           by=country)) +
  geom_line()

# what about more complex plots? use layers
ggplot(gapminder,
       aes(x=year, y=lifeExp))  +
  geom_point() +
  geom_line(aes(by=country, color=continent)) 


# alright. what else can we do?
# how can we make plots easier to read?
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp,
                      color=continent)) +
  geom_point(size=1, alpha=0.5) +
  scale_x_log10()

# what if we want to visualize a trend?
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point(aes(color=continent),
             size=1, alpha=0.5, shape=5) +
  scale_x_log10() +
  geom_smooth(aes(color=continent), 
              method="lm", size=1)

# what if we want lots of similar plots for different
# countries, say?
#gapminder[1, ] give sone row
# gives countries that start with A, Z
start_with <- substr(gapminder$country, 
                      start = 1, stop = 1)
az_countries <- gapminder[start_with %in% c("A", "Z"), ]

## lets use az_countries and faceting
# finally we probably want different labels
ggplot(az_countries,
       aes(x=year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap(~ country) +
  labs(x="Year", y="Life expectancy", 
       title="Trends in life expectancy",
       subtitle="for countries starting with A or Z",
       caption="data from gapminder.org")
## Challenge!
# add a title, caption saying who made the plot, 
# and change labels for one of your plots


# saving plots!
# can do ggsave("My_most_recent_plot.pdf") ---
# -- which has more flexible optoins too see below
# or Export form Rstudio
# but lets use the standard way in R
pdf("plots/Life_exp_vs_time.pdf", width=8, height=4)
ggplot(data=gapminder, aes(x=year, y=lifeExp, 
                           color=continent, by=country)) + 
  geom_line()
# then must turn off device
dev.off()

pdf("plots/Life_exp_vs_time_forAZ_countries.pdf", width=12, height=6)
ggplot(az_countries,
       aes(x=year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap(~ country) +
  labs(x="Year", y="Life expectancy", 
       title="Trends in life expectancy",
       subtitle="for countries starting with A or Z",
       caption="data from gapminder.org")
dev.off()

# challenge: save the plot you made earlier into the
# plots/ folder of your project. (make 'plots')

# bonus: back to ggsave and saving plots objects
# if we save our ggplot to the variable myplot
# then we can use ggsave in a more flexible way
myplot <- ggplot(az_countries,
       aes(x=year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap(~ country) +
  labs(x="Year", y="Life expectancy", 
       title="Trends in life expectancy",
       subtitle="for countries starting with A or Z",
       caption="data from gapminder.org")
myplot
ggsave("plots/Life_exp_vs_time_forAZ_countries.png",
       myplot, width=10, height=5, dpi = 600)

# how do we save our new data?
az_countries
str(az_countries)
write.table(az_countries,
            file="processed-data/gapminder-az-countries.csv",
            sep=",",
            row.names=FALSE
            )
## Challenge! write the az_countries data
# or the gapminder data to a new folder
# in your project. hint: check that it didn't include
# row.names!! hint: use row.names=FALSE in
# write.table
