##============================================================================##
## 3 - appending propensity score datasets into one principal dataset with all covariates

#==============================

#==============================
#Packages needed
library(tidyverse)
#==============================

#==============================
#Import separate datasets (all observations w/o prop scores) + three pairwise prop score datasets + subset to variables of interest

all_obs <- readRDS("~/Box/us redlining drilling/us-drilling-redlining/data/interim/propensity score data/holc_neighborhoods_exp.rds")

ab <- readRDS("~/Box/us redlining drilling/us-drilling-redlining/data/processed/propensity_scores_ab.rds") %>%
  rename("ab_score" = "score") %>%
  dplyr::select(c("neighborhood", "ab_score"))

bc <- readRDS("~/Box/us redlining drilling/us-drilling-redlining/data/processed/propensity_scores_bc.rds") %>%
  rename("bc_score" = "score") %>%
  dplyr::select(c("neighborhood", "bc_score"))

cd <- readRDS("~/Box/us redlining drilling/us-drilling-redlining/data/processed/propensity_scores_cd.rds") %>%
  rename("cd_score" = "score") %>%
  dplyr::select(c("neighborhood", "cd_score"))


#Append datasets to all observations

data <- left_join(all_obs, ab, by = "neighborhood")

data <- left_join(data, bc, by = "neighborhood")

data <- left_join(data, cd, by = "neighborhood")

#Save df as rds
saveRDS(data, file = "./data/processed/holc_neighborhoods_all_propensity_scores.rds")
