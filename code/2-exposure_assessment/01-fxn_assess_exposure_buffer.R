##============================================================================##
## 2.01 - a flexible function to generate a buffer of a given distance (in m)
## around either a point or a polygon, count the number of wells in the buffer,
## and return the result


##---------------------------------------------------------------------------
## defines function for well count
assessExposureBufferCount <- function(data_geography, 
                                      data_wells,
                                      buffer_dist_m,
                                      exp_variable) {
  
  # generates buffer of given distance (m) as a mask around monitor coordinates
  data_geography_buffer <- data_geography %>% 
    st_transform(crs_projected) %>%
    st_buffer(dist = buffer_dist_m) %>%
    st_transform(crs_nad83)
  
  # subsets to wells that intersect with 'data_geography_buffer'
  wells_within_buffer <- data_wells %>%
    st_intersection(data_geography_buffer)
  
  # adds exposure variable
  if (nrow(wells_within_buffer) > 0) {
    data_geography <- data_geography %>%  
      mutate(!!as.name(exp_variable) :=   
               sum(unlist(st_intersects(wells_within_buffer, 
                                        data_geography_buffer)))) %>%
      as_tibble() %>% 
      select(-geometry)
  } else if (nrow(wells_within_buffer) == 0) {
    data_geography <- data_geography %>% 
      mutate(!!as.name(exp_variable) := 0) %>%
      as_tibble() %>% 
      select(-geometry)
  }
  
  #.........................................................................
  # returns the processed exposure data
  return(data_geography)
  
}


##---------------------------------------------------------------------------
## defines function for production volume
assessExposureBufferVolume <- function(data_geography, 
                                       data_wells,
                                       buffer_dist_m,
                                       exp_variable) {
  
  # generates buffer of given distance (m) as a mask around monitor coordinates
  data_geography_buffer <- data_geography %>% 
    st_transform(crs_projected) %>%
    st_buffer(dist = buffer_dist_m) %>%
    st_transform(crs_nad83)
  
  # subsets to wells that intersect with 'data_geography_buffer'
  prod_within_buffer <- data_wells %>%
    st_intersection(data_geography_buffer) %>%
    select(cumulative_boe)
  
  # adds exposure variable
  if (nrow(prod_within_buffer) > 0) {
    data_geography <- data_geography %>%  
      mutate(!!as.name(exp_variable) :=   
               as.matrix(aggregate(x = prod_within_buffer, 
                                   by = data_geography_buffer, 
                                   FUN = sum))[[1]]) %>%
      as_tibble() %>% 
      select(-geometry)
  } else if (nrow(prod_within_buffer) == 0) {
    data_geography <- data_geography %>% 
      mutate(!!as.name(exp_variable) := 0) %>%
      as_tibble() %>% 
      select(-geometry)
  }
  
  #.........................................................................
  # returns the processed exposure data
  return(data_geography)
  
}


##============================================================================##