##============================================================================##
## 2c - adaption of propensity scoring script from A. Nardone for HOLC neighborhoods (Grades C&D)

#==============================
#Packages needed
library(SuperLearner)
library(viridis)
library(tidyverse)
library(rpart)
library(ggplot2)
library(arules)
library(nnet)
library(gam)
library(stats)
library(arm)
library(sp)
library(rgdal)
library(ggplot2)
library(raster)
library(GISTools)
library(gstat)
library(sf)
library(lattice)
library(maptools)
library(lmtest)
library(glmnet)
library(naniar)
library(earth)
library(MatchIt)
library(ltmle)
library(ggdark)
#==============================

#Propensity of neighborhood grades based upon demographics and oil/gas wells

#==============================

#read in data
dta <- readRDS("~/Box/us redlining drilling/us-drilling-redlining/data/interim/propensity score data/holc_neighborhoods_exp.rds")

#return dataset of observations with non-missing data
dat <- dta[complete.cases(dta$holc_grade, dta$nw40_w, 
                          dta$b40_w, dta$fbw40_w, 
                          dta$pop40_w, dta$school_hsc, 
                          dta$mhv40_w, dta$Emp40_w, 
                          dta$usocc40_w, dta$NoRadio40_w, 
                          dta$mr40_w, dta$area_sqkm),] %>% as_tibble()

#subset to response variable (HOLC grades) and census data covariates
dat <- dat %>%
  dplyr::select(neighborhood, holc_grade,
                nw40_w, b40_w, fbw40_w,
                pop40_w, school_hsc,
                Emp40_w, usocc40_w,
                NoRadio40_w, mr40_w,
                area_sqkm, mhv40_w) %>%
  dplyr::filter(pop40_w != 0)

#create proportion variables for covariates from weighted sums
dat <- dat %>% 
  mutate(median_home_value = as.numeric(mhv40_w),
         prop_nonwhite     = (nw40_w     / pop40_w),       #proportion non-white residents
         prop_black        = (b40_w      / pop40_w),       #proportion black residents
         prop_foreign      = (fbw40_w    / pop40_w),       #proportion foreign-born residents
         prop_high_school  = (school_hsc / pop40_w),       #proportion at least high school edu 
         prop_employed     = (Emp40_w    / pop40_w),       #proportion employed
         prop_no_radio     = (NoRadio40_w / usocc40_w),     #proportion no radio in house
         prop_home_repair  = (mr40_w     / usocc40_w),     #proportion needing home repair
         n_people_unit     = (pop40_w    / usocc40_w),     #proportion ppl in unit
         pop_density       = (pop40_w    / area_sqkm)) %>% #pop density
  drop_na()

#filter data for only C and D graded neighborhoods for comparison
dat <- dplyr::filter(dat, holc_grade == "C" | holc_grade == "D")

#superlearner libraries to run lasso & a screener 
SL.library <- c("SL.glm",  "SL.mean", "SL.bayesglm", "SL.earth", "SL.gam")

#ID your exposure of interest (e.g., propensity to be redlined vs. yellowlined)
dat$exposure <- ifelse(dat$holc_grade=="D", 1, 0)

#set up data
Y <- dat$exposure

#Set up predictor data as tibble instead of sf frame
X <- as_tibble(dat) %>% dplyr::select(c(prop_nonwhite, prop_black, 
                                        prop_foreign, prop_high_school, 
                                        prop_employed, prop_no_radio,
                                        prop_home_repair, n_people_unit, 
                                        pop_density, mhv40_w))

#run superlearner  
j <- SuperLearner(Y = Y,  X = X,  SL.library=SL.library, family=binomial(), verbose = TRUE)

#create column in dat for propensity scores 
dat$cpa1 <- predict(j, newdata=X)$pred

#View propensity scores for exposed and unexposed
plot(density(dat$cpa1[dat$exposure==0]))
lines(density(dat$cpa1[dat$exposure==1]))

#Create new dataset that excludes outliers in tails of propensity score distributions
supporteddat<-dat[dat$holc_grade %in% c("C", "D") & dat$cpa1<quantile(dat$cpa1[dat$holc_grade=="C"], probs=.99) & 
                     dat$cpa1>quantile(dat$cpa1[dat$holc_grade=="D"], probs=.01),]
datk<-as.data.frame(supporteddat)
datk$score<-datk$cpa1

#Re-visualize restricted propensity score distributions (color-coded here)

  #adapted Nardone plot
datk$Grade<-ifelse(datk$exposure==0, "C", ifelse(datk$exposure==1, "D", 2))
c<-density(datk$score[datk$Grade=="C"])
d<-density(datk$score[datk$Grade=="D"])
plot(c, main="Propensity to be grade D", xlab="Propensity Score", ylim=c(0, 5))
polygon(c, col="cadetblue3")
lines(density(datk$score[datk$Grade=="C"]))
polygon(d, col=rgb(0.9, 0, 0.4, 0.6))


  #ggplot rendition (HOLC grade-specific colors)
  #still want: legend + dark version 
c_vec <- as.vector(datk$score[datk$Grade == "C"]) %>%
  tibble() %>%
  rename("v1" = ".")

d_vec <- as.vector(datk$score[datk$Grade == "D"]) %>%
  tibble() %>%
  rename("v1" = ".")

ps_plot_cd <- ggplot() +
  geom_density(data = c_vec, aes(x = v1), color = "#d7b95f", fill = "#d7b95f", alpha = 0.3) +
  geom_density(data = d_vec, aes(x = v1), color = "#cc747d", fill = "#cc747d", alpha = 0.3) +
  labs(x = "Propensity Score", y = "Density") +
  ggtitle("Propensity for receiving HOLC grade D") +
  scale_x_continuous(limits = c(0, 1), expand = c(0, 0), labels = scales::number_format(accuracy = 0.25)) +
  scale_y_continuous(limits = c(0, 5), expand = c(0, 0)) +
  scale_fill_manual(values = c("yellow" = "yellow",
                               "red" = "red"),
                    name = 'the fill',
                    guide = 'legend', 
                    labels = c('C', 'D')) +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

ps_plot_cd

  #export figure
ggsave(filename = "ps_plot_cd.png", plot = ps_plot_cd, device = "png",
       height = 3, width = 8, path = "output/figures/")

 #Match polygons to one-another based on propensity scores from ps-restricted dataset
#matching holc_grades by propensity score, within 0.2 units of one another, with replacement

    #matchit requires the treatment variable to be a numerical binary, create variable for this:
datk <- datk %>%
  mutate(holc_num = ifelse(holc_grade == "C", 1, 0))

ps <- matchit(formula = holc_num ~  score, data = datk, 
              method = "nearest", replace=TRUE, #mahvars = c("nw40_w", "mhv40_w"),
              caliper=0.2, 
              reestimate=FALSE)

#Grab matched data
propensity_scores_cd <- match.data(ps)

#Save df as rds
saveRDS(propensity_scores_cd, file = "./data/processed/propensity_scores_cd.rds")
