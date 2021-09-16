# Course:                     Introduction to R
# University:                 University of Essex
#                             Essex Summer School in Social Science Data Analysis
# File description:           Runs exercises to practice with R tools. Solutions
# Instructor and programmer:  Lorenzo Crippa
# Date:                       Sunday 11th July 2021,  12-6pm

# clear the environment
rm(list = ls())

# set working directory (change path using the location of your working directory)
setwd("/Users/Lorenzo/Documents/Università/University_of_Essex/Teaching/ESS/Introduction_to_R/2021")

# 1) R DATA TYPES AND OBJECTS, IMPORT AND MANAGE DATASETS ----
# When possible, run exercises 1-5 using base R and tidyverse

# Exercise 1 ----
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


# Exercise 2 ----
# 2) a. take vectors from point 1) d. and 1) f. and combine them into a 5x7 matrix. 
#       Arrange elements by column.
mat <- matrix(data = c(vector2, vector4), nrow = 5, ncol = 7, byrow = FALSE)
mat

#    b. compute the sum of each row of the matrix
mat[1,1]+mat[1,2]+mat[1,3]+mat[1,4]+mat[1,5]+mat[1,6]+mat[1,7]
# or:
sum(mat[1,])
sum(mat[2,])
sum(mat[3,])
sum(mat[4,])
sum(mat[5,])

# Exercise 3 ----
# Import the "diamonds.csv" dataset into your R session.
diamonds <- read.csv("diamonds.csv")

# 3) add some variables to the data frame "diamonds" and modify existing ones:
#    a. add the product of the x, y, z dimensions
diamonds$product <- diamonds$x * diamonds$y * diamonds$z
# or:
diamonds <- mutate(diamonds,
                   product = x*y*z)

#    b. add the log of the price in base 10
diamonds$log.price <- log(diamonds$price, base = 10)
# or:
diamonds <- mutate(diamonds,
                   log.price = log(price, base = 10))

#    c. add the squared depth
diamonds$sq.depth <- diamonds$depth^2
# or:
diamonds <- mutate(diamonds,
                   sq.depth = depth^2)

#    d. add the exponential of the carat
diamonds$exp.carat <- exp(diamonds$carat)
# or:
diamonds <- mutate(diamonds,
                   exp.carat = exp(carat))

#    e. turn variables cut, color, clarity into factors
diamonds$cut <- as.factor(diamonds$cut)
diamonds$color <- as.factor(diamonds$color)
diamonds$clarity <- as.factor(diamonds$clarity)
# or:
diamonds <- mutate(diamonds,
                   cut = as.factor(cut),
                   color = as.factor(color),
                   clarity = as.factor(clarity))

#    f. add a variable to the data frame that takes value 1 only if the carat is greater  
#       or equal to 0.8, and 0 otherwise. Turn it into a logical variable
diamonds$level.carat <- as.logical(
  ifelse(diamonds$carat >= 0.8, 1, 0)
)

# or:
diamonds <- mutate(diamonds,
                   level.carat = as.logical(case_when(carat >= 0.8 ~ 1,
                                                      TRUE ~ 0)
                                            )
                   )

#    g. generate an external vector that contains all possible levels of the "color" variable. 
#       Make sure the vector is of the "character" type. Coerce it, if it is not
colors <- unique(diamonds$color)
is.character(colors)
colors <- as.character(colors)

# Exercise 4 ----
# 4) generate a second data frame which includes only diamonds with "Ideal" or "Premium" cuts. Remove
#    variables x, y, z from this data frame
diamonds.2 <- diamonds[diamonds$cut == "Ideal" | diamonds$cut == "Premium", c(1:7,11:12)]

# or:
diamonds.2 <- filter(diamonds, cut %in% c("Ideal", "Premium"))
diamonds.2 <- select(diamonds.2, c(1:7,11:12))

# Exercise 5 ----
# 5) a. delete all objects in your environment except for the diamonds database (the first one)
rm(diamonds.2, mat, colors, string.vect, vector1, vector2, vector3, vector4)
# but it's easier if we ask to remove everything BUT the object we want:
rm(list = setdiff(ls(), "diamonds"))
# this command removes a list made of the difference between our environment (ls() function)
# and the object "diamonds". The difference between the two is our environment minus "diamonds"!

#    b. create a list containing one matrix and one vector. The matrix
#       should have 4 rows and 3 columns and contain the values from 1 to 12 in
#       reverse order such that the first row contains the value 12, 11, 10, the
#       second starts with 9 and so on. The vector should contain the sum of each column
#       of the matrix. Then remove the list, the matrix and the vector from your R session
mat <- matrix(c(12:10, 9:7, 6:4, 3:1), 
              nrow = 4,
              ncol = 3,
              byrow = T)
mat
vect <- c(sum(mat[,1]), sum(mat[,2]), sum(mat[,3]))
ls <- list(mat, vect)
ls

rm(mat, vect, ls)

# 2) GET SUMMARY STATS AND PLOTS, RUN BASIC STATISTICAL ANALYSES ----
# When possible, run exercises 6-10 using base R and tidyverse

# Exercise 6 ----
# 6) 
# a. what is the price of the diamond with the highest carat?
diamonds$price[diamonds$carat == max(diamonds$carat)] # 18018

# b. obtain summary statistics for the numeric variables in the diamonds dataset
#    (hint: use the "psych" dataset!)
library("psych")
describe(diamonds[, c(1,5:12)], skew = FALSE)

# c. obtain summary statistics only relative to diamonds with colors E, J, or D
#    (hint: use the "psych" dataset!)
describe(diamonds[diamonds$color %in% c("E", "J", "D"), c(1,5:12)], skew = FALSE)

# Exercise 7 ----
# 7)

# a. test if the mean price in the first dataframe is smaller than that in the 
#    second data frame from exercise 4 (hint: it's a one-tailed t-test!)
# first re-create the dataframe from exercise 4:
diamonds.2 <- diamonds[diamonds$cut == "Ideal" | diamonds$cut == "Premium", c(1:7,11:12)]

t.test(diamonds$price, diamonds.2$price, alternative = "greater")

# b. in the first dataframe, test if the mean price for diamonds with "Ideal" 
#    cut is different from the price of diamonds with "Premium" cut
t.test(diamonds$price[diamonds$cut == "Ideal"], diamonds$price[diamonds$cut == "Premium"])


# Exercise 8 ----
# 8) a. create a histogram of the price of diamonds in our dataset
hist(diamonds$price)
# or:
ggplot(diamonds, aes(x = price)) + geom_histogram()

#    b. create a histogram of the carats of diamonds with color E or G and clarity SI2 
hist(diamonds$carat[(diamonds$color == "E" | diamonds$color == "G") & (diamonds$clarity == "SI2")],
     xlab = "carat", main = "Histogram of carats")
# or:
ggplot(filter(diamonds,
              color %in% c("E", "G") & clarity == "SI2"),
       aes(x = carat)) + geom_histogram()

#    c. create boxplots of the distributions of carats for each possible color
boxplot(diamonds$carat ~ diamonds$color, xlab = "color", ylab = "carat", 
        frame = FALSE, pch = 20, main = "Boxplots")
# or:
ggplot(diamonds,
       aes(x = color, y = carat)) + geom_boxplot()

#    d. save the last plot in your folder as a pdf and call it "boxplots_carats.pdf"
ggsave(filename = "boxplots_carats.pdf")

#    e. create a scatterplot of the price (y axis) and carats (x axis)
plot(x = diamonds$carat, y = diamonds$price, pch = 20, 
     xlab = "carat", ylab = "price", frame.plot = FALSE)
#    f. add to the previous plot a straight and blue horizontal line corresponding to the 
#       mean log(price)
abline(h = mean(diamonds$price), col = "blue")

#    g. add to the previous graph a straight red regression line
abline(lm(price ~ carat, data = diamonds), col = "red")

# or:
ggplot(diamonds, aes(x = carat, y = price)) + geom_point() +
  geom_hline(yintercept = mean(diamonds$price), col = "blue") +
  geom_smooth(method = "lm", col = "red") +
  ylim(c(0, 20000)) 

# Exercise 9 ----
# 9) a. run a linear model to explain the log of the price based on carats, depth, and table.
#       save the results in an object. Show the results
model1 <- lm(log.price ~ carat + depth + table, data = diamonds)
summary(model1)

#    b. add the squared depth to the previous model
model2 <- lm(log.price ~ carat + depth + I(depth^2) + table, data = diamonds)
summary(model2)

#    c. show the results obtained using functions from stargazer
library("stargazer")
stargazer(model1, model2, type = "text")

# Exercise 10 (hard!) ----
# 10) a. save a data frame with predictions from the second model and prediction confidence intervals
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

# THE END ----