##============================================================================##
## makes Figure 1 - (a) map of U.S. with study cities; (b) barplot of n wells
## near HOLC-graded neighborhoods; (c) barplot of production volume


##---------------------------------------------------------------------------
## sets up environment

library("ggdark")
library("ggrepel")
library("ggspatial")

# data input, prep layers for mapping ......................................

#cities_holc_census <- holc_cities_exposure_100m %>%
cities_holc_census <- readRDS("data/processed/holc_neighborhoods_exp.rds") %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  select(city_state, city_wells_100m_all, pop40_w) %>%
  filter(city_wells_100m_all >= 10) %>%
  drop_na(pop40_w) %>%
  distinct(city_state, .keep_all = TRUE)

cities_holc_nocensus <- readRDS("data/processed/holc_neighborhoods_exp.rds") %>%
  select(city_state, city_wells_100m_all, pop40_w) %>%
  filter(city_wells_100m_all >= 10) %>%
  filter(city_state %!in% cities_holc_census$city_state) %>%
  distinct(city_state, .keep_all = TRUE)

cities_holc_census_sf <- # cities with at least 1 well within 100 m
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = paste(city, "-", state)) %>%
  as_tibble() %>%
  distinct(city_state, .keep_all = TRUE) %>%
  filter(city_state %in% cities_holc_census$city_state) %>%
  st_as_sf() %>%
  st_transform(crs_nad83)

cities_holc_nocensus_sf <- # cities with at least 1 well within 100 m
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city = ifelse(city == "Bronx" | city == "Brooklyn" |  # combines NY boroughs
                         city == "Manhattan" | city == "Staten Island" |
                         city == "Queens", "New York City", city )) %>%
  mutate(city_state = paste(city, "-", state)) %>%
  as_tibble() %>%
  distinct(city_state, .keep_all = TRUE) %>%
  filter(city_state %!in% cities_holc_nocensus$city_state) %>%
  st_as_sf() %>%
  st_transform(crs_nad83)

oil_basin_union <- 
  st_read("data/raw/us_eia/SedimentaryBasins_US_EIA/SedimentaryBasins_US_May2011_v2.shp") %>%
  st_transform(crs_nad83) %>%
  st_union()
lakes <- st_read("data/raw/noaa/gshhg-shp-2.3.7/GSHHS_shp/l/GSHHS_l_L2.shp") %>%
  st_make_valid() %>%
  st_transform(crs_nad83) %>%
  st_union()

# for map background
# water bodies; including great lakes
mex_can <- st_read("data/raw/esri/Countries_WGS84.shp") %>% 
  filter(CNTRY_NAME %in% c("Canada", "Mexico")) %>%
  st_geometry() %>%
  st_transform(crs_nad83)
us_states <- st_read("data/raw/us_census/tl_2018_us_state.shp") %>%
  filter(NAME %!in% c("American Samoa", "Guam", "Puerto Rico", 
                      "Commonwealth of the Northern Mariana Islands",
                      "United States Virgin Islands",
                      "Alaska", "Hawaii")) %>%  # not included int he current study
  st_geometry() %>%
  st_transform(crs_nad83)


##---------------------------------------------------------------------------
## Manuscript figures

#.........................................................................
# panel a - map of study cities

# makes figure
figure_1a <- ggplot() +
  geom_sf(data = mex_can, fill = "#dcdcdc", color = NA, alpha = 0.7) +
  geom_sf(data = us_states, fill = "#E6E9E0", color = "#ffffff", lwd = 0.3) +
  geom_sf(data = lakes, fill = "#e9f5f8", color = NA) +
  geom_sf(data = oil_basin_union, fill = "orange", color = NA, alpha = 0.5) +
  geom_sf(data = us_states, fill = NA, color = "#ffffff", lwd = 0.3) +
  geom_sf(data = cities_holc_nocensus_sf, size = 4, color = "#9E9E9E") +
  geom_sf(data = cities_holc_census_sf,   size = 4, color = "#000000") +
  #geom_sf_text(data = cities_holc_census_sf, aes(label = city_state)) +
  xlim(-125, -70) + ylim(25, 49) +
  labs(x = "", y = "") +
  theme_bw() +
  theme(panel.background = element_rect(fill  = "#e9f5f8"),  # d0ecfd
        panel.grid       = element_line(color = "#e9f5f8"),  # e8f4f8
        legend.position = "none")
figure_1a
# export
ggsave(filename = "figure_1a.png", plot = figure_1a, device = "png",
       height = 9.75, width = 18, path = "output/figures/components/")


#.........................................................................
# panel b - n wells near HOLC-graded neighborhoods

# makes figure
figure_1b <- ggplot()
figure_1b

# export
ggsave(filename = "figure_1b.png", plot = figure_1c, device = "png",
       height = 5, width = 5, path = "output/figures/")


#.........................................................................
# panel c - production volume near HOLC-graded neighborhoods

# makes figure
figure_1c <- ggplot()

# export
ggsave(filename = "figure_1c.png", plot = figure_1c, device = "png",
       height = 5, width = 5, path = "output/figures/")







##---------------------------------------------------------------------------
## Presentation figures (i.e., with dark backgrounds)

##### need to edit this; maybe make darker colors? or just use the one above

#.........................................................................
# panel a - map of study sites across the U.S.

# makes figure
pres_figure_1a <- ggplot() +
  geom_sf(data = mex_can,   fill = "#dcdcdc", color = NA) +
  geom_sf(data = us_states, fill = "#ccd3c1", color = "#ffffff", lwd = 0.3) +
  geom_sf(data = holc_cities_10km, size = 2) +
  xlim(-125, -70) + ylim(25, 49) +
  theme_void() +
  theme(panel.background = element_rect(fill = "black"),
        panel.grid = element_line(color = "black"),
        legend.position = "none")

# export
ggsave(filename = "pres_figure_1a.png", plot = pres_figure_1a, device = "png",
       height = 6, width = 8, path = "output/figures/")


##============================================================================##