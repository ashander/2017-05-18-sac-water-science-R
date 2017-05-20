# getting help
# ? works when you know the funciton name
# ??
# help(package='ggplot2') for all functions in a package

# seeing a vignette -- long form help
vignette(package='ggplot2')  #gives names of vignettes
vignette('extending-ggplot2') # look at the actual vignette

# what if r help doesn't help?
mtcars # my data
dput(mtcars) # puts out incomprehenisble R code
# structure(list(mpg = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3, 
# 4.4, 22.8, 19. 
# that you can copy-paste into a text input box or provide as an attachment

# what tools and versions am I using?
sessionInfo() # copy paste into your email or online help forum
