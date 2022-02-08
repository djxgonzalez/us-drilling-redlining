---
title: "Analyses - TMLE fit to propensity-score matched data"
subtitle: "Well Density"
output:
  html_document:
    theme: flatly
    highlight: haddock 
    toc: yes
    tocdepth: 3
    toc_float: yes
    keep_md: true
    number_sections: false
---









# A-B neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0km_all_postholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.076399 
##     Estimated Std Err:  0.021059 
##               p-value:  0.00028585 
##     95% Conf Interval: (0.035124, 0.11768) 
## 
## Control Estimate:
##    Parameter Estimate:  0.076399 
##     Estimated Std Err:  0.021059 
##               p-value:  0.00028585 
##     95% Conf Interval: (0.035124, 0.11768) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  4.6144e-16 
##     Estimated Std Err:  6.4487e-17 
##               p-value:  8.3354e-13 
##     95% Conf Interval: (3.3504e-16, 5.8783e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_postholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_ab_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.073717 
##     Estimated Std Err:  0.026563 
##               p-value:  0.0055168 
##     95% Conf Interval: (0.021655, 0.12578) 
## 
## Control Estimate:
##    Parameter Estimate:  0.073717 
##     Estimated Std Err:  0.026563 
##               p-value:  0.0055168 
##     95% Conf Interval: (0.021655, 0.12578) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.0217e-16 
##     Estimated Std Err:  5.5582e-17 
##               p-value:  0.00027552 
##     95% Conf Interval: (9.323e-17, 3.1111e-16)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_postholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.13009 
##     Estimated Std Err:  0.035459 
##               p-value:  0.00024372 
##     95% Conf Interval: (0.060593, 0.19959) 
## 
## Control Estimate:
##    Parameter Estimate:  0.13009 
##     Estimated Std Err:  0.035459 
##               p-value:  0.00024372 
##     95% Conf Interval: (0.060593, 0.19959) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -5.5511e-16 
##     Estimated Std Err:  1.1131e-16 
##               p-value:  6.1353e-07 
##     95% Conf Interval: (-7.7328e-16, -3.3694e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_postholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_ab_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.15519 
##     Estimated Std Err:  0.05558 
##               p-value:  0.0052352 
##     95% Conf Interval: (0.046255, 0.26412) 
## 
## Control Estimate:
##    Parameter Estimate:  0.15519 
##     Estimated Std Err:  0.05558 
##               p-value:  0.0052352 
##     95% Conf Interval: (0.046255, 0.26412) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -5.6712e-16 
##     Estimated Std Err:  9.2319e-17 
##               p-value:  8.0954e-10 
##     95% Conf Interval: (-7.4806e-16, -3.8618e-16)
```


# B-C neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_postholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.27074 
##     Estimated Std Err:  0.11489 
##               p-value:  0.018449 
##     95% Conf Interval: (0.045556, 0.49593) 
## 
## Control Estimate:
##    Parameter Estimate:  0.27074 
##     Estimated Std Err:  0.11489 
##               p-value:  0.018449 
##     95% Conf Interval: (0.045556, 0.49593) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.1428e-15 
##     Estimated Std Err:  6.168e-16 
##               p-value:  0.00051264 
##     95% Conf Interval: (9.339e-16, 3.3517e-15)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_postholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_bc_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.16763 
##     Estimated Std Err:  0.056976 
##               p-value:  0.0032598 
##     95% Conf Interval: (0.055959, 0.2793) 
## 
## Control Estimate:
##    Parameter Estimate:  0.16763 
##     Estimated Std Err:  0.056976 
##               p-value:  0.0032598 
##     95% Conf Interval: (0.055959, 0.2793) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.0925e-15 
##     Estimated Std Err:  1.7395e-16 
##               p-value:  <2e-16 
##     95% Conf Interval: (1.7516e-15, 2.4335e-15)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_postholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.4683 
##     Estimated Std Err:  0.15621 
##               p-value:  0.0027192 
##     95% Conf Interval: (0.16213, 0.77447) 
## 
## Control Estimate:
##    Parameter Estimate:  0.4683 
##     Estimated Std Err:  0.15621 
##               p-value:  0.0027192 
##     95% Conf Interval: (0.16213, 0.77447) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  9.0553e-16 
##     Estimated Std Err:  3.0527e-16 
##               p-value:  0.0030139 
##     95% Conf Interval: (3.0721e-16, 1.5038e-15)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_postholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_bc_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.38072 
##     Estimated Std Err:  0.1016 
##               p-value:  0.00017869 
##     95% Conf Interval: (0.18159, 0.57984) 
## 
## Control Estimate:
##    Parameter Estimate:  0.38072 
##     Estimated Std Err:  0.1016 
##               p-value:  0.00017869 
##     95% Conf Interval: (0.18159, 0.57984) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  4.0722e-15 
##     Estimated Std Err:  5.6629e-16 
##               p-value:  6.4321e-13 
##     95% Conf Interval: (2.9623e-15, 5.1821e-15)
```


# C-D neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_postholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.37756 
##     Estimated Std Err:  0.10078 
##               p-value:  0.00017941 
##     95% Conf Interval: (0.18004, 0.57509) 
## 
## Control Estimate:
##    Parameter Estimate:  0.37756 
##     Estimated Std Err:  0.10078 
##               p-value:  0.00017941 
##     95% Conf Interval: (0.18004, 0.57509) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -6.6743e-16 
##     Estimated Std Err:  1.8011e-16 
##               p-value:  0.00021074 
##     95% Conf Interval: (-1.0204e-15, -3.1443e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_postholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_cd_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.22698 
##     Estimated Std Err:  0.043063 
##               p-value:  1.3571e-07 
##     95% Conf Interval: (0.14258, 0.31139) 
## 
## Control Estimate:
##    Parameter Estimate:  0.22698 
##     Estimated Std Err:  0.043063 
##               p-value:  1.3571e-07 
##     95% Conf Interval: (0.14258, 0.31139) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  4.0369e-15 
##     Estimated Std Err:  9.7929e-16 
##               p-value:  3.7513e-05 
##     95% Conf Interval: (2.1175e-15, 5.9563e-15)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_postholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.60897 
##     Estimated Std Err:  0.14855 
##               p-value:  4.1434e-05 
##     95% Conf Interval: (0.31781, 0.90013) 
## 
## Control Estimate:
##    Parameter Estimate:  0.60897 
##     Estimated Std Err:  0.14855 
##               p-value:  4.1434e-05 
##     95% Conf Interval: (0.31781, 0.90013) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  5.9154e-15 
##     Estimated Std Err:  4.0922e-16 
##               p-value:  <2e-16 
##     95% Conf Interval: (5.1134e-15, 6.7175e-15)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_postholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_cd_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.40948 
##     Estimated Std Err:  0.073768 
##               p-value:  2.8415e-08 
##     95% Conf Interval: (0.2649, 0.55407) 
## 
## Control Estimate:
##    Parameter Estimate:  0.40948 
##     Estimated Std Err:  0.073768 
##               p-value:  2.8415e-08 
##     95% Conf Interval: (0.2649, 0.55407) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -1.7864e-15 
##     Estimated Std Err:  2.6125e-16 
##               p-value:  8.0426e-12 
##     95% Conf Interval: (-2.2984e-15, -1.2743e-15)
```
