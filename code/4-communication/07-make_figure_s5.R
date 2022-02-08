##============================================================================##
## makes Figure S5 - well count and density x HOLC grade x City for the 
## nine most exposed cities

##---------------------------------------------------------------------------
## sets up environment

# data input
holc_neighborhoods_sf <-
  st_read("data/raw/univ_richmond/mapping_inequality/shapefile/holc_ad_data.shp") %>%
  mutate(city_state = as.factor(paste(city, "-", state)),
         neighborhood = as.factor(neighborho)) %>%
  select(neighborhood) %>%
  as_tibble()
holc_neighborhoods_exp <- 
  readRDS("data/processed/holc_neighborhoods_exp.rds") %>%
  left_join(holc_neighborhoods_sf, by = "neighborhood") %>%
  mutate(wells_0km_no_dates = wells_0km_all - 
           (wells_0km_all_preholc + wells_0km_all_postholc))
holc_cities_top9 <- holc_neighborhoods_exp %>%
  filter(city_wells_100m_all > 200) %>%
  distinct(city_state)
  
# data for figure s5
data_fig_s5a_i <- holc_neighborhoods_exp %>%
  as_tibble() %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  group_by(city_state, holc_grade) %>%
  summarize(wells_all  = sum(wells_0km_all),
            wells_pre  = sum(wells_0km_all_preholc),
            wells_post = sum(wells_0km_all_postholc)) %>%
  pivot_longer(cols = starts_with("wells_"), 
               names_to = "timing", values_to = "count") %>%
  mutate(holc_grade = as.factor(holc_grade),
         timing     = 
           as.factor(case_when(timing == "wells_all" ~ "All Wells",
                               timing == "wells_pre" ~ "Pre-Appraisal",
                               timing == "wells_post" ~ "Post-Appraisal")),
         distance   = "0 km")
data_fig_s5a_ii <- holc_neighborhoods_exp %>%
  # subtract 0 km wells from 100 m wells so we can stack
  mutate(wells_100m_all          = wells_100m_all          - wells_0km_all,
         wells_100m_all_preholc  = wells_100m_all_preholc  - wells_0km_all_preholc,
         wells_100m_all_postholc = wells_100m_all_postholc - 
           wells_0km_all_postholc) %>%
  as_tibble() %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  group_by(holc_grade) %>%
  summarize(wells_all  = sum(wells_100m_all),
            wells_pre  = sum(wells_100m_all_preholc),
            wells_post = sum(wells_100m_all_postholc)) %>%
  pivot_longer(cols = starts_with("wells_"), 
               names_to = "timing", values_to = "count") %>%
  mutate(holc_grade = as.factor(holc_grade),
         timing     = 
           as.factor(case_when(timing == "wells_all" ~ "All Wells",
                               timing == "wells_pre" ~ "Pre-Appraisal",
                               timing == "wells_post" ~ "Post-Appraisal")),
         distance   = "100 m")
data_fig_s5a <- data_fig_s5a_i %>% 
  bind_rows(data_fig_s5a_ii) %>% 
  mutate(distance = as.factor(distance))
data_fig_s5a$distance = factor(data_fig_s5a$distance, 
                             levels = c("100 m", "0 km"))
data_fig_s5a$timing = factor(data_fig_s5a$timing, 
                           levels = c("All Wells", "Pre-Appraisal", "Post-Appraisal"))



# makes figure 3a_i
figure_s5 <- data_fig_s5a %>%
  filter(city_state %in% holc_cities_top9$city_state) %>%
  filter(timing == "All Wells") %>%
  ggplot() +
  geom_bar(aes(holc_grade, count, fill = distance), 
           position = "stack", stat = "identity") +
  scale_fill_manual(values = c("#6a51a3")) + #"#bcbddc"
  labs(x = "HOLC Grade", y = "") +
  facet_wrap(~ city_state) +
  #ylim(0, 6300) +
  theme_classic() +
  theme(legend.position = "none") 
figure_s5

ggsave(filename = "figure_s5.png", plot = figure_s5, device = "png",
       height = 5, width = 6, path = "output/figures/components/")

##---------------------------------------------------------------------------
## makes supplemental figure

data_fig_s5a <- holc_neighborhoods_exp %>%
  as_tibble() %>%
  filter(city_state %in% holc_cities_top9$city_state) %>%
  left_join(holc_cities_top9, by = "city_state") %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  group_by(holc_grade, city_state) %>%
  summarize(wells_all  = ,
            wells_pre  = sum(wells_100m_all_preholc),
            wells_post = sum(wells_100m_all_postholc)) %>%
  pivot_longer(cols = starts_with("wells_"),
               names_to = "timing", values_to = "count") %>%
  mutate(holc_grade = as.factor(holc_grade),
         timing     = as.factor(timing))

#.........................................................................
# makes figure - count of wells by HOLC grade and by city
figure_s <- ggplot(data_fig_s5a) +
  geom_bar(aes(holc_grade, count, fill = timing), 
           position = position_dodge2(reverse = TRUE), stat = "identity") +
  scale_fill_manual(values = c("#6a51a3", "#969696")) +
  labs(x = "HOLC Grade", y = "Wells (n)") +
  facet_wrap(~ city_state) +
  theme_classic() +
  theme(legend.position  = "none",
        strip.text.x     = element_text(vjust = -1),
        strip.background = element_rect(color = NA))
figure_s
# exports figures
ggsave(filename = "figure_s.png", plot = figure_s, device = "png",
       height = 4, width = 6, path = "output/figures/components/")


##============================================================================##