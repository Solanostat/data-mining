library(aod)
library(ggplot2)

"A researcher is interested in how variables, such as GRE (Graduate Record Exam scores), GPA (grade point average) 
and prestige of the undergraduate institution, effect admission into graduate school. The response variable, 
admit/don't admit, is a binary variable."

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

"This dataset has a binary response (outcome, dependent) variable called admit. There are three predictor variables: 
gre, gpa and rank. We will treat the variables gre and gpa as continuous. The variable rank takes on the values 1 
through 4. Institutions with a rank of 1 have the highest prestige, while those with a rank of 4 have the lowest. 
We can get basic descriptives for the entire data set by using summary. To get the standard deviations, we use sapply
to apply the sd function to each variable in the dataset."
sapply(mydata, sd)

# The code below estimates a logistic regression model using the glm (generalized linear model) function. First, 
# we convert rank to a factor to indicate that rank should be treated as a categorical variable.
mydata$rank <- factor(mydata$rank)
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")

summary(mylogit)
## 
## Call:
## glm(formula = admit ~ gre + gpa + rank, family = "binomial", 
##     data = mydata)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.627  -0.866  -0.639   1.149   2.079  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -3.98998    1.13995   -3.50  0.00047 ***
## gre          0.00226    0.00109    2.07  0.03847 *  
## gpa          0.80404    0.33182    2.42  0.01539 *  
## rank2       -0.67544    0.31649   -2.13  0.03283 *  
## rank3       -1.34020    0.34531   -3.88  0.00010 ***
## rank4       -1.55146    0.41783   -3.71  0.00020 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 499.98  on 399  degrees of freedom
## Residual deviance: 458.52  on 394  degrees of freedom
## AIC: 470.5
## 
## Number of Fisher Scoring iterations: 4
"In the output above, the first thing we see is the call, this is R reminding us what the model we ran was, what 
options we specified, etc.
Next we see the deviance residuals, which are a measure of model fit. This part of output shows the distribution 
of the deviance residuals for individual cases used in the model. Below we discuss how to use summaries of the 
deviance statistic to assess model fit.
The next part of the output shows the coefficients, their standard errors, the z-statistic, and the associated 
p-values. Both gre and gpa are statistically significant, as are the three terms for rank. The logistic regression
coefficients give the change in the log odds of the outcome for a one unit increase in the predictor variable.
For every one unit change in gre, the log odds of admission (versus non-admission) increases by 0.002.
For a one unit increase in gpa, the log odds of being admitted to graduate school increases by 0.804.
The indicator variables for rank have a slightly different interpretation. For example, having attended an 
undergraduate institution with rank of 2, versus an institution with a rank of 1, changes the log odds of admission 
by -0.675."
