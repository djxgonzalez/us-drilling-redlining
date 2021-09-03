##============================================================================##
## assesses exposure to wells and production volume for all HOLC neighborhoods
## at both 1 and 3 km from the neighborhood centroid

##---------------------------------------------------------------------------
## sets up environment

source("code/2-exposure_assessment/01-fxn_assess_exposure_buffer.R")

# data input
holc_cities_buffer_1km_wells_all <- 
  read_csv("data/interim/holc_cities_buffer_1km_wells_all.csv")
holc_cities_buffer_3km_wells_all <- 
  read_csv("data/interim/holc_cities_buffer_3km_wells_all.csv")
holc_neighborhoods <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = as.factor(city)) %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%  # shortcut to address issue with dataset
  st_transform(crs_nad83) %>%
  mutate(neighborhood = as.character(neighborho)) %>%
  distinct(neighborhood, .keep_all = TRUE)
wells_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)

# data prep
cities_near_wells_1km <- holc_cities_buffer_1km_wells_all %>%
  filter(buffer_1km_wells_all_n >= 10)
neighborhoods_near_wells_1km <- holc_neighborhoods %>%
  filter(city %in% cities_near_wells_1km$city) %>%
  select(neighborhood) %>%
  st_centroid()
cities_near_wells_3km <- holc_cities_buffer_3km_wells_all %>%
  filter(buffer_3km_wells_all_n >= 10)
neighborhoods_near_wells_3km <- holc_neighborhoods %>%
  filter(city %in% cities_near_wells_3km$city) %>%
  select(neighborhood) %>%
  st_centroid()
wells_producing <- wells_sf %>% filter(cumulative_boe > 0)
wells_injection <- wells_sf %>% filter(production_type == "INJECTION")
wells_oil_gas   <- wells_sf %>% filter(production_type == "OIL" | 
                                         production_type == "GAS" |
                                         production_type == "OIL & GAS")


##---------------------------------------------------------------------------
## assesses exposure to all wells for each neighborhood

#.........................................................................
# counts wells within 1 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_1km_wells_all <-
  tibble(neighborhood = "", 
         buffer_1km_wells_all_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_1km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_sf,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_1km_wells_all,
          "data/interim/holc_neighborhoods_buffer_1km_wells_all.csv")

#.........................................................................
# counts wells within 3 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_3km_wells_all <-
  tibble(neighborhood = "", 
         buffer_3km_wells_all_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_3km))) {
  holc_neighborhoods_buffer_3km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_3km[i, ],
                              data_wells     = wells_sf,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_3km_wells_all,
          "data/interim/holc_neighborhoods_buffer_3km_wells_all.csv")


#---------------------------------------------------------------------------
## assesses exposure to *injection* wells for each neighborhood

#.........................................................................
# counts wells within 1 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_1km_wells_injection <-
  tibble(neighborhood = "", 
         buffer_1km_wells_injection_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_1km_wells_injection[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_injection,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_injection_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_1km_wells_injection,
          "data/interim/holc_neighborhoods_buffer_1km_wells_injection.csv")

#.........................................................................
# counts wells within 3 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_3km_wells_injection <-
  tibble(neighborhood = "", 
         buffer_3km_wells_injection_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_3km))) {
  holc_neighborhoods_buffer_3km_wells_injection[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_3km[i, ],
                              data_wells     = wells_injection,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_injection_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_3km_wells_injection,
          "data/interim/holc_neighborhoods_buffer_3km_wells_injection.csv")


##---------------------------------------------------------------------------
## assesses exposure to *oil or gas* wells for each neighborhood

#.........................................................................
# counts wells within 1 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_1km_wells_oil_gas <-
  tibble(neighborhood = "", 
         buffer_1km_wells_oil_gas_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_1km_wells_oil_gas[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_oil_gas,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_oil_gas_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_1km_wells_oil_gas,
          "data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas.csv")

#.........................................................................
# counts wells within 3 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_3km_wells_oil_gas <-
  tibble(neighborhood = "", 
         buffer_3km_wells_oil_gas_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_3km))) {
  holc_neighborhoods_buffer_3km_wells_oil_gas[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_3km[i, ],
                              data_wells     = wells_oil_gas,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_oil_gas_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_3km_wells_oil_gas,
          "data/interim/holc_neighborhoods_buffer_3km_wells_oil_gas.csv")


##---------------------------------------------------------------------------
## assesses exposure to producing wells for each neighborhood

#.........................................................................
# counts wells within 1 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_1km_wells_producing <-
  tibble(neighborhood = "", 
         buffer_1km_wells_producing_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_1km_wells_producing[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_producing,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_producing_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_1km_wells_producing,
          "data/interim/holc_neighborhoods_buffer_1km_wells_producing.csv")

#.........................................................................
# counts wells within 3 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_3km_wells_producing <-
  tibble(neighborhood = "", 
         buffer_3km_wells_producing_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_3km))) {
  holc_neighborhoods_buffer_3km_wells_producing[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_3km[i, ],
                              data_wells     = wells_producing,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_producing_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_3km_wells_producing,
          "data/interim/holc_neighborhoods_buffer_3km_wells_producing.csv")


##---------------------------------------------------------------------------
## assesses exposure to production volume for each neighborhood

#.........................................................................
# sum production volume within 1 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_1km_prod_boe <-
  tibble(neighborhood = "", 
         buffer_1km_production_boe = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  holc_neighborhoods_buffer_1km_prod_boe[i, ] <- 
    assessExposureBufferVolume(data_geography = neighborhoods_near_wells_1km[i, ],
                               data_wells     = wells_producing,
                               buffer_dist_m  = 1000,
                               exp_variable   = "buffer_1km_production_boe")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_1km_prod_boe,
          "data/interim/holc_neighborhoods_buffer_1km_prod_boe.csv")

#.........................................................................
# sum production volume within 3 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_3km_prod_boe <-
  tibble(neighborhood = "", 
         buffer_3km_production_boe = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_3km))) {
  holc_neighborhoods_buffer_3km_prod_boe[i, ] <- 
    assessExposureBufferVolume(data_geography = neighborhoods_near_wells_3km[i, ],
                               data_wells     = wells_producing,
                               buffer_dist_m  = 3000,
                               exp_variable   = "buffer_3km_production_boe")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_3km_prod_boe,
          "data/interim/holc_neighborhoods_buffer_3km_prod_boe.csv")


##============================================================================##