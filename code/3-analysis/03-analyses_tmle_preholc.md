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
##     Ynodes = "wells_0km_all_preholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.023792 
##     Estimated Std Err:  0.010739 
##               p-value:  0.026727 
##     95% Conf Interval: (0.0027439, 0.04484) 
## 
## Control Estimate:
##    Parameter Estimate:  0.023792 
##     Estimated Std Err:  0.010739 
##               p-value:  0.026727 
##     95% Conf Interval: (0.0027439, 0.04484) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  -1.8215e-17 
##     Estimated Std Err:  4.903e-17 
##               p-value:  0.71026 
##     95% Conf Interval: (-1.1431e-16, 7.7882e-17)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_preholc_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.017975 
##     Estimated Std Err:  0.010577 
##               p-value:  0.089246 
##     95% Conf Interval: (0, 0.038706) 
## 
## Control Estimate:
##    Parameter Estimate:  0.017975 
##     Estimated Std Err:  0.010577 
##               p-value:  0.089246 
##     95% Conf Interval: (0, 0.038706) 
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
##     Ynodes = "wells_100m_all_preholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_ab_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.037248 
##     Estimated Std Err:  0.013807 
##               p-value:  0.0069802 
##     95% Conf Interval: (0.010187, 0.064308) 
## 
## Control Estimate:
##    Parameter Estimate:  0.037248 
##     Estimated Std Err:  0.013807 
##               p-value:  0.0069802 
##     95% Conf Interval: (0.010187, 0.064308) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  1.6393e-16 
##     Estimated Std Err:  1.9051e-16 
##               p-value:  0.38952 
##     95% Conf Interval: (-2.0946e-16, 5.3732e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_preholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_ab_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.032734 
##     Estimated Std Err:  0.014796 
##               p-value:  0.02694 
##     95% Conf Interval: (0.0037348, 0.061733) 
## 
## Control Estimate:
##    Parameter Estimate:  0.032734 
##     Estimated Std Err:  0.014796 
##               p-value:  0.02694 
##     95% Conf Interval: (0.0037348, 0.061733) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  1.1217e-16 
##     Estimated Std Err:  3.8173e-17 
##               p-value:  0.0032971 
##     95% Conf Interval: (3.7357e-17, 1.8699e-16)
```


# B-C neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_preholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.030256 
##     Estimated Std Err:  0.0078596 
##               p-value:  0.00011835 
##     95% Conf Interval: (0.014851, 0.04566) 
## 
## Control Estimate:
##    Parameter Estimate:  0.030256 
##     Estimated Std Err:  0.0078596 
##               p-value:  0.00011835 
##     95% Conf Interval: (0.014851, 0.04566) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  1.0408e-16 
##     Estimated Std Err:  1.7446e-17 
##               p-value:  2.4301e-09 
##     95% Conf Interval: (6.989e-17, 1.3828e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_preholc_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.018579 
##     Estimated Std Err:  0.0049647 
##               p-value:  0.00018239 
##     95% Conf Interval: (0.0088485, 0.02831) 
## 
## Control Estimate:
##    Parameter Estimate:  0.018579 
##     Estimated Std Err:  0.0049647 
##               p-value:  0.00018239 
##     95% Conf Interval: (0.0088485, 0.02831) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  3.6522e-16 
##     Estimated Std Err:  3.1958e-17 
##               p-value:  <2e-16 
##     95% Conf Interval: (3.0258e-16, 4.2785e-16)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_preholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_bc_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.048274 
##     Estimated Std Err:  0.011114 
##               p-value:  1.4018e-05 
##     95% Conf Interval: (0.026491, 0.070057) 
## 
## Control Estimate:
##    Parameter Estimate:  0.048274 
##     Estimated Std Err:  0.011114 
##               p-value:  1.4018e-05 
##     95% Conf Interval: (0.026491, 0.070057) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  2.55e-16 
##     Estimated Std Err:  2.4729e-17 
##               p-value:  <2e-16 
##     95% Conf Interval: (2.0654e-16, 3.0347e-16)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_preholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_bc_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.035969 
##     Estimated Std Err:  0.0096614 
##               p-value:  0.00019693 
##     95% Conf Interval: (0.017033, 0.054905) 
## 
## Control Estimate:
##    Parameter Estimate:  0.035969 
##     Estimated Std Err:  0.0096614 
##               p-value:  0.00019693 
##     95% Conf Interval: (0.017033, 0.054905) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  6.1134e-17 
##     Estimated Std Err:  8.5033e-18 
##               p-value:  6.505e-13 
##     95% Conf Interval: (4.4468e-17, 7.78e-17)
```


# C-D neighborhoods

## 0 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_preholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.23767 
##     Estimated Std Err:  0.10127 
##               p-value:  0.018934 
##     95% Conf Interval: (0.03918, 0.43617) 
## 
## Control Estimate:
##    Parameter Estimate:  0.23767 
##     Estimated Std Err:  0.10127 
##               p-value:  0.018934 
##     95% Conf Interval: (0.03918, 0.43617) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  5.6812e-15 
##     Estimated Std Err:  1.0196e-15 
##               p-value:  2.5199e-08 
##     95% Conf Interval: (3.6828e-15, 7.6796e-15)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_0m_all_preholc_density", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_0m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.20275 
##     Estimated Std Err:  0.076349 
##               p-value:  0.0079182 
##     95% Conf Interval: (0.053106, 0.35239) 
## 
## Control Estimate:
##    Parameter Estimate:  0.20275 
##     Estimated Std Err:  0.076349 
##               p-value:  0.0079182 
##     95% Conf Interval: (0.053106, 0.35239) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  9.1997e-16 
##     Estimated Std Err:  2.1023e-16 
##               p-value:  1.2093e-05 
##     95% Conf Interval: (5.0792e-16, 1.332e-15)
```

## 100 m exposure

**Count**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_preholc", gform = gform, abar = list(1, 
##         0), SL.library = SL.library, observation.weights = holc_matched_cd_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.31777 
##     Estimated Std Err:  0.12447 
##               p-value:  0.010684 
##     95% Conf Interval: (0.073802, 0.56173) 
## 
## Control Estimate:
##    Parameter Estimate:  0.31777 
##     Estimated Std Err:  0.12447 
##               p-value:  0.010684 
##     95% Conf Interval: (0.073802, 0.56173) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  3.7236e-15 
##     Estimated Std Err:  9.584e-16 
##               p-value:  0.00010225 
##     95% Conf Interval: (1.8451e-15, 5.602e-15)
```

**Density**


```
## Estimator:  tmle 
## Call:
## ltmle(data = data_tmle, Anodes = "treatment", Lnodes = NULL, 
##     Ynodes = "wells_100m_all_preholc_density", gform = gform, 
##     abar = list(1, 0), SL.library = SL.library, observation.weights = holc_matched_cd_100m$weights)
## 
## Treatment Estimate:
##    Parameter Estimate:  0.27007 
##     Estimated Std Err:  0.093261 
##               p-value:  0.0037817 
##     95% Conf Interval: (0.087279, 0.45285) 
## 
## Control Estimate:
##    Parameter Estimate:  0.27007 
##     Estimated Std Err:  0.093261 
##               p-value:  0.0037817 
##     95% Conf Interval: (0.087279, 0.45285) 
## 
## Additive Treatment Effect:
##    Parameter Estimate:  4.5227e-16 
##     Estimated Std Err:  1.5758e-16 
##               p-value:  0.0041029 
##     95% Conf Interval: (1.4342e-16, 7.6112e-16)
```
