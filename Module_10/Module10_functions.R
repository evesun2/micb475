#!/usr/bin/env Rscript

######## Simple Functions #########
# OUTPUT <- FUNCTION(INPUTS)

# Example: the sum function sums values
sum(c(1,2,3))
# You can also give it a vector to sum
x <- c(1,2,3)
sum(x)

# What is the minimum value?
min(c(1,3,NA,10))

# To find other options or troubleshoot, look at manual
?min

# Sum a vector, ignoring NAs
min(c(1,3,NA,10), na.rm = TRUE)

# Sort a vector
sort(c(3,1,NA,10))
?sort
sort(c(1,3,NA,10), decreasing=TRUE)

#### Other common functions:
length(c(1,2,3,4))

seq(1,4)

min(c(1,2,3,4))
max(c(1,2,3,4))

sum(c(1,2,3,4))
prod(c(1,2,3,4))

unique(c(1,1,2,2,2,3,10,10,10))
table(c(1,1,2,2,2,3,10,10,10))

which.min(c(10,3,1,2,5))
which.max(c(10,3,1,2,5))

sort(c(10,3,1,2,5))
order(c(10,3,1,2,5))

# Make a named vector
faveveg <- c(Melissa="broccoli",David = "carrot", Maxine = "carrot")
names(faveveg)

# Let's make our fam matrix again
fam <- data.frame(names = c("Melissa","David", "Maxine", "Braelyn")
                  , age = c(103, 103, 1,7)
                  , human = c(TRUE, TRUE, FALSE, FALSE)
                  , faveveg = c("broccoli","carrot","carrot", NA))
fam

colnames(fam)
rownames(fam)
ncol(fam)
nrow(fam)
