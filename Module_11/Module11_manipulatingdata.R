#!/bin/bash 
# install.packages("tidyverse") # Run this in your console first if not installed
library(tidyverse)

# Load metadata
# the read_delim is a version of the other read.delim command but from tidyverse
sampdat <- read_delim(file = "mpt_export/mpt_metadata.tsv", delim = "\t")

# Load your features table
otu <- read_delim(file="mpt_export/feature-table.txt", delim = "\t", skip=1)

# Load your taxonomy file
tax <- read_delim(file = "mpt_export/taxonomy.tsv", delim="\t")

# Load your shannon diversity file
shannon <- read_delim(file="mpt_export/alpha-diversity.tsv", delim="\t")

## Inspect first
# loaded into a 'tibble' format
sampdat
otu
tax
shannon

##### dplyr: for data manipulation #####
# Rename columns in shannon diversity table
rename(shannon, `sample-id`="...1")
shannon <- rename(shannon, `sample-id`="...1")
shannon

# Select columns
sampdat_filt <- select(sampdat, `sample-id`,`body-site`, `year`, `month`, `subject`, `days-since-experiment-start`)
select(otu, `#OTU ID`, starts_with("L1"))

# Filters rows based on values
is.na("hello")
filter(sampdat_filt, !is.na('month'))
filter(sampdat_filt, month>3)
filter(sampdat_filt, !is.na('month'), month>3, `subject`=="subject-1")

# Mutate (change) something
sampdat_filt_adj <- mutate(sampdat_filt, `days-started-corrected`=(`days-since-experiment-start`+10))
sampdat_filt_adj

# Group by and summarize
group_by(sampdat_filt, `subject`)
summarise(group_by(sampdat_filt, `subject`), `average_days` = mean(`days-since-experiment-start`))

# Separate and unite
tax
separate(tax, col=Taxon, sep="; ", into = c("Domain", "Phylum","Class","Order","Family","Genus","Species"))
sampdat_new <- unite(sampdat_filt, col="date", `year`, `month`, sep = "/", remove = FALSE)

# arrange
sort(c(3,1,10))
# negative sign indicates high to low, without it it will sort by low to high
arrange(otu, -L1S105) 

# Join datasets
# will keep all shannon values and remove ones that don't match in the metadata
right_join_df <- right_join(sampdat_filt, shannon)
# keep all metadata and put an NA in non-existing shannon values
left_join_df <- left_join(sampdat_filt, shannon)
#keep all in 
full_join(sampdat_filt, shannon)

#### Piping examples ####
pipe_tax <- separate(tax, col=Taxon, sep="; ", into = c("Domain", "Phylum","Class","Order","Family","Genus","Species")) %>%
  filter(Domain =="d__Bacteria") %>%
  filter(Confidence>0.8) %>%
  unite(col="ScientificName", Genus, Species, remove=FALSE)

sampdat_filt %>%
  select(`subject`) %>%
  table()

### Filter and adjust data

sampdat_filt <- sampdat %>%
  filter(`sample-id` %in% colnames(otu)) %>%
  left_join(shannon) %>%
  filter(!is.na(`month`))

otu_filt <- otu %>% 
  select("#OTU ID", one_of(sampdat_filt$`sample-id`)) 

tax_filt <- tax %>%
  separate(col=Taxon, sep="; "
           , into = c("Kingdom", "Phylum","Class","Order","Family","Genus","Species")) %>%
  filter(`Feature ID` %in% otu_filt$`#OTU ID`)


######### Saving data ##########
save(sampdat_filt, file="sampdat_filt.RData")

write.table(sampdat_filt, file="sample-data.txt", sep="\t", quote = FALSE, row.names = FALSE)

save(otu_filt, file = "otu_filt.RData")
save(tax_filt, file="tax_filt.RData")
