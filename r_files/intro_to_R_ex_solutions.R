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

# set working directory
setwd("/Users/Lorenzo/Documents/Università/University_of_Essex/Teaching/ESS/Introduction_to_R/2020")

# import data
diamonds <- read.csv("diamonds.csv")

#####
# 1) a. generate a string vector whose elements are the words of this sentence
string.vect <- c("generate", "a", "string", "vector", "whose", "elements",
                 "are", "the", "words", "of", "this", "sentence")

#    b. generate a numeric vector whose elements are all numbers from 1 to 20 at a distance of 0.5
vector1 <- seq(from = 1, to = 20, by = 0.5)

#    c. generate a numeric vector that is the sequence from 1 to 20 at a distance of 1
vector2 <- seq(from = 1, to = 20, by = 1)
# or
vector2 <- 1:20

#    d. turn the previous vector into a binary one: it takes value 1 if it is below 15, 0 otherwise
vector2 <- ifelse(vector2 < 15, 1, 0)

#    e. turn the binary vector into a logical one (boolean). Store it into a new vector, though
vector3 <- as.logical(vector2)

#    f. generate a numeric vector that replicates 1 5 times, 2 4 times, 3 3 times, 4 2 times, 5 1 time
vector4 <- c(rep(1, 5), rep(2, 4), rep(3, 3), rep(4, 2), rep(5, 1))

#####
# 2) a. take vectors from point 1) d. and 1) f. and combine them into a 5x7 matrix. 
#       Arrange elements by row
mat <- matrix(data = c(vector2, vector4), nrow = 5, ncol = 7, byrow = FALSE)
mat

#    b. compute the mean of each row of the matrix
mean(mat[1,])
mean(mat[2,])
mean(mat[3,])
mean(mat[4,])
mean(mat[5,])

#####
# 3) add some variables to the data frame "diamonds" and modify existing ones:
#    a. add the product of the x, y, z dimensions
diamonds$product <- diamonds$x * diamonds$y * diamonds$z

#    b. add the log of the price in base 10
diamonds$log.price <- log(diamonds$price, base = 10)

#    c. add the squared depth
diamonds$sq.depth <- diamonds$depth^2

#    d. add the exponential of the carat
diamonds$exp.carat <- exp(diamonds$carat)

#    e. turn variables cut, color, clarity into factors
diamonds$cut <- as.factor(diamonds$cut)
diamonds$color <- as.factor(diamonds$color)
diamonds$clarity <- as.factor(diamonds$clarity)

#    f. add a variable to the data frame that takes value 1 only if the carat is greater  
#       or equal to the mean carat, 0 otherwise. Turn it into a logical variable
diamonds$level.carat <- as.logical(
  ifelse(diamonds$carat >= mean(diamonds$carat, na.rm = TRUE), 1, 0)
)

#    g. generate a vector that contains all possible levels of the "color" variable. 
#       Make sure the vector is of the "character" type. Coerce it, if it is not
colors <- unique(diamonds$color)
is.character(colors)
colors <- as.character(colors)

#####
# 4) generate a numeric vector that reports the mean carats for all the levels in the color vector.
# Various ways to do that:
colors # these are all levels in the color vector (we obtained it before)
m1 <- mean(diamonds$carat[diamonds$color == "E"], na.rm = T)
m2 <- mean(diamonds$carat[diamonds$color == "I"], na.rm = T)
m3 <- mean(diamonds$carat[diamonds$color == "J"], na.rm = T)
m4 <- mean(diamonds$carat[diamonds$color == "H"], na.rm = T)
m5 <- mean(diamonds$carat[diamonds$color == "F"], na.rm = T)
m6 <- mean(diamonds$carat[diamonds$color == "G"], na.rm = T)
m7 <- mean(diamonds$carat[diamonds$color == "D"], na.rm = T)
means <- c(m1,m2,m3,m4,m5,m6,m7)

# or:
means <- rep(NA, length(colors)) # create an empty vector of the same length of "colors"
means[1] <- mean(diamonds$carat[diamonds$color == "E"], na.rm = T)
means[2] <- mean(diamonds$carat[diamonds$color == "I"], na.rm = T)
means[3] <- mean(diamonds$carat[diamonds$color == "J"], na.rm = T)
means[4] <- mean(diamonds$carat[diamonds$color == "H"], na.rm = T)
means[5] <- mean(diamonds$carat[diamonds$color == "F"], na.rm = T)
means[6] <- mean(diamonds$carat[diamonds$color == "G"], na.rm = T)
means[7] <- mean(diamonds$carat[diamonds$color == "D"], na.rm = T)

# smarter way of doing that: with a loop (we haven't seen it together)
j <- 1 # set a counter to 1
for (i in colors) { # iterate for each value of the "colors" vector
  # put the mean of carat for diamonds with the i color at the jth place of the means vector:
  means[j] <- mean(diamonds$carat[diamonds$color == i], na.rm = T) 
  j <- j+1 # add +1 to j before going to next iteration
  }

#####
# 5) generate a second data frame which includes only diamonds with "Ideal" or "Premium" cuts. Remove
#    variables x, y, z
diamonds.2 <- diamonds[diamonds$cut == "Ideal" | diamonds$cut == "Premium", c(1:7,11:12)]

# or:
library("tidyverse")
diamonds.2 <- filter(diamonds, cut == "Ideal" | cut == "Premium")
diamonds.2 <- select(diamonds.2, c(1:7,11:12))

#####
# 6) determine what is the price of the diamond with the highest carat in this new dataframe
diamonds.2 <- diamonds.2[order(diamonds.2$carat),] # reorder the dataframe based on carat
# give me the price of the observation at the last place (at the place corresponding to
# the length of the entire price vector = the last place!)
diamonds.2$price[length(diamonds.2$price)] # 15223

# or else you can do:
# keep only the observations with highest carat
highest <- filter(diamonds.2, carat == max(carat, na.rm = TRUE)) 
# get the maximum of the price of these observations:
max(highest$price)

#####
# 7) 
# a. test if the mean price in the first dataframe is smaller than that in the 
#    second data frame (hint: it's a one-tailed t-test!)
t.test(diamonds$price, diamonds.2$price, alternative = "greater")

# b. in the first dataframe, test if the mean price for diamonds with "Ideal" 
#    cut is different from the price of diamonds with "Premium" cut
t.test(diamonds$price[diamonds$cut == "Ideal"], diamonds$price[diamonds$cut == "Premium"])

#####
# 8) a. obtain summary statistics for the numeric variables in the diamonds dataset.
#       (hint: use the "psych" dataset!)
library("psych")
describe(diamonds[, c(1,5:12)], skew = FALSE)

#    b. obtain summary statistics only relative to diamonds with colors E, J, or D
#       (hint: use the "psych" dataset!)
describe(diamonds[diamonds$color == "E" | diamonds$color == "J"
                  | diamonds$color == "D", c(1,5:12)], skew = FALSE)

#####
# 9) obtain a matrix with number of rows equal to the number of numeric variables in the
#    diamonds dataset, and number of columns equal to 5. Each cell in the matrix will be
#    a summary statistic of the variable in that row. The 1st column will report the mean,
#    the 2nd will report the standard deviation, the 3rd will report the min, the 4th the
#    max and the 5th the median. Rename columns and rows appropriately. 
#    Then coerce R to turn the matrix into a data frame.

# first create an empty matrix and rename rows and columns
m <- matrix(rep(NA), nrow = 9, ncol = 5) 
colnames(m) <- c("mean", "sd", "min", "max", "median")
rownames(m) <- c("carat", "depth", "table", "price", "x", "y", "z", "product", "log.price")
m

# we can fill it manually:
m[1,1] <- mean(diamonds$carat, na.rm = T)
m[1,2] <- sd(diamonds$carat, na.rm = T)
m[1,3] <- min(diamonds$carat, na.rm = T)
m[1,4] <- max(diamonds$carat, na.rm = T)
m[1,5] <- median(diamonds$carat, na.rm = T)
m[2,1] <- mean(diamonds$depth, na.rm = T)
#.... but this will take long! With a loop we'd do it quicker:
# first, save a list with the variables we want to include:
names <- list(diamonds$carat, diamonds$depth, diamonds$table, diamonds$price,
              diamonds$x, diamonds$y, diamonds$z, diamonds$product, diamonds$log.price)

# then set a counter to 1: we'll use it to iterate and tell the loop in what row to put results
i <- 1
for (n in names) {
  m[i,1] <- mean(n, na.rm = T)
  m[i,2] <- sd(n, na.rm = T)
  m[i,3] <- min(n, na.rm = T)
  m[i,4] <- max(n, na.rm = T)
  m[i,5] <- median(n, na.rm = T)
  i <- i+1 # add 1 to the counter: each iteration will put results in the next row!
}
m

df <- as.data.frame(m)

#####
# 10) a. delete all objects in your environment except for the diamonds database (the first one)
# we can do:
rm(diamonds.2, colors, i, j, m1, m2, m3, m4, m5, m6, m7, means, names, m, df, n)
# but it's easier if we ask to remove everything BUT the object we want:
rm(list = setdiff(ls(), "diamonds"))
# this command removes a list made of the difference between our environment (ls() function)
# and the object "diamonds". The difference between the two is our environment minus "diamonds"!

#     b. create a list containing one matrix and one vector. The matrix
#        should have 4 rows and 3 columns and contain the values from 1 to 12 in
#        reverse order such that the first row contains the value 12, 11, 10, the
#        second starts with 9 and so on. The vector should contain the mean of each column
#        of the matrix. Then remove the list, the matrix and the vector
mat <- matrix(c(12:10, 9:7, 6:4, 3:1), 
              nrow = 4,
              ncol = 3,
              byrow = T)
vect <- c(mean(mat[,1]), mean(mat[,2]), mean(mat[,3]))
ls <- list(mat, vect)
ls

rm(mat, vect, ls)

#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################

#####
# 11) a. obtain a histogram of the price of diamonds in our dataset
hist(diamonds$price, xlab = "price", main = "Histogram of price")

#     b. obtain a histogram of the carats of diamonds with color E or G and clarity SI2 
hist(diamonds$carat[(diamonds$color == "E" | diamonds$color == "G") & (diamonds$clarity == "SI2")],
     xlab = "carat", main = "Histogram of carats")

#####
# 12) obtain boxplots of the distributions of carats for each possible:
#     a. clarity level
boxplot(diamonds$carat ~ diamonds$clarity, xlab = "clarity", ylab = "carat", 
        frame = FALSE, pch = 20, main = "Boxplots")

#     b. color
boxplot(diamonds$carat ~ diamonds$color, xlab = "color", ylab = "carat", 
        frame = FALSE, pch = 20, main = "Boxplots")

#     c. cut
boxplot(diamonds$carat ~ diamonds$cut, xlab = "cut", ylab = "carat", 
        frame = FALSE, pch = 20, main = "Boxplots")

#####
# 13) save the last plot in your folder as a pdf and call it "boxplots_carats.pdf"
pdf("boxplots_carats.pdf")
boxplot(diamonds$carat ~ diamonds$cut, xlab = "cut", ylab = "carat", 
        frame = FALSE, pch = 20, main = "Boxplots")
dev.off()

# we can also simply do:
dev.copy("boxplots_carats.pdf", device = pdf) # this puts the last plot obtained in a pdf
dev.off() # closes and saves the pdf

#####
# 14) a. obtain a scatterplot of the price (y axis) and carats (x axis)
plot(x = diamonds$carat, y = diamonds$price, pch = 20, 
     xlab = "carat", ylab = "price", frame.plot = FALSE)

#     b. re-obtain the same plot but using log of price variable 
#        we have created before, instead of price
plot(x = diamonds$carat, y = diamonds$log.price, pch = 20, 
     xlab = "carat", ylab = "price (log)", frame.plot = FALSE)

#####
# 15) add to the previous plot a straight and blue horizontal line corresponding to the mean log(price)
abline(h = mean(diamonds$log.price), col = "blue")

#####
# 16) add to the previous graph a straight red regression line
abline(lm(log.price ~ carat, data = diamonds), col = "red")

#####
# 17) run a linear model to explain the log of the price based on carats, depth, and table.
#     save the results in an object. Show the results
model1 <- lm(log.price ~ carat + depth + table, data = diamonds)
summary(model1)

#####
# 18) add the squared depth to the previous model
model2 <- lm(log.price ~ carat + depth + I(depth^2) + table, data = diamonds)
summary(model2)

#####
# 19) show the results obtained using functions from either stargazer or texreg
library("texreg")
screenreg(list(model1, model2),
          stars = c(0.01, 0.05, 0.1),
          reorder.coef = c(2,3,5,4,1))

#####
# 20) a. save a data frame with predictions from the second model and prediction confidence intervals
prediction <- as.data.frame(predict(model1, newdata = diamonds, interval = "confidence"))

#     b. save a matrix with 3 columns and number of rows equal to the number of coefficients
#        in the second model. In the first row, store the coefficient estimated (the beta), in the
#        second row store its standard error and in the third row store the p-value associated with 
#        the test of hypothesis that the true beta is equal to 0 (hint: the test is automatically 
#        computed by a regression command like lm(), the p-value is reported in its summary table)
m <- matrix(rep(NA), # an empty matrix 
            nrow = nrow(summary(model2)$coefficients), # nrow equals the number of rows of the
            # summary of coefficients in model2! (i.e.: the number of coefficients)
            ncol = 3) # we want three columns
m[,1] <- summary(model2)$coefficients[,1]
m[,2] <- summary(model2)$coefficients[,2]
m[,3] <- summary(model2)$coefficients[,4] # p-values are in the fourth column of the summary!

# we can also give names to rows and columns of this matrix:
rownames(m) <- variable.names(model2) # we directly give the name of the variables in the model!
colnames(m) <- c("beta", "standard error", "p-value")
m

# then if you want you can turn it into a data frame:
df <- as.data.frame(m)
df

###############
### THE END ###
###############