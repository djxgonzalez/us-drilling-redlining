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
##     Ynodes = "wells_0km_all", gform = gform, abar = list(1, 0), 
##     SL.library = SL.library, observation.weights = holc_matched_ab_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.56156 
##     Estimated Std Err:  0.12597 
##               p-value:  8.2747e-06 
##     95% Conf Interval: (0.31466, 0.80845) 
## 
## Control Estimate:
##    Parameter Estimate:  0.56156 
##     Estimated Std Err:  0.12597 
##               p-value:  8.2747e-06 
##     95% Conf Interval: (0.31466, 0.80845) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  4.597e-16 
##     Estimated Std Err:  3.0399e-17 
##               p-value:  <2e-16 
##     95% Conf Interval: (4.0012e-16, 5.1928e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.5643 
##     Estimated Std Err:  0.12842 
##               p-value:  1.1116e-05 
##     95% Conf Interval: (0.31261, 0.81599) 
## 
## Control Estimate:
##    Parameter Estimate:  0.5643 
##     Estimated Std Err:  0.12842 
##               p-value:  1.1116e-05 
##     95% Conf Interval: (0.31261, 0.81599) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  0 
##     Estimated Std Err:  0 
##               p-value:  NA 
##     95% Conf Interval: (0, 0)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.93256 
##     Estimated Std Err:  0.19384 
##               p-value:  1.5008e-06 
##     95% Conf Interval: (0.55265, 1.3125) 
## 
## Control Estimate:
##    Parameter Estimate:  0.93256 
##     Estimated Std Err:  0.19384 
##               p-value:  1.5008e-06 
##     95% Conf Interval: (0.55265, 1.3125) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  4.944e-15 
##     Estimated Std Err:  2.1555e-16 
##               p-value:  <2e-16 
##     95% Conf Interval: (4.5215e-15, 5.3664e-15)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  1.0131 
##     Estimated Std Err:  0.21172 
##               p-value:  1.7089e-06 
##     95% Conf Interval: (0.59814, 1.4281) 
## 
## Control Estimate:
##    Parameter Estimate:  1.0131 
##     Estimated Std Err:  0.21172 
##               p-value:  1.7089e-06 
##     95% Conf Interval: (0.59814, 1.4281) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -8.0359e-16 
##     Estimated Std Err:  2.4874e-17 
##               p-value:  <2e-16 
##     95% Conf Interval: (-8.5235e-16, -7.5484e-16)
```


# B-C neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all", gform = gform, abar = list(1, 0), 
##     SL.library = SL.library, observation.weights = holc_matched_bc_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.94904 
##     Estimated Std Err:  0.19171 
##               p-value:  7.4064e-07 
##     95% Conf Interval: (0.57329, 1.3248) 
## 
## Control Estimate:
##    Parameter Estimate:  0.94904 
##     Estimated Std Err:  0.19171 
##               p-value:  7.4064e-07 
##     95% Conf Interval: (0.57329, 1.3248) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  6.2016e-16 
##     Estimated Std Err:  4.8495e-17 
##               p-value:  <2e-16 
##     95% Conf Interval: (5.2512e-16, 7.1521e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.80007 
##     Estimated Std Err:  0.14722 
##               p-value:  5.5003e-08 
##     95% Conf Interval: (0.51151, 1.0886) 
## 
## Control Estimate:
##    Parameter Estimate:  0.80007 
##     Estimated Std Err:  0.14722 
##               p-value:  5.5003e-08 
##     95% Conf Interval: (0.51151, 1.0886) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  1.3624e-15 
##     Estimated Std Err:  1.3808e-15 
##               p-value:  0.32381 
##     95% Conf Interval: (-1.344e-15, 4.0688e-15)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  1.5649 
##     Estimated Std Err:  0.28229 
##               p-value:  2.9616e-08 
##     95% Conf Interval: (1.0116, 2.1182) 
## 
## Control Estimate:
##    Parameter Estimate:  1.5649 
##     Estimated Std Err:  0.28229 
##               p-value:  2.9616e-08 
##     95% Conf Interval: (1.0116, 2.1182) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.1935e-14 
##     Estimated Std Err:  2.5537e-15 
##               p-value:  <2e-16 
##     95% Conf Interval: (1.693e-14, 2.694e-14)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  1.4482 
##     Estimated Std Err:  0.23479 
##               p-value:  6.9057e-10 
##     95% Conf Interval: (0.98806, 1.9084) 
## 
## Control Estimate:
##    Parameter Estimate:  1.4482 
##     Estimated Std Err:  0.23479 
##               p-value:  6.9057e-10 
##     95% Conf Interval: (0.98806, 1.9084) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -3.8165e-15 
##     Estimated Std Err:  4.3714e-16 
##               p-value:  <2e-16 
##     95% Conf Interval: (-4.6733e-15, -2.9597e-15)
```


# C-D neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all", gform = gform, abar = list(1, 0), 
##     SL.library = SL.library, observation.weights = holc_matched_cd_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  1.3861 
##     Estimated Std Err:  0.28584 
##               p-value:  1.2401e-06 
##     95% Conf Interval: (0.82583, 1.9463) 
## 
## Control Estimate:
##    Parameter Estimate:  1.3861 
##     Estimated Std Err:  0.28584 
##               p-value:  1.2401e-06 
##     95% Conf Interval: (0.82583, 1.9463) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  1.5862e-14 
##     Estimated Std Err:  4.5601e-15 
##               p-value:  0.00050441 
##     95% Conf Interval: (6.9242e-15, 2.48e-14)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.98402 
##     Estimated Std Err:  0.20625 
##               p-value:  1.8332e-06 
##     95% Conf Interval: (0.57978, 1.3883) 
## 
## Control Estimate:
##    Parameter Estimate:  0.98402 
##     Estimated Std Err:  0.20625 
##               p-value:  1.8332e-06 
##     95% Conf Interval: (0.57978, 1.3883) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  3.1215e-14 
##     Estimated Std Err:  1.0261e-15 
##               p-value:  <2e-16 
##     95% Conf Interval: (2.9204e-14, 3.3226e-14)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  1.9692 
##     Estimated Std Err:  0.36108 
##               p-value:  4.9351e-08 
##     95% Conf Interval: (1.2615, 2.6769) 
## 
## Control Estimate:
##    Parameter Estimate:  1.9692 
##     Estimated Std Err:  0.36108 
##               p-value:  4.9351e-08 
##     95% Conf Interval: (1.2615, 2.6769) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.6502e-14 
##     Estimated Std Err:  3.1475e-15 
##               p-value:  <2e-16 
##     95% Conf Interval: (2.0333e-14, 3.2671e-14)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  1.4523 
##     Estimated Std Err:  0.26887 
##               p-value:  6.6138e-08 
##     95% Conf Interval: (0.9253, 1.9793) 
## 
## Control Estimate:
##    Parameter Estimate:  1.4523 
##     Estimated Std Err:  0.26887 
##               p-value:  6.6138e-08 
##     95% Conf Interval: (0.9253, 1.9793) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.0682e-14 
##     Estimated Std Err:  2.867e-15 
##               p-value:  5.4321e-13 
##     95% Conf Interval: (1.5063e-14, 2.6302e-14)
```
