# Course:                     Introduction to R
# University:                 University of Essex
#                             Essex Summer School in Social Science Data Analysis
# File description:           Runs exercises to practice with R tools
# Instructor and programmer:  Lorenzo Crippa
# Date:                       Sunday 11th July 2021,  12-6pm

# clear the environment
rm(list = ls())

# set working directory (change path using the location of your working directory)
setwd("/Users/Lorenzo/Documents/GitHub/Intro_to_R/2021")
library("tidyverse")

# 1) R DATA TYPES AND OBJECTS, IMPORT AND MANAGE DATASETS ----
# When possible, run exercises 1-5 using base R and tidyverse

# Exercise 1 ----
# 1) a. generate a string vector whose elements are the words of this sentence
string <- c("generate", "a", "string", "vector", "whose", "elements", 
            "are", "the", "words", "of", "this", "sentence")

#    b. generate a numeric vector whose elements are all numbers from 1 to 20 at a distance of 0.5
my.sequence <- seq(from = 1, to = 20, by = 0.5)

#    c. generate a numeric vector that is the sequence from 1 to 20 at a distance of 1
int.sequence <- 1:20
seq(from = 1, to = 20, by = 1)

#    d. turn the previous vector into a binary one: it takes value 1 if it is below 15, 0 otherwise
binary.vector <- ifelse(test = int.sequence <= 15, yes = 1, no = 0)
binary.vector

binary.vector.alt <- ifelse(test = int.sequence >= 11 & int.sequence <= 14,
                            yes = NA, no = 0)
binary.vector.alt <- case_when(int.sequence >= 11 & int.sequence <= 14 ~ NA,
                               TRUE ~ 0)
binary.vector.alt

#    e. turn the binary vector into a logical one (boolean). Store it into a new vector, though
new.vector <- as.logical(binary.vector)
new.vector

#    f. generate a numeric vector that replicates 1 5 times, 2 4 times, 3 3 times, 4 2 times, 5 1 time
num.vector <- c(rep(1, 5), rep(2, 4), rep(3, 3), rep(4, 2), 5)
num.vector

# Exercise 2 ----
# 2) a. take vectors from point 1) d. and 1) f. and combine them into a 5x7 matrix. 
#       Arrange elements by column.
?matrix
mat <- matrix(data = c(binary.vector, num.vector),
              nrow = 5, ncol = 7, byrow = FALSE)
mat
#    b. compute the sum of each row of the matrix

# Exercise 3 ----
# Import the "diamonds.csv" dataset into your R session.
diamonds <- read.csv("diamonds.csv")

# 3) add some variables to the data frame "diamonds" and modify existing ones:
#    a. add the product of the x, y, z dimensions
diamonds$product <- diamonds$x * diamonds$y * diamonds$z
diamonds <- mutate(diamonds,
                   product = x*y*z)

#    b. add the log of the price in base 10
#    c. add the squared depth
#    d. add the exponential of the carat
#    e. turn variables cut, color, clarity into factors
#    f. add a variable to the data frame that takes value 1 only if the carat is greater  
#       or equal to 0.8, and 0 otherwise. Turn it into a logical variable
#    g. generate an external vector that contains all possible levels of the "color" variable. 
#       Make sure the vector is of the "character" type. Coerce it, if it is not

# Exercise 4 ----
# 4) generate a second data frame which includes only diamonds with "Ideal" or "Premium" cuts. Remove
#    variables x, y, z from this data frame
new.diamonds <- filter(diamonds,
                       cut == "Ideal" | cut == "Premium")
new.diamonds <- select(new.diamonds,
                       -c("x", "y", "z"))
new.diamonds <- diamonds[diamonds$cut == "Ideal" | diamonds$cut == "Premium", 1:7]

# Exercise 5 ----
# 5) a. delete all objects in your environment except for the diamonds database (the first one)
#    b. create a list containing one matrix and one vector. The matrix
#       should have 4 rows and 3 columns and contain the values from 1 to 12 in
#       reverse order such that the first row contains the value 12, 11, 10, the
#       second starts with 9 and so on. The vector should contain the sum of each column
#       of the matrix. Then remove the list, the matrix and the vector from your R session

# 2) GET SUMMARY STATS AND PLOTS, RUN BASIC STATISTICAL ANALYSES ----
# When possible, run exercises 6-10 using base R and tidyverse

# Exercise 6 ----
# 6) 
# a. what is the price of the diamond with the highest carat?
# b. obtain summary statistics for the numeric variables in the diamonds dataset
#    (hint: use the "psych" dataset!)
# c. obtain summary statistics only relative to diamonds with colors E, J, or D
#    (hint: use the "psych" dataset!)

# Exercise 7 ----
# 7)
# a. test if the mean price in the first dataframe is smaller than that in the 
#    second data frame from exercise 4 (hint: it's a one-tailed t-test!)
# b. in the first dataframe, test if the mean price for diamonds with "Ideal" 
#    cut is different from the price of diamonds with "Premium" cut

# Exercise 8 ----
# 8) a. create a histogram of the price of diamonds in our dataset
#    b. create a histogram of the carats of diamonds with color E or G and clarity SI2 
#    c. create boxplots of the distributions of carats for each possible color
#    d. save the last plot in your folder as a pdf and call it "boxplots_carats.pdf"
#    e. create a scatterplot of the price (y axis) and carats (x axis)
#    f. add to the previous plot a straight and blue horizontal line corresponding to the 
#       mean log(price)
#    g. add to the previous graph a straight red regression line

# Exercise 9 ----
# 9) a. run a linear model to explain the log of the price based on carats, depth, and table.
#       save the results in an object. Show the results
#    b. add the squared depth to the previous model
#    c. show the results obtained using functions from either stargazer or texreg

# Exercise 10 (hard!) ----
# 10) a. save a data frame with predictions from the second model and prediction confidence intervals
#     b. save a matrix with 3 columns and number of rows equal to the number of coefficients
#        in the second model. In the first row, store the coefficient estimated (the beta), in the
#        second row store its standard error and in the third row store the p-value associated with 
#        the test of hypothesis that the true beta is equal to 0 (hint: the test is automatically 
#        computed by a regression command like lm(), the p-value is reported in its summary table)

# THE END ----
