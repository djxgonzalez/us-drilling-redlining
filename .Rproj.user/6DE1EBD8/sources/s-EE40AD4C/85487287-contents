##============================================================================##
## 1.3 - function to tidy 1940s census tract data obtained from IPUMS

# cleans and prepares raw 1940s census data
tidyIpumsTractsData <- function(tracts) {
  
  tracts <- tracts %>% 
    mutate(gis_join              = GISJOIN,
           year                  = YEAR,
           state                 = STATE,
           county                = COUNTY,
           tract                 = TRACTA,
           pop_total             = BUB001,
           pop_white             = BUQ001,
           pop_nonwhite          = BUQ002,
           pop_white_usborn      = BU5001,
           pop_white_foreignborn = BVT003 + BVT004,
           pop_black             = BVG001,
           pop_per_home          = BVQ001,
           pop_employed          = BUD001 + BUD002,
           pop_highschoolormore  = BUH006 + BUH007 + BUH008 + 
             BUH015 + BUH016 + BUH017,
           homes_occupied_n      = BVP001) %>%
    dplyr::select(acb:def)
  
  # returns tidied dataset
  return(tracts)
}

##============================================================================##
