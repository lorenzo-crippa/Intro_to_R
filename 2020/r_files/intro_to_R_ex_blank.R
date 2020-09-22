######################################################################################################
# Course:                     Introduction to R                                                      #
#                                                                                                    #
# University:                 University of Essex                                                    #
#                             Essex Summer School in Social Science Data Analysis                    #
#                                                                                                    #
# File description:           Runs exercises to practice with R tools                                #
#                                                                                                    #
# Instructor and programmer:  Lorenzo Crippa                                                         #
#                                                                                                    #
# Date:                       Sunday 12th July 2020,  12-4pm                                         #
######################################################################################################

# clear the environment
rm(list = ls())

# set working directory (change path using the location of your working directory)
setwd("/Users/Lorenzo/Documents/Università/University_of_Essex/Teaching/ESS/Introduction_to_R/2020")

# import data
diamonds <- read.csv("diamonds.csv")

#####
# 1) a. generate a string vector whose elements are the words of this sentence
#    b. generate a numeric vector whose elements are all numbers from 1 to 20 at a distance of 0.5
#    c. generate a numeric vector that is the sequence from 1 to 20 at a distance of 1
#    d. turn the previous vector into a binary one: it takes value 1 if it is below 15, 0 otherwise
#    e. turn the binary vector into a logical one (boolean). Store it into a new vector, though
#    f. generate a numeric vector that replicates 1 5 times, 2 4 times, 3 3 times, 4 2 times, 5 1 time

#####
# 2) a. take vectors from point 1) d. and 1) f. and combine them into a 5x7 matrix. 
#       Arrange elements by column.
#    b. compute the mean of each row of the matrix

#####
# 3) add some variables to the data frame "diamonds" and modify existing ones:
#    a. add the product of the x, y, z dimensions
#    b. add the log of the price in base 10
#    c. add the squared depth
#    d. add the exponential of the carat
#    e. turn variables cut, color, clarity into factors
#    f. add a variable to the data frame that takes value 1 only if the carat is greater  
#       or equal to the mean carat, 0 otherwise. Turn it into a logical variable
#    g. generate an external vector that contains all possible levels of the "color" variable. 
#       Make sure the vector is of the "character" type. Coerce it, if it is not

#####
# 4) generate a numeric vector that reports the mean carats for all the levels in the color vector.

#####
# 5) generate a second data frame which includes only diamonds with "Ideal" or "Premium" cuts. Remove
#    variables x, y, z

#####
# 6) determine what is the price of the diamond with the highest carat in this new dataframe

#####
# 7) 
# a. test if the mean price in the first dataframe is smaller than that in the 
#    second data frame (hint: it's a one-tailed t-test!)
# b. in the first dataframe, test if the mean price for diamonds with "Ideal" 
#    cut is different from the price of diamonds with "Premium" cut

#####
# 8) a. obtain summary statistics for the numeric variables in the diamonds dataset
#       (hint: use the "psych" dataset!)
#    b. obtain summary statistics only relative to diamonds with colors E, J, or D
#       (hint: use the "psych" dataset!)


#####
# 9) obtain a matrix with number of rows equal to the number of numeric variables in the
#    diamonds dataset, and number of columns equal to 5. Each cell in the matrix will be
#    a summary statistic of the variable in that row. The 1st column will report the mean,
#    the 2nd will report the standard deviation, the 3rd will report the min, the 4th the
#    max and the 5th the median. Rename columns and rows appropriately. 
#    Then coerce R to turn the matrix into a data frame.

#####
# 10) a. delete all objects in your environment except for the diamonds database (the first one)
#     b. create a list containing one matrix and one vector. The matrix
#        should have 4 rows and 3 columns and contain the values from 1 to 12 in
#        reverse order such that the first row contains the value 12, 11, 10, the
#        second starts with 9 and so on. The vector should contain the mean of each column
#        of the matrix. Then remove the list, the matrix and the vector

#############
# SOLUTIONS #
#############

#####
# 11) a. obtain a histogram of the price of diamonds in our dataset
#     b. obtain a histogram of the carats of diamonds with color E or G and clarity SI2 

#####
# 12) obtain boxplots of the distributions of carats for each possible:
#     a. clarity level
#     b. color
#     c. cut

#####
# 13) save the last plot in your folder as a pdf and call it "boxplots_carats.pdf"

#####
# 14) a. obtain a scatterplot of the price (y axis) and carats (x axis)
#     b. re-obtain the same plot but using log of price variable 
#        we have created before, instead of price

#####
# 15) add to the previous plot a straight and blue horizontal line corresponding to the mean log(price)

#####
# 16) add to the previous graph a straight red regression line

#####
# 17) run a linear model to explain the log of the price based on carats, depth, and table.
#     save the results in an object. Show the results

#####
# 18) add the squared depth to the previous model

#####
# 19) show the results obtained using functions from either stargazer or texreg

#####
# 20) a. save a data frame with predictions from the second model and prediction confidence intervals
#     b. save a matrix with 3 columns and number of rows equal to the number of coefficients
#        in the second model. In the first row, store the coefficient estimated (the beta), in the
#        second row store its standard error and in the third row store the p-value associated with 
#        the test of hypothesis that the true beta is equal to 0 (hint: the test is automatically 
#        computed by a regression command like lm(), the p-value is reported in its summary table)

###############
### THE END ###
###############