##============================================================================##
## makes Table - 1940s census characteristics by HOLC grade


##---------------------------------------------------------------------------
## sets up environment

library("table1")

holc_neighborhoods_exp <- 
  readRDS("data/processed/holc_neighborhoods_exp.rds")


##---------------------------------------------------------------------------
## assembles tables


# variables by HOLC grade
holc_grades_table <- holc_neighborhoods_exp %>%
  drop_na(pop40_w) %>%
  filter(city_wells_100m_all >= 10) %>% 
  filter(holc_grade != "E") %>%
  mutate(holc_grade = as.factor(holc_grade)) %>%
  group_by(holc_grade) %>%
  summarize(n              = n(),
            population_n   = sum(pop40_w),
            n_black        = sum(b40_w),
            perc_black     = round((sum(b40_w) / sum(pop40_w) * 100), digits = 1),
            n_white        = sum(white40_w),
            perc_white     = round((sum(white40_w) / sum(pop40_w) * 100), digits = 1),
            n_nonwhite     = sum(nw40_w),
            perc_nonwhite  = round((sum(nw40_w) / sum(pop40_w) * 100), digits = 1),
            n_foreign      = sum(fbw40_w),
            perc_foreign   = round((sum(fbw40_w) / sum(pop40_w) * 100), digits = 1),
            completed_hs   = sum(school_hsc),
            perc_comp_hs   = round((sum(school_hsc) / sum(pop40_w) * 100), digits = 1),
            # college        = (sum(school_uni) + sum(school_uni.1)),
            # perc_college   = round((sum(sum(school_uni) + sum(school_uni.1)) / 
            #                           sum(pop40_w) * 100), digits = 1),
            median_home    = round(mean(mhv40_w), digits = 0),
            median_home_sd = round(sd(mhv40_w), digits = 0),
            ppl_per_house  = round(mean(ppu40_w), digits = 1),
            ppl_per_sd     = round(sd(ppu40_w), digits = 1),
            owner_occ_perc = round((sum(own_occ40) / sum(usocc40_w) * 100), digits = 1),
            radio_perc     = round((sum(Radio40_w) / sum(usocc40_w) * 100), digits = 1)) %>%
  as.data.frame() %>%
  t() %>%
  as_tibble()
holc_grades_table
write_csv(holc_grades_table, "output/tables/table_1a.csv")


# variables by HOLC grad
holc_all_table <- holc_neighborhoods_exp %>%
  drop_na(pop40_w) %>%
  filter(city_wells_100m_all >= 10) %>% 
  filter(holc_grade != "E") %>%
  mutate(holc_grade = as.factor(holc_grade)) %>%
  group_by() %>%
  summarize(n = n(),
            population_n   = sum(pop40_w),
            n_black        = sum(b40_w),
            perc_black     = round((sum(b40_w) / sum(pop40_w) * 100), digits = 2),
            n_white        = sum(white40_w),
            perc_white     = round((sum(white40_w) / sum(pop40_w) * 100), digits = 2),
            n_nonwhite     = sum(nw40_w),
            perc_nonwhite  = round((sum(nw40_w) / sum(pop40_w) * 100), digits = 2),
            n_foreign      = sum(fbw40_w),
            perc_foreign   = round((sum(fbw40_w) / sum(pop40_w) * 100), digits = 2),
            completed_hs   = sum(school_hsc),
            perc_comp_hs   = round((sum(school_hsc) / sum(pop40_w) * 100), digits = 1),
            college        = (sum(school_uni) + sum(school_uni.1)),
            perc_college   = round((sum(sum(school_uni) + sum(school_uni.1)) / 
                                      sum(pop40_w) * 100), digits = 1),
            median_home    = mean(mhv40_w),
            median_home_sd = sd(mhv40_w),
            ppl_per_house  = round(mean(ppu40_w), digits = 1),
            ppl_per_sd     = round(sd(ppu40_w), digits = 1),
            owner_occ_perc = round((sum(own_occ40_) / sum(usocc40_w) * 100), digits = 2),
            radio_perc     = round((sum(Radio40_w) / sum(usocc40_w) * 100), digits = 2)) %>%
  as.data.frame() %>%
  t() %>%
  as_tibble()
holc_all_table
write_csv(holc_all_table, "output/tables/table_1b.csv")


##============================================================================##