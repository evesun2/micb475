#!/usr/bin/env Rscript

###### Variable types ##########
# Assigning variables
a <- 1
b <- "chen"
c <- -4.5
d <- "-4.5"
e <- TRUE
f <- FALSE

# To find variable type
typeof(a)
class(a)

# Adding to numbers together
1 + -4.5
a + c

# Cannot add number and character
a + b
a + d
# Can force a character to number
a + as.numeric(d)
as.numeric(b)

# Adding True and False together
e + f
e + e
f + f

########## Data structures ########

#### Vectors are collections of ONE variable type
# This will work
c("Melissa","David","Maxine")
# This will not work- forces others to be character
c("Melissa", 2020)
c("Melissa", TRUE)

# These are all valid
names <- c("Melissa","David","Maxine")
age <- c(103,103,1)
human <- c(TRUE, TRUE, FALSE)

# Adding variables to a vector
names <- c(names, "Braelyn")
age <- c(age, 7)
human <- c(human, FALSE)

# Look at vectors
names
age
human

#### Data frames are collections of multiple vector types
fam <- data.frame(names, age, human)
fam
# Is the same as:
fam <- data.frame(names = c("Melissa","David", "Maxine", "Braelyn")
                  , age = c(103, 103, 1,7)
                  , human = c(TRUE, TRUE, FALSE, FALSE))
fam

# Calling contents of data frame

fam$names

fam[,1]
fam[1,]
fam[1,2]

# Changing contents of data frame
fam[1,2] <- 102
fam 

# Change both David and I's age
fam[c(1,2),2] <- 102
fam

# Removing contents of data frame
fam_2023 <- fam[-4,]
fam_2023

#### Factors are similar to a vector, except they are "organized"
# Make a factor of "favourite veggie"
faveveg <- factor(c("broccoli","carrot","carrot"))
faveveg
factor(faveveg, levels=c("carrot","broccoli"))

# Let's add this to data frame
fam_2023$faveveg <- faveveg
fam_2023

#### Matrices are collections of a single vector type
hours_worked <- matrix(c(c(0,8,9,5,8.5,8.5,1), 
                       c(0,8,8,8,8,8,0),
                       c(0,0,0,0,0,0,0)), ncol=3, dimnames = list(c("Sun","Mon","Tues","Wed","Thurs","Fri","Sat")
                                                          ,c("Melissa","David","Maxine"))
                       )
hours_worked
# Matrices are good for caluculations
colSums(hours_worked) # How many hours this week have we worked?
mins_worked <- hours_worked*60 # What is the number of minutes we have worked?

### Lists are collections of multiple data structures
unnamed_list <- list(b, fam, hours_worked)
unnamed_list
# Calling a data structure in a list
unnamed_list[[1]]

# You can create named lists for easier reference
named_list <- list(family = b, members = fam, work = hours_worked)
named_list
# Calling data structure in a named list
named_list[[1]]
named_list$family
named_list[["family"]]

