#Tree methods such as CART (classification and regression trees) can be used as alternatives to logistic regression.

library("party")
#Call function ctree to build a decision tree. 
#The first parameter is a formula, which defines a target variable and a list of independent variables.
iris_ctree <- ctree(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=iris)
plot(iris_ctree)


library(rpart)
raw.orig < - read.csv(file="c:\\rsei212_chemical.txt", header=T, sep="\t")

raw = subset(raw.orig, select=c("Metal","OTW","AirDecay","Koc"))
 
row.names(raw) = raw.orig$CASNumber
raw = na.omit(raw);
 
frmla = Metal ~ OTW + AirDecay + Koc
 
# Metal: Core Metal (CM); Metal (M); Non-Metal (NM); Core Non-Metal (CNM)
 
fit = rpart(frmla, method="class", data=raw)
 
printcp(fit)          # display the results
plotcp(fit)           # visualize cross-validation results
summary(fit)          # detailed summary of splits
 
# plot tree
plot(fit, uniform=TRUE, main="Classification Tree for Chemicals")
text(fit, use.n=TRUE, all=TRUE, cex=.8)
 
# tabulate some of the data
table(subset(raw, Koc>=190.5)$Metal)

###############
# TREE package
library(tree)
 
tr = tree(frmla, data=raw)
summary(tr)
plot(tr); text(tr)

###############
# PARTY package
library(party)
 
(ct = ctree(frmla, data = raw))
plot(ct, main="Conditional Inference Tree")
 
#Table of prediction errors
table(predict(ct), raw$Metal)
 
# Estimated class probabilities
tr.pred = predict(ct, newdata=raw, type="prob")

###############
## EVTREE (Evoluationary Learning)
library(evtree)
 
ev.raw = evtree(frmla, data=raw)
plot(ev.raw)
table(predict(ev.raw), raw$Metal)
1-mean(predict(ev.raw) == raw$Metal)

