##============================================================================##
## assesses exposure to wells and production volume for all HOLC neighborhoods
## at both 1 and 3 km from the neighborhood centroid

##---------------------------------------------------------------------------
## sets up environment

source("code/2-exposure_assessment/01-fxn_assess_exposure_buffer.R")

# data input
holc_cities_buffer_100m_wells_all <- 
  read_csv("data/interim/holc_cities_buffer_100m_wells_all.csv")
holc_neighborhoods <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = as.factor(city)) %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%  # shortcut to address issue with dataset
  st_transform(crs_nad83) %>%
  mutate(neighborhood = as.character(neighborho)) %>%
  distinct(neighborhood, .keep_all = TRUE) %>%
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = paste(city, "-", state))
wells_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)

# data prep
cities_near_wells_100m <- holc_cities_buffer_100m_wells_all %>%
  filter(buffer_100m_wells_all_n >= 10)
neighborhoods_near_wells_100m <- holc_neighborhoods %>%
  filter(city_state %in% cities_near_wells_100m$city_state) %>%
  select(neighborhood)

wells_all       <- wells_sf %>% filter(production_type == "OIL" | 
                                         production_type == "GAS" |
                                         production_type == "OIL & GAS" |
                                         production_type == "INJECTION" |
                                         production_type == "UNKNOWN")
wells_injection <- wells_sf %>% filter(production_type == "INJECTION")
wells_oil_gas   <- wells_sf %>% filter(production_type == "OIL" | 
                                         production_type == "GAS" |
                                         production_type == "OIL & GAS")
wells_unknown   <- wells_sf %>% filter(production_type == "UNKNOWN")


##---------------------------------------------------------------------------
## assesses exposure to all wells for each neighborhood

#.........................................................................
# counts wells within 0 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_0km_wells_all <-
  tibble(neighborhood = "", 
         buffer_0km_wells_all_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_0km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_all,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_all,
          "data/interim/holc_neighborhoods_buffer_0km_wells_all_nyc.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_all <-
  tibble(neighborhood = "", 
         buffer_100m_wells_all_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_100m_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_all,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_all,
          "data/interim/holc_neighborhoods_buffer_100m_wells_all_nyc.csv")


#---------------------------------------------------------------------------
## assesses exposure to *injection* wells for each neighborhood

#.........................................................................
# counts wells within 0 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_0km_wells_injection <-
  tibble(neighborhood = "", 
         buffer_0km_wells_injection_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_0km_wells_injection[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_injection,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_injection_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_injection,
          "data/interim/holc_neighborhoods_buffer_0km_wells_injection_nyc.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_injection <-
  tibble(neighborhood = "", 
         buffer_0km_wells_injection_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_100m_wells_injection[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_injection,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_100m_wells_injection_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_injection,
          "data/interim/holc_neighborhoods_buffer_100m_wells_injection_nyc.csv")


##---------------------------------------------------------------------------
## assesses exposure to *oil or gas* wells for each neighborhood

#.........................................................................
# counts wells within 0 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_0km_wells_oil_gas <-
  tibble(neighborhood = "", 
         buffer_0km_wells_oil_gas_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_100m))) {
  holc_neighborhoods_buffer_0km_wells_oil_gas[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_100m[i, ],
                              data_wells     = wells_oil_gas,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_oil_gas_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_oil_gas,
          "data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas_nyc.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_oil_gas <-
  tibble(neighborhood = "", 
         buffer_100m_wells_oil_gas_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_100m_wells_oil_gas[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_oil_gas,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_oil_gas_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_oil_gas,
          "data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas_nyc.csv")

##---------------------------------------------------------------------------
## assesses exposure to *unknown* wells for each neighborhood

#.........................................................................
# counts wells within 0 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_0km_wells_unknown <-
  tibble(neighborhood = "", 
         buffer_0km_wells_unknown_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_0km_wells_unknown[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_unknown,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_unknown_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_unknown,
          "data/interim/holc_neighborhoods_buffer_0km_wells_unknown_nyc.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_unknown <-
  tibble(neighborhood = "", 
         buffer_100m_wells_unknown_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_100m_wells_unknown[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_unknown,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_unknown_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_unknown,
          "data/interim/holc_neighborhoods_buffer_100m_wells_unknown_nyc.csv")

##============================================================================##