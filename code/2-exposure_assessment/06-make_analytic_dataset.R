##============================================================================##
## binds exposure data together

##---------------------------------------------------------------------------
## sets up environment

# HOLC neighborhoods data
holc_cities_year <- read_csv("data/interim/holc_cities_year.csv") %>%
  mutate(city_state = as.factor(paste(city, "-", state))) %>%
  select(-city, -state)

# HOLC census data from Nardone et al.
holc_census_1940 <-  # 1940s census variables apportioned to HOLC neighborhoods
  read_csv("data/interim/GSxHOLC_Oct20.csv") %>%
  rename(neighborhood = neighborho) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  select(-city, -school_uni, -school_uni.1, -state, - holc_id, - holc_grade,
         -area_descr, -name)
# old code
# holc_census_1940 <-  # 1940s census variables apportioned to HOLC neighborhoods
#   st_read("data/interim/propensity score data/holc_census_1940.shp") %>%
#   as_tibble() %>%
#   select(-geometry) %>%
#   # we can use the centroid coordinates (X, Y) to link these data with
#   # the HOLC neighborhoods exposure data; there's no other linking variable;
#   # we need to make sure they both have 5 digits after the decimal
#   mutate(X = case_when(X >  -100 ~ signif(X, digits = 7),
#                        X <= -100 ~ signif(X, digits = 8)),
#          Y = signif(Y, digits = 7))

holc_neighborhoods <-
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp")
holc_neighborhoods <- holc_neighborhoods %>%
  mutate(area_sqkm = (as.numeric(st_area(holc_neighborhoods)) / 1000000)) %>%
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = as.factor(paste(city, "-", state))) %>%
  left_join(holc_cities_year, by = "city_state") %>%
  mutate(neighborhood = as.factor(neighborho)) %>%
  distinct(neighborhood, .keep_all = TRUE) %>%
  select(-neighborho)
holc_neighborhoods <- holc_neighborhoods %>% 
  # old code
  # mutate(X = st_coordinates(holc_neighborhoods)[, 1],
  #        Y = st_coordinates(holc_neighborhoods)[, 2]) %>%
  # mutate(X = case_when(X >  -100 ~ signif(X, digits = 7),
  #                      X <= -100 ~ signif(X, digits = 8)),
  #        Y = signif(Y, digits = 7)) %>%
  left_join(holc_census_1940, by = "neighborhood") %>%
  # removes extraneous variables from prior study
  select(-ecoregion, -(winter:fall)) %>%
  mutate(has_census_data = case_when(is.na(pop40_w) ~ 0, 
                                     pop40_w >= 0   ~ 1))

# exposure data --------------------------------------------------------------

# city-level exposure
holc_cities_wells_1km <- 
  read_csv("data/interim/holc_cities_buffer_1km_wells_all.csv") %>%
  rename(city_wells_1km_all = buffer_1km_wells_all_n)

holc_cities_exposure_100m <- 
  read_csv("data/interim/holc_cities_buffer_100m_wells_all.csv") %>%
  #filter(buffer_100m_wells_all_n >= 10) %>%
  rename(city_wells_100m_all = buffer_100m_wells_all_n)
holc_cities_exposure_1km <- 
  read_csv("data/interim/holc_cities_buffer_1km_wells_all.csv") %>%
  #filter(buffer_1km_wells_all_n >= 10) %>%
  rename(city_wells_1km_all = buffer_1km_wells_all_n)


#...........................................................................
# wells within neighborhood (i.e., 0 km buffer)

buffer_0km_wells_all <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_all.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_all = buffer_0km_wells_all_n)
buffer_0km_wells_injection <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_injection.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_injection = buffer_0km_wells_injection_n)
buffer_0km_wells_oil_gas <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_oil_gas = buffer_0km_wells_oil_gas_n)
buffer_0km_wells_unknown <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_unknown.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_unknown = buffer_0km_wells_unknown_n)

# pre-HOLC appraisal
buffer_0km_wells_all_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_all_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_all_preholc = buffer_0km_wells_all_n)
buffer_0km_wells_injection_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_injection_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_injection_preholc = buffer_0km_wells_injection_n)
buffer_0km_wells_oil_gas_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>% 
  rename(wells_0km_oil_gas_preholc = buffer_0km_wells_oil_gas_n)
buffer_0km_wells_unknown_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_unknown_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_unknown_preholc = buffer_0km_wells_unknown_n)

# post-HOLC appraisal
buffer_0km_wells_all_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_all_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_all_postholc = buffer_0km_wells_all_n)
buffer_0km_wells_injection_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_injection_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_injection_postholc = buffer_0km_wells_injection_n)
buffer_0km_wells_oil_gas_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_oil_gas_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_oil_gas_postholc = buffer_0km_wells_oil_gas_n)
buffer_0km_wells_unknown_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_0km_wells_unknown_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_0km_unknown_postholc = buffer_0km_wells_unknown_n)

#...........................................................................
# wells within 100 m of neighborhood (i.e., 100 m buffer) 

buffer_100m_wells_all <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_all.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_all = buffer_100m_wells_all_n)
buffer_100m_wells_injection <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_injection.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_injection = buffer_0km_wells_injection_n)
buffer_100m_wells_oil_gas <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_oil_gas = buffer_100m_wells_oil_gas_n)
buffer_100m_wells_unknown <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_unknown.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_unknown = buffer_100m_wells_unknown_n)

# pre-HOLC appraisal
buffer_100m_wells_all_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_all_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_all_preholc = buffer_100m_wells_all_n)
buffer_100m_wells_injection_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_injection_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_injection_preholc = buffer_100m_wells_injection_n)
buffer_100m_wells_oil_gas_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_oil_gas_preholc = buffer_100m_wells_oil_gas_n)
buffer_100m_wells_unknown_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_unknown_preholc.csv") %>%
  select(-year_appraised)  %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_unknown_preholc = buffer_100m_wells_unknown_n)

# post-HOLC appraisal
buffer_100m_wells_all_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_all_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_all_postholc = buffer_100m_wells_all_n)
buffer_100m_wells_injection_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_injection_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_injection_postholc = buffer_100m_wells_injection_n)
buffer_100m_wells_oil_gas_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_oil_gas_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_oil_gas_postholc = buffer_100m_wells_oil_gas_n)
buffer_100m_wells_unknown_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_100m_wells_unknown_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_100m_unknown_postholc = buffer_100m_wells_unknown_n)


#...........................................................................
# wells within 1 km of neighborhood (i.e., 1 km buffer)

buffer_1km_wells_all <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_all.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_all = buffer_1km_wells_all_n)
buffer_1km_wells_injection <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_injection.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_injection = buffer_1km_wells_injection_n)
buffer_1km_wells_oil_gas <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_oil_gas = buffer_1km_wells_oil_gas_n)
buffer_1km_wells_unknown <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_unknown.csv") %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_unknown = buffer_1km_wells_unknown_n)

# pre-HOLC appraisal
buffer_1km_wells_all_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_all_preholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_all_preholc = buffer_1km_wells_all_n) 
buffer_1km_wells_injection_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_injection_preholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_injection_preholc = buffer_1km_wells_injection_n) 
buffer_1km_wells_oil_gas_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas_preholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_oil_gas_preholc = buffer_1km_wells_oil_gas_n) 
buffer_1km_wells_unknown_preholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_unknown_preholc.csv") %>%
  select(-year_appraised) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_unknown_preholc = buffer_1km_wells_unknown_n) 

# post-HOLC appraisal
buffer_1km_wells_all_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_all_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(buffer_1km_wells_all_n = replace_na(buffer_1km_wells_all_n, 0)) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_all_postholc = buffer_1km_wells_all_n)
buffer_1km_wells_injection_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_injection_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(buffer_1km_wells_injection_n = replace_na(buffer_1km_wells_injection_n, 0)) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_injection_postholc = buffer_1km_wells_injection_n)
buffer_1km_wells_oil_gas_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_oil_gas_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(buffer_1km_wells_oil_gas_n = replace_na(buffer_1km_wells_oil_gas_n, 0)) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_oil_gas_postholc = buffer_1km_wells_oil_gas_n)
buffer_1km_wells_unknown_postholc <-
  read_csv("data/interim/holc_neighborhoods_buffer_1km_wells_unknown_postholc.csv") %>%
  select(-year_appraised) %>%
  mutate(buffer_1km_wells_unknown_n = replace_na(buffer_1km_wells_unknown_n, 0)) %>%
  mutate(neighborhood = as.factor(neighborhood)) %>%
  rename(wells_1km_unknown_postholc = buffer_1km_wells_unknown_n)

##---------------------------------------------------------------------------
## assembles and exports analytic dataset

holc_neighborhoods_exp <- holc_neighborhoods %>%
  as_tibble() %>%
  select(-geometry) %>%
  # joins city-level wells exposure data
  left_join(holc_cities_exposure_100m, by = "city_state") %>%
  left_join(holc_cities_exposure_1km,  by = "city_state") %>%
  # exposure to wells within neighborhood boundary, i.e., 0 m buffer
  left_join(buffer_0km_wells_all,                 by = "neighborhood") %>%
  left_join(buffer_0km_wells_all_preholc,         by = "neighborhood") %>%
  left_join(buffer_0km_wells_all_postholc,        by = "neighborhood") %>%
  left_join(buffer_0km_wells_injection,           by = "neighborhood") %>%
  left_join(buffer_0km_wells_injection_preholc,   by = "neighborhood") %>%
  left_join(buffer_0km_wells_injection_postholc,  by = "neighborhood") %>%
  left_join(buffer_0km_wells_oil_gas,             by = "neighborhood") %>%
  left_join(buffer_0km_wells_oil_gas_preholc,     by = "neighborhood") %>%
  left_join(buffer_0km_wells_oil_gas_postholc,    by = "neighborhood") %>%
  left_join(buffer_0km_wells_unknown,             by = "neighborhood") %>%
  left_join(buffer_0km_wells_unknown_preholc,     by = "neighborhood") %>%
  left_join(buffer_0km_wells_unknown_postholc,    by = "neighborhood") %>%
  # exposure to wells within 100 m buffer of neighborhood boundary
  left_join(buffer_100m_wells_all,                by = "neighborhood") %>%
  left_join(buffer_100m_wells_all_preholc,        by = "neighborhood") %>%
  left_join(buffer_100m_wells_all_postholc,       by = "neighborhood") %>%
  left_join(buffer_100m_wells_injection,          by = "neighborhood") %>%
  left_join(buffer_100m_wells_injection_preholc,  by = "neighborhood") %>%
  left_join(buffer_100m_wells_injection_postholc, by = "neighborhood") %>%
  left_join(buffer_100m_wells_oil_gas,            by = "neighborhood") %>%
  left_join(buffer_100m_wells_oil_gas_preholc,    by = "neighborhood") %>%
  left_join(buffer_100m_wells_oil_gas_postholc,   by = "neighborhood") %>%
  left_join(buffer_100m_wells_unknown,            by = "neighborhood") %>%
  left_join(buffer_100m_wells_unknown_preholc,    by = "neighborhood") %>%
  left_join(buffer_100m_wells_unknown_postholc,   by = "neighborhood") %>%
  # exposure to wells within 1 km buffer of neighborhood boundary
  left_join(buffer_1km_wells_all,                 by = "neighborhood") %>%
  left_join(buffer_1km_wells_all_preholc,         by = "neighborhood") %>%
  left_join(buffer_1km_wells_all_postholc,        by = "neighborhood") %>%
  left_join(buffer_1km_wells_injection,           by = "neighborhood") %>%
  left_join(buffer_1km_wells_injection_preholc,   by = "neighborhood") %>%
  left_join(buffer_1km_wells_injection_postholc,  by = "neighborhood") %>%
  left_join(buffer_1km_wells_oil_gas,             by = "neighborhood") %>%
  left_join(buffer_1km_wells_oil_gas_preholc,     by = "neighborhood") %>%
  left_join(buffer_1km_wells_oil_gas_postholc,    by = "neighborhood") %>%
  left_join(buffer_1km_wells_unknown,             by = "neighborhood") %>%
  left_join(buffer_1km_wells_unknown_preholc,     by = "neighborhood") %>%
  left_join(buffer_1km_wells_unknown_postholc,    by = "neighborhood") %>%
  # replaces NAs with 0s
  mutate(wells_0km_all                 = replace_na(wells_0km_all,                 0),
         wells_0km_all_preholc         = replace_na(wells_0km_all_preholc,         0),
         wells_0km_all_postholc        = replace_na(wells_0km_all_postholc,        0),
         wells_0km_injection           = replace_na(wells_0km_injection,           0),
         wells_0km_injection_preholc   = replace_na(wells_0km_injection_preholc,   0),
         wells_0km_injection_postholc  = replace_na(wells_0km_injection_postholc,  0),
         wells_0km_oil_gas             = replace_na(wells_0km_oil_gas,             0),
         wells_0km_oil_gas_preholc     = replace_na(wells_0km_oil_gas_preholc,     0),
         wells_0km_oil_gas_postholc    = replace_na(wells_0km_oil_gas_postholc,    0),
         wells_0km_unknown             = replace_na(wells_0km_unknown,             0),
         wells_0km_unknown_preholc     = replace_na(wells_0km_unknown_preholc,     0),
         wells_0km_unknown_postholc    = replace_na(wells_0km_unknown_postholc,    0),
         wells_100m_all                = replace_na(wells_100m_all,                0),
         wells_100m_all_preholc        = replace_na(wells_100m_all_preholc,        0),
         wells_100m_all_postholc       = replace_na(wells_100m_all_postholc,       0),
         wells_100m_injection          = replace_na(wells_100m_injection,          0),
         wells_100m_injection_preholc  = replace_na(wells_100m_injection_preholc,  0),
         wells_100m_injection_postholc = replace_na(wells_100m_injection_postholc, 0),
         wells_100m_oil_gas            = replace_na(wells_100m_oil_gas,            0),
         wells_100m_oil_gas_preholc    = replace_na(wells_100m_oil_gas_preholc,    0),
         wells_100m_oil_gas_postholc   = replace_na(wells_100m_oil_gas_postholc,   0),
         wells_100m_unknown            = replace_na(wells_100m_unknown,            0),
         wells_100m_unknown_preholc    = replace_na(wells_100m_unknown_preholc,    0),
         wells_100m_unknown_postholc   = replace_na(wells_100m_unknown_postholc,   0),
         wells_1km_all                 = replace_na(wells_1km_all,                 0),
         wells_1km_all_preholc         = replace_na(wells_1km_all_preholc,         0),
         wells_1km_all_postholc        = replace_na(wells_1km_all_postholc,        0),
         wells_1km_injection           = replace_na(wells_1km_injection,           0),
         wells_1km_injection_preholc   = replace_na(wells_1km_injection_preholc,   0),
         wells_1km_injection_postholc  = replace_na(wells_1km_injection_postholc,  0),
         wells_1km_oil_gas             = replace_na(wells_1km_oil_gas,             0),
         wells_1km_oil_gas_preholc     = replace_na(wells_1km_oil_gas_preholc,     0),
         wells_1km_oil_gas_postholc    = replace_na(wells_1km_oil_gas_postholc,    0),
         wells_1km_unknown             = replace_na(wells_1km_unknown,             0),
         wells_1km_unknown_preholc     = replace_na(wells_1km_unknown_preholc,     0),
         wells_1km_unknown_postholc    = replace_na(wells_1km_unknown_postholc,    0))

# it appears that some of the HOLC neighborhoods may be duplicated, but the
# duplicated rows are missing census data and don't have wells so we don't
# need to worry about them
holc_neighborhoods_exp <- holc_neighborhoods_exp %>%
  filter(area_sqkm > 0) %>%
  distinct(neighborhood, .keep_all = TRUE)

saveRDS(holc_neighborhoods_exp, "data/processed/holc_neighborhoods_exp.rds")


##============================================================================##