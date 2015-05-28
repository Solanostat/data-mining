library(aod)
library(ggplot2)

# A researcher is interested in how variables, such as GRE (Graduate Record Exam scores), GPA (grade point average) 
# and prestige of the undergraduate institution, effect admission into graduate school. The response variable, 
# admit/don't admit, is a binary variable.

mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
## view the first few rows of the data
head(mydata)
##   admit gre  gpa rank
## 1     0 380 3.61    3
## 2     1 660 3.67    3
## 3     1 800 4.00    1
## 4     1 640 3.19    4
## 5     0 520 2.93    4
## 6     1 760 3.00    2

#This dataset has a binary response (outcome, dependent) variable called admit. There are three predictor variables: 
#gre, gpa and rank. We will treat the variables gre and gpa as continuous. The variable rank takes on the values 1 
#through 4. Institutions with a rank of 1 have the highest prestige, while those with a rank of 4 have the lowest. 
#We can get basic descriptives for the entire data set by using summary. To get the standard deviations, we use sapply
#to apply the sd function to each variable in the dataset.
sapply(mydata, sd)

# The code below estimates a logistic regression model using the glm (generalized linear model) function. First, 
# we convert rank to a factor to indicate that rank should be treated as a categorical variable.
mydata$rank <- factor(mydata$rank)
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")


