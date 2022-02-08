##============================================================================##
## makes Figure S8 - point estimates and 95% CIs from TMLEs (well density)

##---------------------------------------------------------------------------
## sets up environment

# data input
data_fig_s8 <- read_csv("output/results/results_wells_all_tmle.csv")

##---------------------------------------------------------------------------
## manuscript figure

#.........................................................................
# makes figure 4 - all wells, count
figure_s8a <- data_fig_s8 %>%
  filter(distance_m == 100) %>%
  filter(metric == "density") %>%
  filter(timing == "all") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_s8a
# exports figures
ggsave(filename = "figure_s8a.png", plot = figure_s8a, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

#.........................................................................
# makes figure 4 - all wells, count
figure_s8b <- data_fig_s8 %>%
  filter(distance_m == 100) %>%
  filter(metric == "density") %>%
  filter(timing == "before") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_s8b
# exports figures
ggsave(filename = "figure_s8b.png", plot = figure_s8b, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

#.........................................................................
# makes figure 4 - all wells, count
figure_s8c <- data_fig_s8 %>%
  filter(distance_m == 100) %>%
  filter(metric == "density") %>%
  filter(timing == "after") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_s8c
# exports figures
ggsave(filename = "figure_s8c.png", plot = figure_s8c, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

##============================================================================##