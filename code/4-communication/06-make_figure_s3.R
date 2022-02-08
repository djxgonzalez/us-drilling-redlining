##============================================================================##
## makes Figure S3 - illustration of exposure assessment protocol for
## pre- and post-HOLC exposure assessments

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
wells_la_preholc <- readRDS("data/interim/wells_interim.rds") %>%
  filter(county_parish == "LOS ANGELES (CA)") %>%
  drop_na(longitude) %>%
  filter(spud_date <= as.Date("1938-12-31") |  # latest possible date for this
           completion_date <= as.Date("1938-12-31") |
           first_prod_date <= as.Date("1938-12-31") |
           last_prod_date  <= as.Date("1938-12-31")) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)
wells_la_postholc <- readRDS("data/interim/wells_interim.rds") %>%
  filter(county_parish == "LOS ANGELES (CA)") %>%
  drop_na(longitude) %>%
  filter(spud_date >= as.Date("1938-01-01") |  # post-appraisal date for all cities
           completion_date >= as.Date("1938-01-01") |
           first_prod_date >= as.Date("1938-01-01") |
           last_prod_date  >= as.Date("1938-01-01")) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = crs_nad83)

# data prep

neighborhood_boundary  <- holc_la %>% filter(holc_id == "D53")
neighborhood_buffer_100m <- neighborhood_boundary %>%
  st_transform(crs_projected) %>%
  st_buffer(dist = 100) %>%
  st_transform(crs_nad83)

##---------------------------------------------------------------------------
## manuscript figure

#.........................................................................
# makes figure 2a - pre-HOLC exposure with pre-HOLC wells
figure_s3a <- ggplot() +
  geom_sf(data = la_county, fill = "#ffffff") +
  geom_sf(data = holc_la, aes(fill = holc_grade), 
          color = "white", lwd = 0.6, alpha = 0.4) +
  scale_fill_manual(values = c("#8D9B5C", "#8DA3A5", "#D0B561", "#C0757E")) +
  geom_sf_text(data = holc_la, aes(label = holc_id)) +
  geom_sf(data = neighborhood_buffer_100m,
          fill = "#000000", color = NA, alpha = 0.7) +
          #fill = NA, color = "black", linetype = "dashed", lwd = 1) +
  geom_sf(data = neighborhood_boundary, fill = "#C0757E", color = NA) +
  geom_sf(data = wells_la_preholc, shape = 4, size = 3) +
  #annotation_scale(location = "br", width_hint = 0.25) +
  annotation_north_arrow(location = "tl", which_north = "true", 
                         style = north_arrow_minimal) +
  #xlim(-118.32, - 118.095) + ylim(33.945, 34.130) +
  xlim(-118.277, - 118.138) + ylim(33.985, 34.100) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d0ecfd"),
        panel.grid = element_line(color = "#d0ecfd"),
        legend.position = "none")
figure_s3a
# exports figures
ggsave(filename = "figure_s3a.png", plot = figure_s3a, device = "png",
       height = 6, width = 6, path = "output/figures/components/")

#.........................................................................
# makes figure 2b - post-HOLC exposure 
figure_s3b <- ggplot() +
  geom_sf(data = la_county, fill = "#ffffff") +
  geom_sf(data = holc_la, aes(fill = holc_grade), 
          color = "white", lwd = 0.6, alpha = 0.5) +
  scale_fill_manual(values = c("#8D9B5C", "#8DA3A5", "#D0B561", "#C0757E")) +
  geom_sf(data = neighborhood_buffer_100m, 
          fill = "#000000", color = NA, alpha = 0.7) +
  geom_sf(data = neighborhood_boundary, fill = "#C0757E", color = NA) +
  #geom_sf(data = neighborhood_boundary, fill = "#C0757E", color = "black", lwd = 1) +
  geom_sf(data = wells_la_postholc, shape = 4, size = 3) +
  annotation_scale(location = "br", width_hint = 0.25) +
  #annotation_north_arrow(location = "bl", which_north = "true", 
  #                       style = north_arrow_minimal) +
  #xlim(-118.32, - 118.095) + ylim(33.945, 34.130) +
  xlim(-118.277, - 118.138) + ylim(33.985, 34.100) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d0ecfd"),
        panel.grid = element_line(color = "#d0ecfd"),
        legend.position = "none")
figure_s3b
# exports figures
ggsave(filename = "figure_s3b.png", plot = figure_s3b, device = "png",
       height = 6, width = 6, path = "output/figures/components/")


##---------------------------------------------------------------------------
## makes and exports figure for presentation

pres_figure_s3a_i <- ggplot() +
  geom_sf(data = la_county, fill = "#ffffff") +
  geom_sf(data = holc_la, aes(fill = holc_grade), lwd = 0.3) +
  scale_fill_manual(values = c("#8D9B5C", "#8DA3A5", "#D0B561", "#C0757E")) +
  geom_sf(data = wells_la, shape = 4) +
  annotation_scale(location = "br", width_hint = 0.25) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         style = north_arrow_minimal) +
  xlim(-118.48, - 118.380) + ylim(33.955, 34.04) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d0ecfd"),
        panel.grid = element_line(color = "#d0ecfd"),
        legend.position = "none")
ggsave(filename = "pres_figure_s3a_i.png", plot = pres_figure_s3a_i, 
       height = 6.15, width = 6, device = "png", path = "output/figures/")

pres_figure_s3a_ii <- ggplot() +
  geom_sf(data = la_county, fill = "#ffffff") +
  geom_sf(data = holc_la, aes(fill = holc_grade), alpha = 0.3, lwd = 0.3) +
  scale_fill_manual(values = c("#8D9B5C", "#8DA3A5", "#D0B561", "#C0757E")) +
  geom_sf(data = c68_boundary, fill = "#D0B561", color = "black", lwd = 1) +
  geom_sf(data = wells_la, shape = 4) +
  annotation_scale(location = "br", width_hint = 0.25) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         style = north_arrow_minimal) +
  xlim(-118.48, - 118.380) + ylim(33.955, 34.04) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d0ecfd"),
        panel.grid = element_line(color = "#d0ecfd"),
        legend.position = "none")
ggsave(filename = "pres_figure_s3a_ii.png", plot = pres_figure_s3a_ii, 
       height = 6.15, width = 6, device = "png", path = "output/figures/")

pres_figure_s3a_iii <- ggplot() +
  geom_sf(data = la_county, fill = "#ffffff") +
  geom_sf(data = holc_la, aes(fill = holc_grade), alpha = 0.3, lwd = 0.3) +
  scale_fill_manual(values = c("#8D9B5C", "#8DA3A5", "#D0B561", "#C0757E")) +
  geom_sf(data = c68_boundary, fill = "#D0B561", color = "black", lwd = 1) +
  geom_sf(data = c68_buffer_100m, 
          fill = NA, color = "black", linetype = "dashed", lwd = 1) +
  geom_sf(data = wells_la, shape = 4) +
  annotation_scale(location = "br", width_hint = 0.25) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         style = north_arrow_minimal) +
  xlim(-118.48, - 118.380) + ylim(33.955, 34.04) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d0ecfd"),
        panel.grid = element_line(color = "#d0ecfd"),
        legend.position = "none")
ggsave(filename = "pres_figure_s3a_iii.png", plot = pres_figure_s3a_iii, 
       height = 6.15, width = 6, device = "png", path = "output/figures/")


##============================================================================##