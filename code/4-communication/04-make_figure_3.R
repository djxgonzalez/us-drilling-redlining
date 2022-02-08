##============================================================================##
## makes Figure 3 - well count and density x HOLC grade

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

# data for figure 3a
data_fig3a_i <- holc_neighborhoods_exp %>%
  as_tibble() %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  group_by(holc_grade) %>%
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
data_fig3a_ii <- holc_neighborhoods_exp %>%
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
data_fig3a <- data_fig3a_i %>% 
  bind_rows(data_fig3a_ii) %>% 
  mutate(distance = as.factor(distance))
data_fig3a$distance = factor(data_fig3a$distance, 
                             levels = c("100 m", "0 km"))
data_fig3a$timing = factor(data_fig3a$timing, 
                           levels = c("All Wells", "Pre-Appraisal", "Post-Appraisal"))

# data for figure 3b - wells_per_sqkm
data_fig3b <- holc_neighborhoods_exp %>%
  as_tibble() %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  group_by(holc_grade) %>%
  summarize(density_mean   = mean(wells_100m_all / area_sqkm),
            density_median = median(wells_100m_all / area_sqkm))


##---------------------------------------------------------------------------
## manuscript figure

#.........................................................................
# makes figure 3a_y - y axis
figure_3a_y <- data_fig3a %>%
  filter(timing == "All Wells") %>%
  ggplot() +
  geom_bar(aes(holc_grade, count, fill = distance), 
           position = "stack", stat = "identity") +
  scale_fill_manual(values = c("#bcbddc", "#6a51a3")) +
  labs(x = "HOLC Grade", y = "Wells (n)") +
  ylim(0, 6300) +
  theme_classic() +
  theme(legend.position = "none") #, strip.background = element_rect(color = NA))
figure_3a_y
# exports figures
ggsave(filename = "figure_3a_y.png", plot = figure_3a_y, device = "png",
       height = 3, width = 2, path = "output/figures/components/")

# makes figure 3a_i
figure_3a_i <- data_fig3a %>%
  filter(timing == "All Wells") %>%
  ggplot() +
  geom_bar(aes(holc_grade, count, fill = distance), 
           position = "stack", stat = "identity") +
  scale_fill_manual(values = c("#bcbddc", "#6a51a3")) +
  labs(x = "HOLC Grade", y = "") +
  ylim(0, 6300) +
  theme_classic() +
  theme(legend.position = "none",
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank()) 
figure_3a_i
# exports figures
ggsave(filename = "figure_3a_i.png", plot = figure_3a_i, device = "png",
       height = 3, width = 2, path = "output/figures/components/")

# makes figure 3a_ii
figure_3a_ii <- data_fig3a %>%
  filter(timing == "Pre-Appraisal") %>%
  ggplot() +
  geom_bar(aes(holc_grade, count, fill = distance), 
           position = "stack", stat = "identity") +
  scale_fill_manual(values = c("#bcbddc", "#6a51a3")) +
  labs(x = "HOLC Grade", y = "") +
  ylim(0, 6300) +
  theme_classic() +
  theme(legend.position = "none",
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank()) 
figure_3a_ii
# exports figures
ggsave(filename = "figure_3a_ii.png", plot = figure_3a_ii, device = "png",
       height = 3, width = 2, path = "output/figures/components/")

# makes figure 3a_iii
figure_3a_iii <- data_fig3a %>%
  filter(timing == "Post-Appraisal") %>%
  ggplot() +
  geom_bar(aes(holc_grade, count, fill = distance), 
           position = "stack", stat = "identity") +
  scale_fill_manual(values = c("#bcbddc", "#6a51a3")) +
  labs(x = "HOLC Grade", y = "") +
  ylim(0, 6300) +
  theme_classic() +
  theme(legend.position = "none",
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank())
figure_3a_iii
# exports figures
ggsave(filename = "figure_3a_iii.png", plot = figure_3a_iii, device = "png",
       height = 3, width = 2, path = "output/figures/components/")


#.........................................................................
# makes figure 3b - well density per km^2 and 1,000 ppl

# y-axis for figure making
figure_3b_y <- holc_neighborhoods_exp %>%
  filter(wells_100m_all > 0) %>%
  mutate(wells_per_sqkm = (wells_100m_all / area_sqkm)) %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  ggplot(aes(holc_grade, wells_per_sqkm)) +
  geom_boxplot(outlier.shape = NA) +
  labs(x = "HOLC Grade", y = "Wells per km^2") +
  coord_cartesian(ylim = c(-0, 40)) +
  theme_classic()
figure_3b_y
# exports figures
ggsave(filename = "figure_3b_y.png", plot = figure_3b_y, device = "png",
       height = 3, width = 2, path = "output/figures/components/")

figure_3b_i <- holc_neighborhoods_exp %>%
  filter(wells_0km_all > 0) %>%
  mutate(wells_per_sqkm = (wells_0km_all / area_sqkm)) %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  ggplot(aes(holc_grade, wells_per_sqkm)) +
  #geom_boxplot(outlier.shape = NA) +
  geom_violin() +
  geom_jitter(width = 0.3, alpha = 0.1) +
  stat_summary(fun = mean, colour = "black", geom = "point",
               shape = 18, size = 5) +
  labs(x = "HOLC Grade", y = "") +
  coord_cartesian(ylim = c(-0, 40)) +
  theme_classic() #+
  # theme(axis.line.y = element_blank(),
  #       axis.ticks.y = element_blank(),
  #       axis.text.y = element_blank())
figure_3b_i
# exports figures
ggsave(filename = "figure_3b_i.png", plot = figure_3b_i, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

figure_3b_ii <- holc_neighborhoods_exp %>%
  filter(wells_0km_all_preholc > 0) %>%
  mutate(wells_per_sqkm = (wells_0km_all_preholc / area_sqkm)) %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  ggplot(aes(holc_grade, wells_per_sqkm)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.3, alpha = 0.1) +
  stat_summary(fun = mean, colour = "black", geom = "point",
               shape = 18, size = 5) +
  labs(x = "HOLC Grade", y = "") +
  coord_cartesian(ylim = c(-0, 40)) +
  theme_classic() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank())
figure_3b_ii
# exports figures
ggsave(filename = "figure_3b_ii.png", plot = figure_3b_ii, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

figure_3b_iii <- holc_neighborhoods_exp %>%
  filter(wells_100m_all_postholc > 0) %>%
  mutate(wells_per_sqkm = (wells_0km_all_postholc / area_sqkm)) %>%
  filter(holc_grade %in% c("A", "B", "C", "D")) %>%
  ggplot(aes(holc_grade, wells_per_sqkm)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.3, alpha = 0.1) +
  stat_summary(fun = mean, colour = "black", geom = "point",
               shape = 18, size = 5) +
  labs(x = "HOLC Grade", y = "") +
  coord_cartesian(ylim = c(-0, 40)) +
  theme_classic() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank())
figure_3b_iii
# exports figures
ggsave(filename = "figure_3b_iii.png", plot = figure_3b_iii, device = "png",
       height = 6, width = 4, path = "output/figures/components/")


##============================================================================##