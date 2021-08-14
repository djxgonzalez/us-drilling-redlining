#####===========================================================================
##### 0. Setup

# loads necessary packages and defines global variables
source("code/0-setup/1-setup.R")


#####===========================================================================
##### 1. Data Tidying

# attaches functions for tidying raw data
source("code/1-data_tidying/1-tidy_enverus_data.R")

# imports raw data, calls tidying functions, exports interim data
source("code/1-data_tidying/2-call-data_tidying.R")


#####===========================================================================
##### 2. Exposure Assessment


#####===========================================================================
##### 3. Analysis




#####===========================================================================
##### 4. Communication

# imports raw and processed data, preps data as needed, and generates Figure 1
source("code/4-communication/1-make_figure1.R")



##============================================================================##