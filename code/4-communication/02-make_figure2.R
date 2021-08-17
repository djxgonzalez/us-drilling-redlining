##============================================================================##
## makes Figure 2 - illustration of exposure assessment protocol

##---------------------------------------------------------------------------
## sets up environment

library("ggspatial")

# data input
holc_la <- 
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  filter(city == "Los Angeles") %>%
  st_transform(crs_nad83)
la_county <- st_read("data/raw/la_county/Census_Tracts_2010.shp") %>%
  st_transform(crs_nad83) %>%
  st_union()
wells_la <- readRDS("data/interim/wells_interim.rds") %>%
  filter(county_parish == "LOS ANGELES (CA)") %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)

# data prep
c68_boundary <- holc_la %>% filter(holc_id == "C68")
c68_centroid <- c68_boundary %>%
  st_transform(crs_projected) %>%
  st_centroid(c68_boundary) %>%
  st_transform(crs_nad83)
c68_buffer   <- c68_centroid %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 3000) %>%
  st_transform(crs_nad83)

##---------------------------------------------------------------------------
## makes and exports figure for manuscript

#.........................................................................
# makes figure
figure_2a <- ggplot() +
  geom_sf(data = la_county, fill = "#ffffff") +
  geom_sf(data = holc_la, aes(fill = holc_grade), alpha = 0.5, lwd = 0.5) +
  scale_fill_manual(values = c("#8D9B5C", "#8DA3A5", "#D0B561", "#C0757E")) +
  geom_sf(data = c68_boundary, fill = "#D0B561", lwd = 1) +
  geom_sf(data = c68_centroid) +
  geom_sf(data = c68_buffer, fill = NA, linetype = "dashed", lwd = 1) +
  geom_sf(data = wells_la, shape = 4) +
  annotation_scale(location = "br", width_hint = 0.25) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         style = north_arrow_minimal) +
  xlim(-118.47, - 118.385) + ylim(33.965, 34.03) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d0ecfd"),
        panel.grid = element_line(color = "#d0ecfd"),
        legend.position = "none")
figure_2a

#.........................................................................
# exports figures
ggsave(filename = "figure_2a.png", plot = figure_2a, device = "png",
       height = 5.55, width = 6, path = "output/figures/")



##---------------------------------------------------------------------------
## makes and exports figure for presentation

#.........................................................................
# makes figure
figure_2a_i

#.........................................................................
# exports figure
ggsave(filename = "figure_2a_i.png", plot = figure_2a_i, device = "png",
       height = 1.5, width = 5.8, path = "output/figures/presentation/")

##============================================================================##