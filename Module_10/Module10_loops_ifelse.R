#!/usr/bin/env Rscript

##### Loops, ifelse statements #######
# This code provides examples of loops and if/else statements
# For loops
# if/else statements
# While loops

#### FOR ####
#for (item in vector) {DO}

for ( x in c(1,2,3)) {
  print("Number")
  print(x)
}

fam <- data.frame(names = c("Melissa","David", "Maxine", "Braelyn")
                  , age = c(103, 103, 1, 7)
                  , human = c(TRUE, TRUE, FALSE, FALSE)
                  , faveveg = c("broccoli","carrot","carrot", NA))
fam
fam$names
for ( r in 1:nrow(fam)) {
  print(fam[r,"names"])
}

#### IF ####

#if (CONDITION) {DO}
#if (CONDITION) {DO} else {DO SOMETHING ELSE}
#if (CONDITION) {DO} else if (CONDITION) {DO THIS} else {DO THIS FINALLY}


x <- 3
if (x < 5) {
  print("X is less than 5")
} else if (x>5) {
  print ("X is greater than 5")
} else {
  print("X is neither less than or greater than 5")
}

# Iterate through names
for ( n in 1:nrow(fam)) {
  name_temp <- fam[n,"names"]
  if (fam[n,"human"]) {
    human_statement <- " is a human"
  } else {
    human_statement <- " is not a human"
  }
  full_statement <- paste(name_temp, human_statement)
  print(full_statement)
}

#### WHILE ####

x <- 1
while ( x < 10 ) {
  print(x)
  x <- x + 1
}

r <- 0
name <- ""
while (name != "David") {
  r <- r + 1
  name <- fam[r,"names"]
}
print(paste("David is in row: ", r))
fam

#### Practice Question ####

# A coded matrix with a jumble of words

coded_matrix <- matrix(c("why","things","themes",
                         "a","what","am","into","bananas",
                         "araid","for","fruit","of","secret",
                         "I","less","crushed","dogs","vacuum",
                         "sucked","table","washroom","clowns",
                         "and","the","adverse","microbiology","tiktok",
                         "being","in","oatmeal","axe","an","liking",
                         "escalators","truecrime","department"),nrow=9, byrow=TRUE)

# The decoder

decoder <- data.frame(row_index = c(4,2,3,3,7,5,2,9)
                      , col_index = c(2,2,1,4,4,3,3,2))

for (d in 1:nrow(decoder)) {
  r <- decoder[d,"row_index"]
  c <- decoder[d,"col_index"]
  x <- coded_matrix[r,c]
  print(x)
}