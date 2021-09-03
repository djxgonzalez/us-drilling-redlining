##============================================================================##

# import and Merge csv files. 
source("code/1-data_tidying/1-tidy_enverus_data.R")



# input the raw Enverus wells data, tidy it, and bind it together
enverus_wells <-
  tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_al_il.csv")) %>%
  
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_ca.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_in_ky.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_ks.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_la.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_md_ne.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_nc_ny.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_nm.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_oh.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_ok.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_or_wa.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_pa.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_tx.csv"))) %>%
  dplyr::bind_rows(tidyEnverusWellsData(read_csv("data/raw/enverus/enverus_wells_wv.csv"))) 
  


# export the interim Enverus wells data as a rds file
saveRDS(enverus_wells, file = "data/interim/enverus_wells_interim.rds")

##============================================================================##
