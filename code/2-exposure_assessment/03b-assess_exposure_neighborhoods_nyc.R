##============================================================================##
## assesses exposure to wells and production volume for all HOLC neighborhoods
## at both 1 and 3 km from the neighborhood centroid

##---------------------------------------------------------------------------
## sets up environment

source("code/2-exposure_assessment/01-fxn_assess_exposure_buffer.R")

# data input
holc_cities_buffer_100m_wells_all <- 
  read_csv("data/interim/holc_cities_buffer_100m_wells_all.csv")
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
  filter(city_state == "New York City - NY")
#filter(buffer_100m_wells_all_n >= 10)
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
          "data/interim/holc_neighborhoods_buffer_0km_wells_all.csv")

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
          "data/interim/holc_neighborhoods_buffer_100m_wells_all.csv")


# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# # NOTE: we decided not to use a 1 km boundary, but retaining code here in case
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_all <-
#   tibble(neighborhood = "", 
#          buffer_1km_wells_all_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   holc_neighborhoods_buffer_1km_wells_all[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_all,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_all_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_all,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_all.csv")


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
          "data/interim/holc_neighborhoods_buffer_0km_wells_injection.csv")

#.........................................................................
# counts wells within 100 m of boundary of HOLC neighborhoods

# initiates tibble
holc_neighborhoods_buffer_100m_wells_injection <-
  tibble(neighborhood = "", 
         buffer_100m_wells_injection_n = as.numeric(NA))
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
          "data/interim/holc_neighborhoods_buffer_100m_wells_injection.csv")

# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_injection <-
#   tibble(neighborhood = "", 
#          buffer_1km_wells_injection_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   holc_neighborhoods_buffer_1km_wells_injection[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_injection,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_injection_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_injection,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_injection.csv")


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
          "data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas.csv")

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
          "data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas.csv")

# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_oil_gas <-
#   tibble(neighborhood = "", 
#          buffer_1km_wells_oil_gas_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   holc_neighborhoods_buffer_1km_wells_oil_gas[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_oil_gas,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_oil_gas_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_oil_gas,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas.csv")


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
          "data/interim/holc_neighborhoods_buffer_0km_wells_unknown.csv")

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
          "data/interim/holc_neighborhoods_buffer_100m_wells_unknown.csv")

# #.........................................................................
# # counts wells within 1 km of boundary of HOLC neighborhoods
# 
# # initiates tibble
# holc_neighborhoods_buffer_1km_wells_unknown <-
#   tibble(neighborhood = "", 
#          buffer_1km_wells_unknown_n = as.numeric(NA))
# # loops through exposure assessment function
# for(i in c(1:nrow(neighborhoods_near_wells_1km))) {
#   holc_neighborhoods_buffer_1km_wells_unknown[i, ] <- 
#     assessExposureBufferCount(data_geography = neighborhoods_near_wells_1km[i, ],
#                               data_wells     = wells_unknown,
#                               buffer_dist_m  = 1000,
#                               exp_variable   = "buffer_1km_wells_unknown_n")
#   print(i)
# }
# # exports dataset
# write_csv(holc_neighborhoods_buffer_1km_wells_unknown,
#           "data/interim/holc_neighborhoods_buffer_1km_wells_unknown.csv")

##============================================================================##


holc_neighborhoods_buffer_0km_wells_all_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_all_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))
holc_neighborhoods_buffer_0km_wells_injection_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_injection_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))
holc_neighborhoods_buffer_0km_wells_oil_gas_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))
holc_neighborhoods_buffer_0km_wells_unknown_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_unknown_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))
holc_neighborhoods_buffer_100m_wells_all_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_all_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))
holc_neighborhoods_buffer_100m_wells_injection_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_injection_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(buffer_100m_wells_injection_n = buffer_0km_wells_injection_n)
holc_neighborhoods_buffer_100m_wells_oil_gas_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))
holc_neighborhoods_buffer_100m_wells_unknown_nyc <- 
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_unknown_nyc.csv") %>%
  mutate(neighborhood = as.factor(neighborhood))

# adds NYC data to `holc_neighborhoods_exp`` dataset
holc_neighborhoods_exp <- readRDS("data/processed/holc_neighborhoods_exp.rds")

# separate this data for bonding later
holc_not_nyc <- holc_neighborhoods_exp %>%
  filter(city_state != "New York City - NY")

# isolate NYC data and add exp vars
holc_nyc <- holc_neighborhoods_exp %>%
  filter(city_state == "New York City - NY") %>%
  select(-c(wells_0km_all, wells_0km_injection, wells_0km_oil_gas, 
            wells_0km_unknown, wells_100m_all, wells_100m_injection, 
            wells_100m_oil_gas, wells_100m_unknown)) %>%
  left_join(holc_neighborhoods_buffer_0km_wells_all_nyc,
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_0km_wells_injection_nyc,
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_0km_wells_oil_gas_nyc,  
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_0km_wells_unknown_nyc,  
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_100m_wells_all_nyc,      
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_100m_wells_injection_nyc,
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_100m_wells_oil_gas_nyc,  
            by = "neighborhood") %>%
  left_join(holc_neighborhoods_buffer_100m_wells_unknown_nyc,   
            by = "neighborhood") %>%
  rename(wells_0km_all        = buffer_0km_wells_all_n,
         wells_0km_injection  = buffer_0km_wells_injection_n,
         wells_0km_oil_gas    = buffer_0km_wells_oil_gas_n,
         wells_0km_unknown    = buffer_0km_wells_unknown_n,
         wells_100m_all       = buffer_100m_wells_all_n,
         wells_100m_injection = buffer_100m_wells_injection_n,
         wells_100m_oil_gas   = buffer_100m_wells_oil_gas_n,
         wells_100m_unknown   = buffer_100m_wells_unknown_n)

holc_neighborhoods_exp2 <- holc_not_nyc %>% bind_rows(holc_nyc)

holc_neighborhoods_exp2 %>% saveRDS("data/processed/holc_neighborhoods_exp.rds")


##============================================================================##

# takes care of wells counted twice (pre and post-HOLC)
holc_neighborhoods_exp <- readRDS("data/processed/holc_neighborhoods_exp.rds")

##### 0 m
# for binding later
holc_no_miscount_0km <- holc_neighborhoods_exp %>%
  # add indciator for pre-/post-HOLC wells greater than all wells
  mutate(wells_0km_all_pre_post = wells_0km_all_preholc + wells_0km_all_postholc) %>%
  mutate(more_pre_post_wells = 
           case_when(wells_0km_all <  wells_0km_all_pre_post ~ 1,
                     wells_0km_all >= wells_0km_all_pre_post ~ 0)) %>%
  # filter to those neighborhoods
  filter(more_pre_post_wells == 0) %>%
  select(-c(more_pre_post_wells, wells_0km_all_pre_post))
# isolates miscounted wells 0km and fixes them
holc_miscount_0km <- holc_neighborhoods_exp %>%
  # add indciator for pre-/post-HOLC wells greater than all wells
  mutate(wells_0km_all_pre_post = wells_0km_all_preholc + wells_0km_all_postholc) %>%
  mutate(more_pre_post_wells = 
           case_when(wells_0km_all <  wells_0km_all_pre_post ~ 1,
                     wells_0km_all >= wells_0km_all_pre_post ~ 0)) %>%
  # filter to those neighborhoods
  filter(more_pre_post_wells == 1) %>%
  mutate(wells_0km_all_postholc = (wells_0km_all - wells_0km_all_preholc)) %>%
  select(-c(more_pre_post_wells, wells_0km_all_pre_post)) 
holc_neighborhoods_exp2 <- holc_no_miscount_0km %>% bind_rows(holc_miscount_0km) 
# viz to confirm
holc_neighborhoods_exp3 %>% 
  mutate(wells_pre_post = wells_0km_all_preholc + wells_0km_all_postholc) %>%
  ggplot() +
  geom_point(aes(wells_0km_all, wells_pre_post), alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0) + 
  xlim(0, 30) + ylim(0, 30) +
  theme_classic()

##### 100 m
# for binding later
holc_no_miscount_100m <- holc_neighborhoods_exp2 %>%
  # add indciator for pre-/post-HOLC wells greater than all wells
  mutate(wells_100m_all_pre_post = wells_100m_all_preholc + wells_100m_all_postholc) %>%
  mutate(more_pre_post_wells = 
           case_when(wells_100m_all <  wells_100m_all_pre_post ~ 1,
                     wells_100m_all >= wells_100m_all_pre_post ~ 0)) %>%
  # filter to those neighborhoods
  filter(more_pre_post_wells == 0) %>%
  select(-c(more_pre_post_wells, wells_100m_all_pre_post))
# isolates miscounted wells 100m and fixes them
holc_miscount_100m <- holc_neighborhoods_exp2 %>%
  # add indciator for pre-/post-HOLC wells greater than all wells
  mutate(wells_100m_all_pre_post = wells_100m_all_preholc + wells_100m_all_postholc) %>%
  mutate(more_pre_post_wells = 
           case_when(wells_100m_all <  wells_100m_all_pre_post ~ 1,
                     wells_100m_all >= wells_100m_all_pre_post ~ 0)) %>%
  # filter to those neighborhoods
  filter(more_pre_post_wells == 1) %>%
  mutate(wells_100m_all_postholc = (wells_100m_all - wells_100m_all_preholc)) %>%
  select(-c(more_pre_post_wells, wells_100m_all_pre_post)) 
holc_neighborhoods_exp3 <- holc_no_miscount_100m %>% bind_rows(holc_miscount_100m) 
# viz to confirm
holc_neighborhoods_exp3 %>% 
  mutate(wells_pre_post = wells_100m_all_preholc + wells_100m_all_postholc) %>%
  ggplot() +
  geom_point(aes(wells_100m_all, wells_pre_post), alpha = 0.1) +
  geom_abline(slope = 1, intercept = 0) + 
  xlim(0, 30) + ylim(0, 30) +
  theme_classic()

holc_neighborhoods_exp3 %>% saveRDS("data/processed/holc_neighborhoods_exp.rds")

##============================================================================##