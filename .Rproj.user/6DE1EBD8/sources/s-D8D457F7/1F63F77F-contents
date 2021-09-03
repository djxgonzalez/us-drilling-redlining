##============================================================================##
## assesses exposure to wells and production volume for all HOLC neighborhoods
## at both 1 and 3 km from the neighborhood centroid; restricted to wells
## drilled or producing on or before 12/31/1934 (assuming HOLC grading happened
## in 1935)

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
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = as.factor(paste(city, "-", state))) %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%  # shortcut to address issue with dataset
  st_transform(crs_nad83) %>%
  mutate(neighborhood = as.character(neighborho)) %>%
  distinct(neighborhood, .keep_all = TRUE)

# data prep

# makes dataset of post-1935 wells, excluded wells with any pre-1935 activity
wells_pre1935 <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  filter(spud_date <= as.Date("1934-12-31") | 
           completion_date <= as.Date("1934-12-31") |
           first_prod_date <= as.Date("1934-12-31") |
           last_prod_date  <= as.Date("1934-12-31"))
wells_post1935_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  filter(spud_date >= as.Date("1935-01-01") | 
           completion_date >= as.Date("1935-01-01") |
           first_prod_date >= as.Date("1935-01-01") |
           last_prod_date  >= as.Date("1935-01-01")) %>%
  filter(api_number %!in% wells_pre1935$api_number) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)

cities_near_wells_1km <- holc_cities_buffer_1km_wells_all %>%
  filter(buffer_1km_wells_all_n >= 10)
neighborhoods_near_wells_1km <- holc_neighborhoods %>%
  filter(city_state %in% cities_near_wells_1km$city_state) %>%
  select(neighborhood) %>%
  st_centroid()
cities_near_wells_3km <- holc_cities_buffer_3km_wells_all %>%
  filter(buffer_3km_wells_all_n >= 10)
neighborhoods_near_wells_3km <- holc_neighborhoods %>%
  filter(city_state %in% cities_near_wells_3km$city_state) %>%
  select(neighborhood) %>%
  st_centroid()
wells_producing <- wells_post1935_sf %>% filter(cumulative_boe > 0)
wells_injection <- wells_post1935_sf %>% filter(production_type == "INJECTION")
wells_oil_gas   <- wells_post1935_sf %>% filter(production_type == "OIL" | 
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
                              data_wells     = wells_post1935_sf,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_1km_wells_all,
          "data/interim/holc_neighborhoods_buffer_1km_wells_all_post1935.csv")

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
                              data_wells     = wells_post1935_sf,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_3km_wells_all,
          "data/interim/holc_neighborhoods_buffer_3km_wells_all_post1935.csv")


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
          "data/interim/holc_neighborhoods_buffer_1km_wells_injection_post1935.csv")

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
          "data/interim/holc_neighborhoods_buffer_3km_wells_injection_post1935.csv")


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
          "data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas_post1935.csv")

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
          "data/interim/holc_neighborhoods_buffer_3km_wells_oil_gas_post1935.csv")


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
          "data/interim/holc_neighborhoods_buffer_1km_wells_producing_post1935.csv")

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
          "data/interim/holc_neighborhoods_buffer_3km_wells_producing_post1935.csv")


##============================================================================##