##============================================================================##
## generates 

##---------------------------------------------------------------------------
## sets up environment

library("ggspatial")
source("code/2-exposure_assessment/01-assess_exposure_buffer_count.R")

# data input
holc_cities <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 0) %>%
  st_transform(crs_nad83) %>%
  group_by(city) %>%
  st_union()
wells_sf <- readRDS("data/interim/wells_interim.rds") %>%
  drop_na("longitude") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)


##---------------------------------------------------------------------------
## assesses exposure to wells for each city

holc_cities_buffer_10km <- tibble(city = "", 
                                  n_wells_buffer_10km = as.numeric(NA))
#for(i in c(1:nrow(holc_cities))) {
for(i in c(1:3)) {
  holc_cities_buffer_10km[i] <- 
    assessExposureBufferCount(data_geography    = holc_cities[i], 
                              data_wells        = wells_sf,
                              buffer_dist_m     = 10000,
                              exp_variable_root = "n_wells_buffer_10km")
  print(i)
}

#.........................................................................
# 


##============================================================================##