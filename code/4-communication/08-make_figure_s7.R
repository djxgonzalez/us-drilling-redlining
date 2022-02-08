##============================================================================##
## makes Figure S7 - point estimates and 95% CIs from TMLEs (wells
## inside neighborhood)

##---------------------------------------------------------------------------
## sets up environment

# data input
data_fig_s7 <- read_csv("output/results/results_wells_all_tmle.csv")

##---------------------------------------------------------------------------
## manuscript figure

#.........................................................................
# makes figure 4 - all wells, count
figure_s7a <- data_fig_s7 %>%
  filter(distance_m == 0) %>%
  filter(metric == "count") %>%
  filter(timing == "all") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_s7a
# exports figures
ggsave(filename = "figure_s7a.png", plot = figure_s7a, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

#.........................................................................
# makes figure 4 - all wells, count
figure_s7b <- data_fig_s7 %>%
  filter(distance_m == 0) %>%
  filter(metric == "count") %>%
  filter(timing == "before") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_s7b
# exports figures
ggsave(filename = "figure_s7b.png", plot = figure_s7b, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

#.........................................................................
# makes figure 4 - all wells, count
figure_s7c <- data_fig_s7 %>%
  filter(distance_m == 0) %>%
  filter(metric == "count") %>%
  filter(timing == "after") %>%
  ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
  geom_pointrange(aes(holc_grades, pt_est,
                      ymin = ci_lower, ymax = ci_upper)) +
  labs(x = "HOLC Grades Comparison", y = "Change in Well Count") +
  ylim(-0.2, 3) +
  theme_classic()
figure_s7c
# exports figures
ggsave(filename = "figure_s7c.png", plot = figure_s7c, device = "png",
       height = 6, width = 4, path = "output/figures/components/")

##============================================================================##