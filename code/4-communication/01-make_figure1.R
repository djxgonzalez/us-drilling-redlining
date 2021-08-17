##============================================================================##
## makes Figure 1 - (a) map of U.S. with study cities; (b) barplot of n wells
## near HOLC-graded neighborhoods; (c) barplot of production volume


##---------------------------------------------------------------------------
## sets up environment

library("ggspatial")

# data input
holc_cities <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  #filter(city == "Los Angeles") %>%
  st_transform(crs_nad83)

# data prep
wells_sf <- readRDS("data/interim/wells_interim.rds") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)


##---------------------------------------------------------------------------
## panel a - map of U.S. 

#.........................................................................
# makes figure
figure_1a <- ggplot()
figure_1a

#.........................................................................
# export
ggsave(filename = "figure_1a.png", plot = figure_1c, device = "png",
       height = 5, width = 5, path = "output/figures/")


##---------------------------------------------------------------------------
## panel b - n wells near HOLC-graded neighborhoods

#.........................................................................
# makes figure
figure_1b <- ggplot()
figure_1b

#.........................................................................
# export
ggsave(filename = "figure_1b.png", plot = figure_1c, device = "png",
       height = 5, width = 5, path = "output/figures/")


##---------------------------------------------------------------------------
## panel c - production volume near HOLC-graded neighborhoods

#.........................................................................
# makes figure
figure_1c <- ggplot()

#.........................................................................
# export
ggsave(filename = "figure_1c.png", plot = figure_1c, device = "png",
       height = 5, width = 5, path = "output/figures/")


##============================================================================##