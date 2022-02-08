##============================================================================##
## makes Figure 4 - point estimates and 95% CIs from TMLEs

##---------------------------------------------------------------------------
## sets up environment

# data input
data_fig4 <- read_csv("output/results/results_wells_all_tmle.csv")

##---------------------------------------------------------------------------
## manuscript figure

#.........................................................................
# makes figure 4 - all wells, count
figure_4a <- data_fig4 %>%
  filter(distance_m == 100) %>%
  filter(metric == "count") %>%
  filter(timing == "all") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_4a
# exports figures
ggsave(filename = "figure_4a.png", plot = figure_4a, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

#.........................................................................
# makes figure 4 - all wells, count
figure_4b <- data_fig4 %>%
  filter(distance_m == 100) %>%
  filter(metric == "count") %>%
  filter(timing == "before") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_4b
# exports figures
ggsave(filename = "figure_4b.png", plot = figure_4b, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

#.........................................................................
# makes figure 4 - all wells, count
figure_4c <- data_fig4 %>%
  filter(distance_m == 100) %>%
  filter(metric == "count") %>%
  filter(timing == "after") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_4c
# exports figures
ggsave(filename = "figure_4c.png", plot = figure_4c, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

##============================================================================##