##============================================================================##
## 2.01


##---------------------------------------------------------------------------
##  

assessExposureBufferCount <- function(data_geography, 
                                      data_wells,
                                      buffer_dist_m,
                                      exp_variable_root) {
  
  # generates 10 km buffer as a mask around monitor coordinates
  data_geography_mask <- data_geography %>% 
    st_transform(crs_projected) %>%
    st_buffer(dist = buffer_dist_m) %>%
    st_transform(crs_nad83)
  
  # subsets to wells that intersect with 'data_geography_mask'  i.e., within 15 km of 
  # the maternal residence, and that have preproduction/production period 
  # that overlaps with the date
  if (well_stage == "new") {
    
    # well sites in preproduction stage
    wells_within_buffer <- data_wells %>%
      # restricts to wells within 15 km of the input monitor
      st_intersection(data_geography_mask) %>%
      # adds monitor date
      mutate(monitor_date = monitor_date) %>%
      # adds indicator for whether well was in preproduction (drilling) stage
      # during the date
      mutate(exposed  = exposed1 + exposed2) %>%
      # keeps only monitors that are exposed
      filter(exposed >= 1)
    
  } else if (well_stage == "active") {
    
    wells_within_buffer <- data_wells %>%
      # restricts to wells within 15 km of the input monitor
      st_intersection(data_geography_mask) %>%
      # adds monitor date
      mutate(monitor_date = monitor_date) %>%
      # adds indicator for whether well was in production (active) stage
      # during the date
      mutate(exposed = int_overlaps(monitor_date, prod_exp_interval)) %>%
      filter(exposed == 1)
    
  }
  
  

  if (nrow(wells_within_buffer) > 0) {
    
    #.........................................................................
    # counts wells within each 1-km annulus
    monitor <- monitor %>%  
      mutate(!!as.name(exp_variable_root) :=   
               sum(unlist(st_intersects(wells_within_buffer, annulus0to1)))) %>%
      as_tibble() %>% 
      select(-geometry)
    
  } else if (nrow(wells_within_buffer) == 0) {
    
    monitor <- monitor %>% 
      
      mutate(!!as.name(exp_variable_root, sep = "", "0to1km")   := 0) %>%
      as_tibble() %>% 
      select(-geometry)
    
  }
  
  
  #.........................................................................
  # returns the processed exposure data
  
  return(monitor)
  
}


#.........................................................................
# 


##============================================================================##