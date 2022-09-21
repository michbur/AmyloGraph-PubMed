library(dplyr)

# seed: hour of submission

set.seed(22092022)

dat <- rbind(read.csv("inhibition.csv"),
      read.csv("interaction.csv"),
      read.csv("seeding.csv")) %>% 
  select(DOI, Title) %>% 
  mutate(DOI = tolower(DOI))

# number of all articles
dim(dat)

# articles present in the AmyloGraph database
sum(dat[["DOI"]] %in% unique(tolower(AmyloGraph::ag_data_interactions[["doi"]])))

# 200 randomly sampled publications
part_dat <- filter(dat, !(DOI %in% unique(tolower(AmyloGraph::ag_data_interactions[["doi"]])))) %>% 
  slice(sample(1L:nrow(.), 200)) %>% 
  mutate(relevant = "") 

write.csv(part_dat, "relevant.csv", row.names = FALSE)


