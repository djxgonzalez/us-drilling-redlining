##============================================================================##
## assesses exposure to wells and production volume for all HOLC neighborhoods
## at 0 (intersection), 1, and 3 km from the neighborhood boundary; restricted 
## to wells drilled or producing on or before HOLC appraisal for each city


##---------------------------------------------------------------------------
## sets up environment

source("code/2-exposure_assessment/01-fxn_assess_exposure_buffer.R")
library("lubridate")

# data input
holc_cities_buffer_1km_wells_all <- 
  read_csv("data/interim/holc_cities_buffer_1km_wells_all.csv")
holc_cities_buffer_3km_wells_all <- 
  read_csv("data/interim/holc_cities_buffer_3km_wells_all.csv")
holc_cities_year <- read_csv("data/interim/holc_cities_year.csv") %>%
  mutate(city_state = as.factor(paste(city, "-", state)))
holc_neighborhoods <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = as.factor(paste(city, "-", state))) %>%
  left_join(holc_cities_year, by = "city_state") %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%  # shortcut to address issue with dataset
  st_transform(crs_nad83) %>%
  mutate(neighborhood = as.character(neighborho),
         year_appraised = replace_na(year_appraised, 1940)) %>%  # deals with missing data
  distinct(neighborhood, .keep_all = TRUE)

# data prep
cities_near_wells_1km <- holc_cities_buffer_1km_wells_all %>%
  filter(buffer_1km_wells_all_n >= 10)
neighborhoods_near_wells_1km <- holc_neighborhoods %>%
  filter(city_state %in% cities_near_wells_1km$city_state) %>%
  select(neighborhood, year_appraised)
cities_near_wells_3km <- holc_cities_buffer_3km_wells_all %>%
  filter(buffer_3km_wells_all_n >= 10)
neighborhoods_near_wells_3km <- holc_neighborhoods %>%
  filter(city_state %in% cities_near_wells_3km$city_state) %>%
  select(neighborhood, year_appraised)

# analytic wells dataset for this exposure assessment
wells_post1935_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na(longitude) %>%
  filter(spud_date >= as.Date("1935-01-01") |  # post-appraisal date for all cities
           completion_date >= as.Date("1935-01-01") |
           first_prod_date >= as.Date("1935-01-01") |
           last_prod_date  >= as.Date("1935-01-01")) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)

wells_all       <- wells_post1935_sf  %>%
  filter(production_type == "OIL" | 
           production_type == "GAS" |
           production_type == "OIL & GAS" |
           production_type == "INJECTION" |
           production_type == "UNKNOWN")
wells_injection <- wells_post1935_sf %>% 
  filter(production_type == "INJECTION")
wells_oil_gas   <- wells_post1935_sf %>% 
  filter(production_type == "OIL" | 
           production_type == "GAS" |
           production_type == "OIL & GAS")
wells_unknown   <- wells_post1935_sf %>% 
  filter(production_type == "UNKNOWN")


##---------------------------------------------------------------------------
## assesses exposure to all wells for each neighborhood

#.........................................................................
# counts wells within boundary of HOLC neighborhoods (i.e., 0 km buffer)

# initiates tibble
holc_neighborhoods_buffer_0km_wells_all <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA), 
         buffer_0km_wells_all_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_all %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised)  ##### chcek this works
  holc_neighborhoods_buffer_0km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_all,
          "data/interim/holc_neighborhoods_buffer_0km_wells_all_postholc.csv")

#.........................................................................
# counts wells within boundary of HOLC neighborhoods (i.e., 100 m buffer)

# initiates tibble
holc_neighborhoods_buffer_100m_wells_all <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA), 
         buffer_100m_wells_all_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_all %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised)  ##### chcek this works
  holc_neighborhoods_buffer_100m_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_all,
          "data/interim/holc_neighborhoods_buffer_100m_wells_all_postholc.csv")


# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_all <-
#   tibble(neighborhood           = "", 
#          year_appraised         = as.numeric(NA),
#          buffer_1km_wells_all_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
#   wells_in <- wells_all %>%
#     filter(year(spud_date) > year_appraised |  # latest possible date for this
#              year(completion_date) > year_appraised |
#              year(first_prod_date) > year_appraised |
#              year(last_prod_date)  > year_appraised)  ##### chcek this works
#   holc_neighborhoods_buffer_1km_wells_all[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_in,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_all_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_all,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_all_postholc.csv")


##---------------------------------------------------------------------------
## assesses exposure to *injection* wells for each neighborhood

#.........................................................................
# counts wells within boundary of HOLC neighborhoods (i.e., 0 km buffer)

# initiates tibble
holc_neighborhoods_buffer_0km_wells_injection <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA),
         buffer_0km_wells_injection_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_injection %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised) 
  holc_neighborhoods_buffer_0km_wells_injection[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_injection_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_injection,
          "data/interim/holc_neighborhoods_buffer_0km_wells_injection_postholc.csv")

#.........................................................................
# counts wells within boundary of HOLC neighborhoods (i.e., 100 m buffer)

# initiates tibble
holc_neighborhoods_buffer_100m_wells_injection <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA),
         buffer_100m_wells_injection_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_injection %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised) 
  holc_neighborhoods_buffer_100m_wells_injection[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_injection_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_injection,
          "data/interim/holc_neighborhoods_buffer_100m_wells_injection_postholc.csv")

# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_injection <-
#   tibble(neighborhood           = "", 
#          year_appraised         = as.numeric(NA),
#          buffer_1km_wells_injection_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
#   wells_in <- wells_injection %>%
#     filter(year(spud_date) > year_appraised |  # latest possible date for this
#              year(completion_date) > year_appraised |
#              year(first_prod_date) > year_appraised |
#              year(last_prod_date)  > year_appraised)
#   holc_neighborhoods_buffer_1km_wells_injection[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_in,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_injection_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_injection,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_injection_postholc.csv")


##---------------------------------------------------------------------------
## assesses exposure to *oil or gas* wells for each neighborhood

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_0km_wells_oil_gas <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA),
         buffer_0km_wells_oil_gas_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_oil_gas %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised) 
  holc_neighborhoods_buffer_0km_wells_oil_gas[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_oil_gas_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_oil_gas,
          "data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas_postholc.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_oil_gas <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA),
         buffer_100m_wells_oil_gas_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_oil_gas %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised) 
  holc_neighborhoods_buffer_100m_wells_oil_gas[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_oil_gas_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_oil_gas,
          "data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas_postholc.csv")

# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_oil_gas <-
#   tibble(neighborhood           = "", 
#          year_appraised         = as.numeric(NA),
#          buffer_1km_wells_oil_gas_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
#   wells_in <- wells_oil_gas %>%
#     filter(year(spud_date) > year_appraised |  # latest possible date for this
#              year(completion_date) > year_appraised |
#              year(first_prod_date) > year_appraised |
#              year(last_prod_date)  > year_appraised)
#   holc_neighborhoods_buffer_1km_wells_oil_gas[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_in,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_oil_gas_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_oil_gas,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas_postholc.csv")


##---------------------------------------------------------------------------
## assesses exposure to *unknown* wells for each neighborhood

#.........................................................................
# counts wells within 0 km of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_0km_wells_unknown <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA),
         buffer_0km_wells_unknown_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_unknown %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised) 
  holc_neighborhoods_buffer_0km_wells_unknown[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 0,
                              exp_variable   = "buffer_0km_wells_unknown_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_0km_wells_unknown,
          "data/interim/holc_neighborhoods_buffer_0km_wells_unknown_postholc.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_unknown <-
  tibble(neighborhood           = "", 
         year_appraised         = as.numeric(NA),
         buffer_100m_wells_unknown_n = as.numeric(NA))
# loops through exposure assessment function
for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
  year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
  wells_in <- wells_unknown %>%
    filter(year(spud_date) > year_appraised |  # latest possible date for this
             year(completion_date) > year_appraised |
             year(first_prod_date) > year_appraised |
             year(last_prod_date)  > year_appraised) 
  holc_neighborhoods_buffer_100m_wells_unknown[i, ] <- 
    assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
                              data_wells     = wells_in,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_unknown_n")
  print(i)
}
# exports dataset
write_csv(holc_neighborhoods_buffer_100m_wells_unknown,
          "data/interim/holc_neighborhoods_buffer_100m_wells_unknown_postholc.csv")

# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_unknown <-
#   tibble(neighborhood           = "", 
#          year_appraised         = as.numeric(NA),
#          buffer_1km_wells_unknown_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   year_appraised <- neighborhoods_near_wells_1km$year_appraised[i]
#   wells_in <- wells_unknown %>%
#     filter(year(spud_date) > year_appraised |  # latest possible date for this
#              year(completion_date) > year_appraised |
#              year(first_prod_date) > year_appraised |
#              year(last_prod_date)  > year_appraised)
#   holc_neighborhoods_buffer_1km_wells_unknown[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_in,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_unknown_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_unknown,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_unknown_postholc.csv")


##============================================================================##