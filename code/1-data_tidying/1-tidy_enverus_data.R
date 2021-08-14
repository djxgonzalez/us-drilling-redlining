##============================================================================##
## 1.1 - function to tidy the Enverus wells data

# cleans and prepares raw Enverus input data for further analysis
tidyEnverusWellsData <- function(wells) {
  
  # captures well coordinates so we can re-join them later
  wells <- wells %>% 
    mutate(api_number      = as.factor(API14),
           county_parish   = as.factor(`County/Parish`),
           state           = as.factor(State),
           latitude        = `Surface Hole Latitude (WGS84)`,
           longitude       = `Surface Hole Longitude (WGS84)`,
           cumulative_boe  = `Cum BOE`,  # BOE = barrels of oil equivalent
           production_type = `Production Type`,
           spud_date       = `Spud Date`, #Spud Date = date the well was 1st drilled 
           completion_date = `Completion Date`, 
           first_prod_date = `First Prod Date`, #1st date of production
           last_prod_date  = `Last Prod Date`, #Last date of production
           months_prod     = `Months Produced`, # Total months of production
           well_status     = as.factor(`Well Status`)) %>%
    dplyr::select(api_number:well_status)
  
  # returns tidied dataset
  return(wells)
}

##============================================================================##
