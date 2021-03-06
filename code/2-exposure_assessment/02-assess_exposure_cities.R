##============================================================================##
## generates 

##---------------------------------------------------------------------------
## sets up environment

source("code/2-exposure_assessment/01-fxn_assess_exposure_buffer.R")

# data input
holc_cities <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = as.factor(paste(city, "-", state))) %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%  # shortcut to address issue with dataset
  st_transform(crs_nad83) %>%
  group_by(city_state) %>%
  summarize() %>%
  as_tibble() %>%  # need to do this to resolve `grouped_df` error
  st_as_sf()
wells_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)
wells_pre1935_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  filter(spud_date <= as.Date("1934-12-31") | 
           completion_date <= as.Date("1934-12-31") |
           first_prod_date <= as.Date("1934-12-31") |
           last_prod_date  <= as.Date("1934-12-31")) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)
wells_post1935_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  filter(spud_date >= as.Date("1935-01-01") | 
           completion_date >= as.Date("1935-01-01") |
           first_prod_date >= as.Date("1935-01-01") |
           last_prod_date  >= as.Date("1935-01-01")) %>%
  filter(api_number %!in% wells_pre1935_sf$api_number) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)


##---------------------------------------------------------------------------
## assesses exposure to wells for each city

#.........................................................................
# counts wells within 10 km of boundary of HOLC cities
holc_cities_buffer_10km_wells_all <-
  tibble(city_state = "", buffer_10km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_10km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_sf,
                              buffer_dist_m  = 10000,
                              exp_variable   = "buffer_10km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_10km_wells_all,
          "data/interim/holc_cities_buffer_10km_wells_all.csv")

#.........................................................................
# counts wells within 3 km of boundary of HOLC cities

holc_cities_buffer_3km_wells_all <- 
  tibble(city_state = "", buffer_3km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_3km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_sf,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_3km_wells_all,
          "data/interim/holc_cities_buffer_3km_wells_all.csv")

#.........................................................................
# counts wells within 1 km of boundary of HOLC cities
holc_cities_buffer_1km_wells_all <- 
  tibble(city_state = "", buffer_1km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_1km_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_sf,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_1km_wells_all,
          "data/interim/holc_cities_buffer_1km_wells_all.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC cities
holc_cities_buffer_100m_wells_all <- 
  tibble(city_state = "", buffer_100m_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_100m_wells_all[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_sf,
                              buffer_dist_m  = 100,
                              exp_variable   = "buffer_100m_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_100m_wells_all,
          "data/interim/holc_cities_buffer_100m_wells_all.csv")


##---------------------------------------------------------------------------
## assesses exposure to wells in preproduction or produciton before 1935

#.........................................................................
# counts wells within 3 km of boundary of HOLC cities
holc_cities_buffer_3km_wells_all_pre1935 <- 
  tibble(city_state = "", buffer_3km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_3km_wells_all_pre1935[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_pre1935_sf,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_3km_wells_all_pre1935,
          "data/interim/holc_cities_buffer_3km_wells_all_pre1935.csv")

#.........................................................................
# counts wells within 1 km of boundary of HOLC cities
holc_cities_buffer_1km_wells_all_pre1935 <- 
  tibble(city_state = "", buffer_1km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_1km_wells_all_pre1935[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_pre1935_sf,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_1km_wells_all_pre1935,
          "data/interim/holc_cities_buffer_1km_wells_all_pre1935.csv")


##---------------------------------------------------------------------------
## assesses exposure to wells in preproduction or produciton after 1935

#.........................................................................
# counts wells within 3 km of boundary of HOLC cities
holc_cities_buffer_3km_wells_all_post1935 <- 
  tibble(city_state = "", buffer_3km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_3km_wells_all_post1935[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_post1935_sf,
                              buffer_dist_m  = 3000,
                              exp_variable   = "buffer_3km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_3km_wells_all_post1935,
          "data/interim/holc_cities_buffer_3km_wells_all_post1935.csv")

#.........................................................................
# counts wells within 1 km of boundary of HOLC cities
holc_cities_buffer_1km_wells_all_post1935 <- 
  tibble(city_state = "", buffer_1km_wells_all_n = as.numeric(NA))
for(i in c(1:nrow(holc_cities))) {
  holc_cities_buffer_1km_wells_all_post1935[i, ] <- 
    assessExposureBufferCount(data_geography = holc_cities[i, ],
                              data_wells     = wells_post1935_sf,
                              buffer_dist_m  = 1000,
                              exp_variable   = "buffer_1km_wells_all_n")
  print(i)
}
# exports dataset
write_csv(holc_cities_buffer_1km_wells_all_post1935,
          "data/interim/holc_cities_buffer_1km_wells_all_post1935.csv")

##============================================================================##