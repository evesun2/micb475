#!/usr/bin/env Rscript

# Load metadata
# read.delim(file=FILEPATH, sep=DELIMITER)

sampdatFP  <- "mpt_export/mpt_metadata.tsv"
sampdat <- read.delim(file = sampdatFP, sep = "\t")


otufp  <- "mpt_export/table_export/feature-table.txt"
otu <- read.delim(file=otufp, sep = "\t", skip=1, row.names = 1)

# View metadata
sampdat
str(sampdat)
sampdat$sample.id
head(sampdat)

# Look at OTU table by clicking object in environment box

# What is the most abundant ASV, and how many reads does it have?
sumReads_byASV <- rowSums(otu)
# Find max using which.max, then index 
i <- which.max(sumReads_byASV)
sumReads_byASV[i]
# Or, you can sort and get first value
sort(sumReads_byASV, decreasing = TRUE)[1]

# What is the sample with the most reads?
colSums(otu) # Column sums of reads
sort(colSums(otu), decreasing = TRUE) # Sort in decreasing order
names(sort(colSums(otu), decreasing = TRUE)) # Find names of sorted vector
names(sort(colSums(otu), decreasing = TRUE))[1] # Find first name of sorted vector

# What body site does the sample with the most reads belong to?
mostreads_sample <- names(sort(colSums(otu), decreasing = TRUE))[1]
whichRow <- sampdat$sample.id == mostreads_sample # Which row matches the sample?
sampdat[whichRow, "body.site"] # Find transect name by indexing row

