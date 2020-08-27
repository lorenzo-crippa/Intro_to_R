######################################################################################################
# Course:                     Introduction to R                                                      #
#                                                                                                    #
# University:                 University of Essex                                                    #
#                             Essex Summer School in Social Science Data Analysis                    #
#                                                                                                    #
# File description:           Extra topic: Introduces qplot() function from ggplot2                  #
#                                                                                                    #
# Instructor and programmer:  Lorenzo Crippa                                                         #
#                                                                                                    #
# Date:                       Sunday 12th July 2020,  12-4pm                                         #
######################################################################################################

rm(list=ls())

library("ggplot2")

# set working directory
setwd("/Users/Lorenzo/Documents/Università/University_of_Essex/Teaching/ESS/Introduction_to_R/2020")

# now we learn to use qplot(), which is the quick plot function of 
# ggplot2 (similar to basic R's plot() function), and which does not fully exploit
# ggplot2's grammar of the graphics (gg) and functionalities (although being based on gg).
# qplot() is based on the ggplot() function, which truly unleashes ggplot2's functionalities
# at their full. But it's best to start from this.

# the code is largely drawn from chapter 2 of the "Use R!" book from Hadley Wickham,  
# titled "ggplot2: Elegant Graphics for Data Analysis", published by Springer.

# import data.
diamonds <- read.csv("diamonds.csv")

#######################################################################################
# 1) SCATTERPLOTS

# let's see how a scatterplot works. For instance, in the data frame "diamonds"
# we might want to plot a scatter with, on the x axis, carats and, 
# on the y axis, price:

qplot(x = carat, y = price, data = diamonds,
      xlab = "Carat",
      ylab = "Price",
      main = "Scatterplot"
)

# we can transform variables directly in the function:
qplot(x = carat, y = log(price), data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
)

# qplot also supports combinations of the arguments! For instance we might be interested
# in the relation between the ratio carat/depth and the price (logged):
qplot(x = carat/depth, y = log(price), data = diamonds,
      xlab = "Carat / depth",
      ylab = "Price (log)",
      main = "Scatterplot"
)

#######################################################################################
# 2) GRAPHICAL DATA CATEGORIZATION

# Now we want to differentiate colors in these graphs, to
# differentiate observations belonging to different groups.
# The "categorizations" we use below are examples of what is called
# "aesthetic attributes" in ggplot2's grammar of the graphics.

# for instance: color of the diamond
qplot(x = carat, y = log(price), col = color, data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
) + labs(col = 'Diamond color') # this tells qplot() to change the name of the legend variable


# or maybe we want to change shape of the dot according to the cut:
qplot(x = carat, y = log(price), shape = cut, data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
) + labs(shape = 'Diamond cut')

# you might even want to color your dots according to a continuous variable.
# For instance, the depth of a diamond:
qplot(x = carat, y = log(price), col = depth, data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
)

# or you might want to combine shape and color mapping:
qplot(x = carat, y = log(price), col = color, shape = cut, data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
)

# let's go back to our plots before categorization:
qplot(x = carat, y = log(price), data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
)
# here there is much overplotting. We can use the alpha() function to avoid it 
# and make semi-transparent points. The alpha function takes a value between 0 
# (completely transparent) and 1 (completely opaque)
qplot(x = carat, y = log(price), data = diamonds,
      alpha = I(.2),
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
)

# then you can color these dots of course:
qplot(x = carat, y = log(price), data = diamonds,
      alpha = I(.4), col = color,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot"
)

#######################################################################################
# 3) SMOOTH LINES

# now we move to other types of graphs, not only scatterplot. In grammar of the graphics
# x, y, shape, colors are *aesthetics* of a graph. The *type* of a graph is called "geom"
# in the grammar of the graphics. Obviously geom is short for "geometry". 
# By default, qplot() plots a scatterplot when geom is absent. Now we specify it instead

# examples of geom are:
# 1) geom = "point" -> a scatterplot
# 2) geom = "smooth" -> fits a smoother line and its standard error
# 3) geom = "boxplot" -> boxplot
# 4) geom = "path" and "line" -> they draw lines between data points. They are used
#           to explore time relations among data
# NB: a "line" plot is constrained to build lines that go left to right
# 5) geom = "histogram" -> draws a histogram
# 6) geom = "freqpoly" -> draws a frequency polygon
# 7) geom = "density" -> draws a density plot
# 8) geom = "bar" -> makes a bar chart for *discrete* variables

# if you supply only x (and not y), qplot() cannot make a scatterplot, 
# therefore the default plot will be a histogram.

# let's first add a smooth line to our scatterplots:
qplot(x = carat, y = log(price), data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot and Smooth",
      geom = c("point", "smooth")
) # by default this is a smooth line estimated with gam method. 

# For a linear model, instead:
qplot(x = carat, y = log(price), data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot and Smooth",
      geom = c("point", "smooth"),
      method = "lm"
) 

# notice that this goes way above our points! We can restrict the plot by doing:
qplot(x = carat, y = log(price), data = diamonds,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot and Smooth",
      geom = c("point", "smooth"),
      method = "lm",
      ylim = c(5, 10) # limit the plot to 5-10 interval
)


#######################################################################################
# 4) BOXPLOT AND JITTERINGS

# Now, boxplots and jitter graphs!

# a simple use of boxplot might be:
qplot(y = log(price), data = diamonds,
      fill = I("grey"), # this is for purely aesthetical reasons
      ylab = "Price (log)",
      main = "Boxplot",
      geom = "boxplot")

# a more interesting solution is to map by classes:
qplot(y = log(price), data = diamonds,
      x = cut,
      fill = I("grey"),
      ylab = "Price (log)",
      xlab = "Cut",
      main = "Boxplot",
      geom = "boxplot")

# or by color:
qplot(y = log(price), data = diamonds,
      x = color,
      fill = I("grey"),
      ylab = "Price (log)",
      xlab = "Color",
      main = "Boxplot",
      geom = "boxplot")

# we can also use jittering:
qplot(y = log(price), data = diamonds,
      x = color,
      alpha = I(.05),
      ylab = "Price (log)",
      xlab = "Color",
      main = "Jittering",
      geom = "jitter")

# and even map these dots by a third variable:
qplot(y = log(price), data = diamonds,
      x = color,
      col = cut,
      alpha = I(.1),
      ylab = "Price (log)",
      xlab = "Color",
      main = "Jittering",
      geom = "jitter")

# boxplot vs jittering: they have strengths and weaknesses.
# Boxplot is very much capable of summarizing distributions: with only few
# parameters (mean, std deviations, outliers, quantiles) it describes how data
# are distributed. Jittering cannot synthesize a distribution that nicely,
# but it can provide other information such as where data tend to cluster
# (and that's the reason why you have overplotting). Boxplot cannot do it!

#######################################################################################
# 5) HISTOGRAMS AND DENSITY GRAPHS

# Now, histograms and density graphs

# histograms is used for *CONTINUOUS* variables
qplot(x = log(price), data = diamonds,
      fill = I("grey"), # change color if you don't want them grey
      xlab = "Price (log)",
      main = "Histogram",
      geom = "histogram") # default number of bins is 30

# try with a different binwidth. This affects the number of bins!
qplot(x = log(price), data = diamonds,
      fill = I("grey"), 
      binwidth = 0.01,
      xlab = "Price (log)",
      main = "Histogram",
      geom = "histogram")

# notice:
qplot(x = log(price), data = diamonds,
      fill = I("grey"), 
      binwidth = 0.01,
      ..density.., # this tells qplot() to use densities instead of counts on the y axis
      xlab = "Price (log)",
      main = "Histogram",
      geom = "histogram")


# We can use aesthetics, again, to get more information:
qplot(x = log(price), data = diamonds,
      fill = color, 
      xlab = "Price (log)",
      main = "Histogram",
      geom = "histogram")
# When we do it with histograms in qplot(), representation is by default stacked, cumulative.
# with ggplot() we can also change that and put bins mapped to different levels aside

# we can also do density plots:
qplot(x = log(price), data = diamonds,
      xlab = "Price (log)",
      main = "Density plot",
      geom = "density")

# and we can map data of course:
qplot(x = log(price), data = diamonds,
      col = clarity, 
      xlab = "Price (log)",
      main = "Density plot",
      geom = "density")
# this is one possibility, or we can do:
qplot(x = log(price), data = diamonds,
      fill = clarity, alpha = I(.1),
      xlab = "Price (log)",
      main = "Density plot",
      geom = "density")

# NB: density plots are more appealing but make assumptions about our data
#     while histograms do *NOT* (for instance, that data are unbounded,
#     continuous and smooth: this might not be the case!)

#######################################################################################
# 6) BAR CHARTS

# We briefly move to barcharts with the geom = "bar"
# Barcharts are the discrete analogue of histograms.
# NB: The bar geom counts the number of instances of each class so that you don’t need 
#     to tabulate your values beforehand, as with barchart in base R

# for instance: how many occurrences for each color type of diamond?
qplot(x = color, data = diamonds,
      xlab = "Color",
      main = "Bar plot",
      geom = "bar")

# how many for each cut?
qplot(x = cut, data = diamonds,
      xlab = "Cut",
      main = "Bar plot",
      geom = "bar")

# etc.

#######################################################################################
# 7) FACETING

# Faceting is a nice alternative to have the aesthetics plotted on the *same* graph.
# Suppose you want to have data divided by some type of grouping, but on different graphs.
# You can do:
qplot(x = log(price), data = diamonds,
      facets = color ~ ., # this creates a single column of graph with many rows. Why is it
      # so? Because it is rows ~ columns. If columns = . (as it is here)
      # then the faceting will be as such
      xlab = "Price (log)",
      main = "Histograms",
      geom = "histogram")

# you can combine faceting with other types of aesthetics:
qplot(x = log(price), data = diamonds,
      facets = color ~ ., 
      fill = cut,
      xlab = "Price (log)",
      main = "Histograms",
      geom = "histogram")

# or with scatterplots:
qplot(y = log(price), x = carat, data = diamonds,
      facets = color ~ ., 
      col = cut,
      xlab = "Carat",
      ylab = "Price (log)",
      main = "Scatterplot",
      geom = "point")

# you can also have faceting organized in a matrix of rows and columns:
qplot(x = log(price), data = diamonds,
      facets = color ~ cut, 
      xlab = "Price (log)",
      main = "Histograms",
      geom = "histogram")
# to save a plot, finally:
ggsave("my_ggplot.pdf", device = "pdf")

###########
# THE END #
###########