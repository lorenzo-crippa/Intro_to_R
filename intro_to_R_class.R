######################################################################################################
# Course:                     Introduction to R                                                      #
#                                                                                                    #
# University:                 University of Essex                                                    #
#                             Essex Summer School in Social Science Data Analysis                    #
#                                                                                                    #
# File description:           Introduces R and its basic functions                                   #
#                                                                                                    #
# Instructor and programmer:  Lorenzo Crippa                                                         #
#                                                                                                    #
# Date:                       Sunday 12th July 2020,  12-4pm                                         #
######################################################################################################

################
# INTRODUCTION #
################

# print("hello world!")

# Welcome to R! This is a comment: whatever follows the symbol # will not be executed by R.
# You can (and should) use comments to document your code and make it understandable by other users
# and to avoid running lines of code that you don't want your program to run.

# Today we're going to:
# 1) learn how to create objects in R and learn about the most common types of R objects
# 2) learn how to import and manage databases
# 3) learn how to obtain summary stats and plots using base R
# 4) learn how to perform basic statistical analyses

# The first thing we should always do in our R project is to set up our working directory (wd),
# i.e. the folder on our computer where we are going to work from, where we store our data
# and where perhaps we might want to save our plots or the outputs from the analysis.
# In R we do it using the setwd() function:
setwd("/Users/Lorenzo/Documents/Università/University_of_Essex/Teaching/ESS/Introduction_to_R/2020")
# change that string with the one that corresponds to the location of your wd and run the code!
getwd()

################
# 1) R OBJECTS #
################

########################
# 1.1 Creating objects #
########################

# R is an object-oriented programming language. Object-oriented means that *everything* is an object.
# A number is an object, a dataset is an object, a plot is an object, a function too is an object.
# The environment in R can take multiple objects at the time.

# In R we make vast use of the <- operator to assign values to objects. 
# In RStudio you can obtain the operator quickly by typing the "alt" + "-" keys together.

# For instance:
a <- 2
# If you run this code ("ctrl" or "cmd" + "enter" to do it quickly) you'll see that you've assigned
# the value "2" to the object a. We can ask R to show us the content of an object:
a

b <- 5
a*b # the program returns the product of a and b, 10.
a+b
a-b

# notice this:
a + b == 8 # this is a statement, and it means: a + b equals 8. Is it 8? No! Then it's FALSE, or F
a + b != 8 # This is TRUE, or T

# you can perform operations by using objects or numbers:
2*5
2^4
a^b
2^b
2^(-b*a)
sqrt(2) # squared root of 2
sqrt(b)
sqrt(-b*a) # squared root of a negative number: it doesn't exist!

# and we can also ask for more complicated objects:
log(b) # the natural logarithm of b
log(b, base = 10) # logarithm of b, base 10
log(b+1) # natural logarithm of b+1
exp(a) # e^a

# of course you can store those results in objects
my.object <- exp(b)

# notice that you can also use the "=" to assign values to objects
a = 2*5 + sqrt(3) - pi
# yet, the "=" is also used to specify options and parameters in functions 
# (more on this below), so we prefer using the <- operator to assign values

# when you work in R you have three best friends:
# first, the help files and documentations for each function in each package.
# Whenever you're in doubt on a function, just type ? and your function to get help:
?exp()
# or simply look within the pdf that is associated with each package in CRAN.
# your other two best friends when working in R are Stack Overflow and Google. Trust me, they are.


########################
# 1.2 Types of objects #
########################

# There are many types of objects in R. Today we focus our attention on:
# 1) vectors
# 2) matrixes (2-dimensional vectors)
# 3) data frames
# 4) lists

# Objects in R also have different natures. Today we consider:
# 1) character
# 2) numeric (and integer)
# 3) factor
# 4) logical (boolean)

#################
# 1.2.1 vectors #
#################

# Vectors are one-dimensional objects that can have different lengths and can
# contain different values, but all of the same nature (all numeric, all characters, all logical...)
my.first.vector <- c(1, 5, 2, 6, 8, 9, 12, 2.4, 0.3, -2.56)
# the c() function stands for "concatenate" and is used to join objects together
my.first.vector

# how long is my vector?
length(my.first.vector) # it's a vector of length 10

# you can access the value of a specific element in your vector using squared brackets:
my.first.vector[8] # the value of the eighth element in our vector
my.first.vector[6]

# we can also decide to store string elements in our vector:
a.string.vector <- c("here", "are", "some", "elements")
a.string.vector

# paste() is a useful function to use with strings:
c <- "hello"
d <- "world"
paste(c, d)
paste(c, d, sep = ",") # specifies the separator of the two objects!
paste(1, 2)

# paste0() is a similar function, which by default puts no separator:
paste0(c, d)

# Notice this: you can't have different types of objects at the same time in a vector!
wrong <- c("this will not work", 2)
wrong # R has automatically turned our 2 into a string (a "2").

# our vector can also be a factor. This is used to create categorical variables 
# In this case we need to introduce the factor() function
category <- factor(x = c("a", "a", "a", "b", "b", "c", "c", "d"))
category
# we have created a categorical vector with four levels: a, b, c, d

# we can have logical vectors (or boolean), which can only take values TRUE or FALSE (1 or 0)
l <- c(T, F, F, T)
l <- c(TRUE, FALSE, FALSE, TRUE)
l

# notice that we can get the same result by doing the following:
l2 <- as.logical(c(1, 0, 0, 1))
c(1, 0, 0, 1)
l2
# notice what we have done: we've asked R to first create a numeric vector 1,0,0,1 using
# the c() function. Then we have applied to this vector the function as.logical(), which
# tries to turn its argument into a logical vector. 

# whenever we want to know what type of object is an r object we can do:
class(l2)
class(category)
class(a.string.vector)
class(my.first.vector)

##################
# 1.2.2 matrixes #
##################

# A matrix is a two-dimensional vector. Besides being two-dimensional, the same rules of vectors
# apply to matrix: a matrix can only contain data of the same type.
# Suppose we want a 3x4 matrix with numbers from 1 to 12 in its cells:  
m <- matrix(data = 1:12, # the data in our matrix. Pick all integers from 1 to 12 (included)
            nrow = 3, # the number of rows 
            ncol = 4, # the number of columns
            byrow = TRUE) # do we want data to be stored in cells by row or by column?
m

# we can access an individual element of a matrix in R by specifying its position:
m[2,4] # the object in the 2nd row, 4th column
m[,1] # all the first column
m[1,] # all the first row

# we can also give names to our columns and rows:
colnames(m) <- c("one", "two", "three", "four")
rownames(m) <- c("a", "b", "c")
m

# R can also perform matrix algebra:
m2 <- matrix(data = seq(from = -1, to = 0.1, by = 0.10), # seq() gives you a sequence
             nrow = 3)
m2

# matrix addition:
m + m2
m - m2

# multiplication by a scalar:
a * m
m * a

# matrix multiplication:
mat1 <- matrix(data = rep(4, times = 8), # rep() replicates the first argument (4) a number of times
               nrow = 4)
mat1

m %*% mat1

# you can also obtain the transpose of a matrix using the t() function:
t(m)

# and the inverse of a (square) matrix using the solve() function:
m <- matrix(data = c(9, 3, 6, -1, 2, 4, 5, 6, 4), nrow = 3)
m
solve(m)

# You can also have arrays, that are matrixes with more than 2 dimensions.
# You can think of them as matrixes stacked on top of each other, possibly
# in more than one dimension. This is not part of today's class yet

# look at our environment, on the right. Now we have quite some stuff in it and we
# might want to do some cleaning. The rm() function removes objects:
rm(a, b, a.string.vector)
# or maybe we want to remove everything:
rm(list = ls())

# it's always safest to start your R script clearing everything, so 
# that line of code should always be on top of your project.

#####################
# 1.2.3 data frames #
#####################

# They are perhaps the most common object you'll be dealing with in R.
# Most databases are imported automatically as data frames (df).
# They have multiple variables organized in columns, and each row represents one observation
# They look like the typical database you might have dealt with in STATA, SAS or SPSS

# Before importing one, let's create one from scratch and see how it looks like.

datafr <- data.frame(
  var1 = c(rep("a", 3), rep("b", 4), rep("c", 2), "d"),
  var2 = rnorm(n = 10, mean = 0, sd = 1.3), # here we are drawing 10 random values from a 
  # normal distribution with mean = 0 and sd = 1.3
  var3 = c(1, -4, 2, 4.2, 5.3333, 1/9, 7.5, 0.000, 1-12, sqrt(2)) # notice that here we are
  # creating a vector where the elements are expressions! We also include the squared root of 2
)

datafr <- data.frame(var1 = c(rep("a", 3), rep("b", 4), rep("c", 2), "d"), 
                     var2 = rnorm(n = 10, mean = 0, sd = 1.3), 
                     var3 = c(1, -4, 2, 4.2, 5.3333, 1/9, 7.5, 0.000, 1-12, sqrt(2))
                     )
datafr

# in the code above we draw random values from a normal distribution. We can easily draw 
# random values from many distributions in R. E.g.:
set.seed(123445789)
rbinom(n = 5, size = 10, prob = 0.4) # draw 5 random values from a binomial distrib with n = 10, p = .4
rnorm(n = 5, mean = 12, sd = 0.2) # draw 5 random values from a normal distr. with mean = 12, sd = 0.2
runif(n = 3, min = 0, max = 2) # draw 3 random values from a uniform distr. with min = 0, max = 2
rt(n = 12, df = 14) # draw 12 random values from a t-student distribution with 14 degrees of freedom
rf(n = 10, df1 = 5, df2 = 12) # 10 random values from an F distribution...
# ...etc

# each variable within our data frame is a vector, and the rules of vectors apply to them.
# all variables in a data frame must have the same length. But we might have variables with
# missing values. In R these missing values are called NA:
df <- data.frame(var1 = c(rep("a", 3), rep("b", 4), rep("c", 2), "d"),
                 var2 = c(1,2,3,4,5,NA,7,8,9,10))
df # we have a missing value in var2

class(datafr)

# we can access information in one column of our data frame using the $ operator:
datafr$var1 # this gives us precisely the object we want.
datafr$var3

class(datafr)
class(datafr$var1)
class(datafr$var2)
class(datafr$var3)

# we can then use these vectors to perform all operations as for other vectors.
datafr$var2 * 4

# for instance, we might want to see what is the value of the fifth element in the
# column "var3" of the data frame "datafr":
datafr$var3[5]
df$var2[6]
df$var2[2]

# we can also change values of course!
datafr$var3[4] <- 3.79812312

###############
# 1.2.4 lists #
###############

# Lists are the last object type that we briefly consider today. Lists are objects that include
# different other objects in R, of whatever type. A list can even contain another list.
ls <- list(df, datafr, datafr$var2)
ls

ls2 <- list(df, ls)
ls2

# etc.

# there are many functions that allow you to try to coerce the nature of an object:
# as.numeric() tries to coerce its argument into a numeric
# as.integer() tries to coerce its argument into an integer
# as.character() tries to coerce its argument into a character
# as.factor() tries to coerce its argument into a factor

# for instance you might want to coerce the variable var1 into a factor:
datafr$var1 <- as.factor(datafr$var1)

# and also its class!
# as.matrix()
# as.data.frame()
# as.array()
# as.list()

#################################
# 2) IMPORT AND MANAGE DATASETS #
#################################

#######################
# 2.1 Import datasets #
#######################

# now let's import databases from outside. We'll deal with different types of databases
# first things first: let's clean our environment before starting to deal with databases
rm(list = ls())
setwd("/Users/Lorenzo/Documents/Università/University_of_Essex/Teaching/ESS/Introduction_to_R/2020")
getwd()

# now import data from a csv file and save it in an object
baseball <- read.csv("baseball.csv")
class(baseball)
baseball <- read.csv("data/baseball.csv")

# we have imported this csv file on characteristics of US baseball players. It's automatically
# imported as a data frame. To see it you can type:
View(baseball) # or simply click on the data frame in your environment to the right ---->

# it's also good to take a look at our datasets by doing:
head(baseball) # shows the first 6 observations, all columns
str(baseball) # tells us what types of variables we have in our data frame

# as you can see we have a first column we don't really need.
# We can remove it by doing:
baseball$X <- NULL # great.

# before starting to do some analysis, let's see how to import data of other type.
# Suppose we have a dta file (STATA extension) to import. In this case, base R will
# not be able to import it. We need to install and load a package. We will make use
# of plenty of packages when working in R.
install.packages("haven") # haven is a good package to load data from STATA

# Now we have installed it. In order to use the package we need to tell R to load it:
library("haven") # now we can use it.

ANES <- read_dta("anesByState.dta")
View(ANES)

install.packages("readr")
library("readr")

# In case we wanted to import a database from Excel, the package we want to rely on is readxl
install.packages("readxl") # and its functions read_xls() and read_xlsx()
# then you should load it, of course, using: library("readxl")
library("readxl")

#######################
# 2.2 Manage datasets #
#######################

# Database management (dropping observations and vars, sorting our data, etc.) 
# can be done using base R. Nevertheless, we'll also use the dplyr package. dplyr is a very
# useful package that is part of tidyverse, a suite of R packages that are very important
# and that include the famous ggplot2 package for plotting in the grammar of graphics framework
install.packages("tidyverse")
library("tidyverse")
# but you can also load its packages individually:
library("dplyr")

# suppose now we want to drop from our baseball data all observations that refer to the CLE team
# (no offense to its fans). Doing it in base R would be:
baseball.no.CLE <- baseball[baseball$team != "CLE", ]
# which means: put in the object "baseball" the object "baseball" itself, but only the rows
# that have baseball$team different from "CLE". Keep all the columns.

# Suppose now we want to get rid of all observations that are not for New York Yankees (NYY) and also
# we want to drop the column "name". Yet, we don't want to overwrite the "baseball" object
# because we might need the information we're dropping later. We can do the following:
baseball.2 <- baseball[baseball$team == "NYY", 2:4]

# create a new object called "baseball.2" where we put the object "baseball", but only the
# rows that have baseball$team equal to NYY and the columns from the 2nd to the 4th.

# notice that the condition is imposed using ==, and not = (which is used to assign values)

# these operations are made smoother by dplyr's functions. Let's do something similar on ANES:
# Remove all observations from the year 2000, then remove the variable turnout:
ANES <- filter(ANES, # what is your data frame? 
               year != 2000) # the condition you impose
ANES <- select(ANES, 
               -turnout) # keep everything BUT the variable named "turnout"

# now suppose we want to sort observations in our ANES dataset based on state, then year.
# We can do it by:
ANES[order(ANES[,2], ANES[,1]),]
# by doing this we have taken ANES and we have asked R to reorder its rows first based on the
# second column (state), then by its first column (year). Notice that this time we have not
# saved the data frame obtained into an object!

# Another useful function is unique(). It tells us what values a vector takes:
unique(ANES$year) # all possible years in the ANES dataset

# we might want to have it sorted:
sort(unique(ANES$year)) # years from 1952 to 2008 by 2-year distance. 
# We don't have 2000 as we dropped it early on.

# ifelse() is a function that is very useful to know. If its "test" argument (a condition)
# is verified, it does what the "yes" argument says. Otherwise, it executes the "no" argument.
# For instance, in ANES we might want to have a variable that takes value 0 
# if the year is before 2000, and 1 otherwise. We can do it like this:
ANES$new.var <- ANES$poor^2
ANES$indicator <- ifelse(test = ANES$year >= 2000, yes = 1, no = 0)
unique(ANES$indicator)

##################################
# 3) GET SUMMARY STATS AND PLOTS #
##################################

##########################
# 3.1 Summary statistics #
##########################

# we now want to get some description of our data. The summary() function is our friend in this:
summary(ANES$poor) # description of a single variable...
summary(ANES) # ...and of an entire dataset
summary(ANES[,3:7])

# we can also ask for specific information:
mean(ANES$voteDem) 
sd(ANES$poor)
median(ANES$dem)
min(ANES$year)
max(ANES$voteDem)
quantile(ANES$poor, 0.3) # the observation that leaves 30% of the observations to its left
quantile(ANES$poor, 0.5) # this will be the median of course!
median(ANES$poor)
var(ANES$dem) # the variance
table(ANES$year) # how often does each occurrence appear?

# notice what happens here, though:
mean(ANES$FTM)
# we get an NA. This is because this variable has missing values. We need to explicitly tell
# R how to handle these missing data: we want to exclude them from the computation of the mean:
mean(ANES$FTM, na.rm = TRUE) # remove the NAs!

# we might want to ask R to give us summaries only for observations that satisfy conditions:
# for instance, give us the mean of FTM only when year is 2004:
mean(ANES$FTM[ANES$year == 2004], na.rm = T)

# or give us the mean of FTM when year is either 2004 or 2006 or 2008
mean(ANES$FTM[ANES$year == 2004 | ANES$year == 2006 | ANES$year == 2008], na.rm = T)

# or we might want to introduce an "and" condition. For instance, give us the mean of
# poor when the year is before 2000 and the observation of FTM is not missing
mean(ANES$poor[ANES$year < 2000 & is.na(ANES$FTM) == FALSE], na.rm = T)

# we might also need information on the covariance or correlation between our data:
cov(baseball$heightinches, baseball$weightpounds) # covariance
cor(baseball$heightinches, baseball$weightpounds) # correlation

# and we can also ask for an entire correlation matrix. 
# For instance the correlation of numeric variables in ANES,
#  but without the NAs that we know the variable FTM has
cor(ANES[is.na(ANES$FTM) == FALSE, 3:7]) # we do it this way because cor() has no na.rm option

# if we want to extract significance and pvalues of these correlations (pearson ans spearman tests)
# we can do:
cor.test(baseball$heightinches, baseball$weightpounds)
cor.test(ANES$white, ANES$voteDem)

# or we can use the Hmisc package to have an entire matrix:
install.packages("Hmisc")
library("Hmisc")
rcorr(as.matrix(ANES[, 3:7])) # it works on matrixes, so we need to turn our df into one!

# we can then save it in an object and extract p-values:
results <- rcorr(as.matrix(ANES[, 3:7]))
results$P
results$r
results$n
# it's the corresponding matrix of p-values relative to the test of 
# hypothesis that the true correlation between the two variables is 0

# we might also want to try the describe() function in the "psych" package for psychometric analysis:
install.packages("psych")
library("psych")
describe(baseball) 
# we get a bunch of warnings: we're trying to describe the distribution of two string variables!
# to fix it:
describe(baseball[,c(3,4)]) # describe all rows of data frame "baseball", but only for columns 3 and 4
?describe # here you get a number of different options you might find interesting:

describe(baseball[,c(3,4)], skew = FALSE, IQR = TRUE, ranges = FALSE)

###################
# 3.2 Basic plots #
###################

# we now want to obtain some plots about our data. We'll see how to:
# 1) obtain boxplots
# 2) obtain histograms
# 3) obtain density plots
# 4) obtain twoway plots

##################
# 3.2.1 boxplots #
##################

# to obtain it we simply run:
boxplot(ANES$white)

# we can then intervene on options and modify its appearance:
boxplot(ANES$white, frame = F, ylab = "white", main = "A boxplot")

# what if we wanted to show the distribution of a variable in separate boxplots according to
# another variable? For instance we might want to plot distributions of heights of baseball
# players for the teams "BAL", "NYY", "SEA", "WAS", "PHI", "NYM", "TEX":
library("dplyr")
selection <- dplyr::filter(baseball, team == "BAL" | team == "NYY" | team == "SEA" |
                             team == "WAS" | team == "PHI" | team == "NYM" | team == "TEX")
boxplot(selection$heightinches ~ selection$team, # plot height by team
        frame = F, ylab = "height", xlab = "team", main = "Boxplot of height distributions")

####################
# 3.2.2 histograms #
####################

# plotting histograms is also very easy and similar to obtaining boxplots:
hist(ANES$FTM, main = "Histogram of FTM", xlab = "FTM")

# and we can also intervene in the plot with options:
hist(ANES$FTM, main = "Histogram of FTM", xlab = "FTM", probability = TRUE) # to have probabilities
?hist

#######################
# 3.2.3 density plots #
#######################

# we can also obtain kernel densities of our data:
density(ANES$dem) # this function takes our data as input and computes the kernel density

# to plot it:
plot(density(ANES$dem))

# again, we can work on its options:
plot(density(ANES$dem, kernel = "epanechnikov"),
     frame = FALSE, main = "Kernel density (Epanechnikov)")
?density

######################
# 3.2.4 twoway plots #
######################

# Suppose now we want to explore two-way relations in our data.
# for instance the two-way relation between height and weight of baseball players:
plot(x = baseball$heightinches, y = baseball$weightpounds,
     frame.plot = FALSE, xlab = "height", ylab = "weight",
     pch = 20) # pch is an option that selects the shape of dots we want 

# what if we want to add lines on this plot? We use the abline() function
# Maybe we want to plot a line corresponding to the mean height 
abline(v = mean(baseball$heightinches, na.rm = TRUE), col = "red", lwd = 5) # lwd makes it thicker

# Maybe we want to add a regression line to the plot...
abline(lm(weightpounds ~ heightinches, data = baseball), col = "green")
# ... but more on this in a bit!

# suppose now we want to save this plot. We simply do:
pdf("my_first_plot.pdf") # this creates a pdf file in which we put the following:
plot(x = baseball$heightinches, y = baseball$weightpounds, frame.plot = FALSE, 
     xlab = "height", ylab = "weight", pch = 20)
abline(v = mean(baseball$heightinches, na.rm = TRUE), col = "red", lwd = 2)
abline(lm(weightpounds ~ heightinches, data = baseball))
dev.off() # this closes and saves the pdf file.

# what if we wanted to limit our plot to a certain range of the x (or y) axis?
plot(x = baseball$heightinches, y = baseball$weightpounds, frame.plot = FALSE, 
     xlab = "height", ylab = "weight", pch = 20,
     xlim = c(60,75))

# more complex and sophisticated plots can be obtained in R by using the ggplot2 package.
# This is not part of today's overview, but for those of you who were interested in that
# I can recommend the "Use R!" book from Hadley Wickham, titled 
# "ggplot2: Elegant Graphics for Data Analysis", published by Springer.

#####################################
# 4) RUN BASIC STATISTICAL ANALYSES #
#####################################

###############
# 4.1 T-tests #
###############

# suppose you want to run a test to see if the population mean 
# of a random variable is distinguishable from 0 based on your data:
t.test(ANES$poor) # by defaul it's a two-tailed t-test with null-value = 0

# you can also test if the true value is equal to other values...
t.test(ANES$FTM, mu = 60)

# ...you can ask for a specific level for your confidence interval...
t.test(ANES$FTM, mu = 60, conf.level = .90)

# ...and you can ask the test be one-sided:
t.test(ANES$FTM, mu = 60, conf.level = .90, alternative = "less")
t.test(ANES$FTM, mu = 60, conf.level = .90, alternative = "greater")

# you can also run difference-in-means tests.
# Suppose you want to test if the mean height of players in the NYY team 
# is different from the mean height of players in the MIN team:
t.test(x = baseball$heightinches[baseball$team == "NYY"],
       y = baseball$heightinches[baseball$team == "MIN"])
# they are! Players in the Yankees are taller on average.

##########################
# 4.2 Statistical models #
##########################

#######################
# 4.2.1 linear models #
#######################

# suppose now we want to estimate a linear model using OLS. 
# To do that we first import a dataset from an article by David Card (1993) on NBER:
card <- read_dta("Card_data.dta")
head(card)

# suppose we might want to know if years of experience are a significant determinant of wage.
plot(x = card$exper, y = card$wage, xlab = "experience", ylab = "wage", pch = 20, frame.plot = F)
# there doesn't seem to be much of a relation going on here. 
# But maybe controlling for confounders we can get something out of it

# We might check it with a linear model:
model1 <- lm(wage ~ exper, # your formula
             data = card) # where are the data stored
summary(model1)

# we probably would want to include some control variables to this model:
model2 <- lm(wage ~ exper + motheduc + fatheduc,
             data = card)
summary(model2)

# we probably would prefer to model the log of wage, to have a less-skewed distribution:
model3 <- lm(log(wage) ~ exper + motheduc + fatheduc,
             data = card)
summary(model3)

# and maybe we also want to include a squared value of years of experience:
# the effect of experience on wage might be non-linear
model4 <- lm(log(wage) ~ exper + I(exper^2) + motheduc + fatheduc,
             data = card)
summary(model4)

# and maybe we also want to control for socio-economic features:
model5 <- lm(log(wage) ~ exper + I(exper^2) + motheduc + fatheduc +
               smsa + south + black + enroll,
             data = card)
summary(model5)

# alternatively, maybe the effect of experience on wage is non-linear because it
# depends on the interaction with living in a city, not on the squared value
model6 <- lm(log(wage) ~ exper*smsa + motheduc + fatheduc +
               south + black + enroll,
             data = card)
summary(model6)

# maybe then we want to show our results. There are some very good packages to produce
# neat regression tables out there. The choice between them depends mostly on the type
# of models that they can support. Two equally good choices are stargazer and texreg:
install.packages(c("stargazer", "texreg"))
library("stargazer")
library("texreg")

# let's see how their functions work
stargazer(model3, model4, model5, model6, type = "text",
          keep.stat = c("n", "rsq", "adj.rsq", "f"), df = FALSE,
          order = c("exper", "smsa"),
          out = "my_table.docx")
stargazer(model3, model4, model5, model6, type = "latex",
          keep.stat = c("n", "rsq", "adj.rsq", "f"), df = FALSE,
          order = c("exper", "smsa"))
?stargazer
stargazer(model3, model4, model5, model6, type = "html",
          keep.stat = c("n", "rsq", "adj.rsq", "f"), df = FALSE,
          order = c("exper", "smsa"),
          out = "my_regression_table.txt")


screenreg(list(model3, model4, model5, model6),
          stars = c(0.01, 0.05, 0.1))

screenreg(list(model3, model4, model5, model6),
          stars = c(0.01, 0.05, 0.1),
          reorder.coef = c(2, 5, 10, 6, 3, 4, 7, 8, 9, 1))
texreg(list(model3, model4, model5, model6),
       stars = c(0.01, 0.05, 0.1),
       reorder.coef = c(2, 5, 10, 6, 3, 4, 7, 8, 9, 1))

# we can also extract statistics and information from our model objects:
model5$coefficients
model5$residuals
fit <- model5$fitted.values

# and more:
summary(model5)$coefficients[,1] # these are the coefficients (the betas)
summary(model5)$coefficients[,2] # these are the standard errors of our coefficients
summary(model5)$coefficients[,3] # these are the t-statistics
summary(model5)$coefficients[,4] # these are the p-values
# of course we could save this information in R objects

# if we want to obtain predictions from our model, together with confidence intervals,
# the predict() function is our friend:
prediction <- as.data.frame(predict(model1, interval = "confidence"))
?predict

# those of you who needed to obtain robust or clustered standard errors will definitely
# need the package sandwich, which contains functions like vcovHC() and vcovCL() that compute
# variance-covariance matrixes to obtain standard errors that are robust 
# to heteroskedasticity or clustered at some data level. But enough on that for today. 

###################################
# 4.2.2 generalized linear models #
###################################

# Most statistical models in R have a syntax very similar to the one adopted by lm().
# Covering these models is not part of today's class, but we might want to show
# that other models, such as those in the family of the generalized linear model (GLM),
# work very similarly. Suppose we want to explain if a person went to college based on the
# years of education of the father and mother. A logit or probit model would be appropriate:

mod.glm <- glm(enroll ~ fatheduc + motheduc +
                 black + smsa + south + IQ,
               data = card,
               family = binomial(link = "logit"))
summary(mod.glm)

###############
### THE END ###
###############