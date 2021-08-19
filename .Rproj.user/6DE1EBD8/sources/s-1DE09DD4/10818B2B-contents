##============================================================================##
## generates 

##---------------------------------------------------------------------------
## sets up environment

library("ggspatial")
source("code/2-exposure_assessment/01-assess_exposure_buffer_count.R")

# data input
holc_cities <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = as.factor(city)) %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%  # shortcut to address issue with dataset
  st_transform(crs_nad83) %>%
  group_by(city) %>%
  summarize()  # alternatively: summarize(geometry = st_union(geometry))
wells_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)


##---------------------------------------------------------------------------
## assesses exposure to wells for each city

#.........................................................................
# counts wells within 10 km of boundary of HOLC cities
holc_cities_buffer_10km_wells_all <- tibble(city = "", 
                                  buffer_10km_wells_all_n = as.numeric(NA))
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
holc_cities_buffer_3km_wells_all <- tibble(city = "", 
                                            buffer_3km_wells_all_n = as.numeric(NA))
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
holc_cities_buffer_1km_wells_all <- tibble(city = "", 
                                            buffer_1km_wells_all_n = as.numeric(NA))
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


##============================================================================##