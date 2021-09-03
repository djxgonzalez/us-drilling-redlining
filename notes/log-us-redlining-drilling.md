**Project Log**

# Redlining and siting of oil and gas wells in the U.S.

### Meta
- **Authors:**
  - David J.X. Gonzalez
  - [Danesha Byron?]
  - Rachel Morello-Frosch - University of California, Berkeley; rmf@berkeley.edu
  - Joan Casey, Columbia University, jac2250@cumc.columbia.edu
- **Journals:**
  - tbd
- **Presentations:**
  - SACNAS, October 2021 [abstract submitted 4.16.21, accepted 6._.21]

### Tasks
- preliminary descriptive results
- get 1940 census data from Box
- incorporate 1940s shapefile and census data
- revisit and revise concept note, split into two studies (national and Los Angeles)
- (re)make figure 1
- set up and run primary exposure assessment fo
- ask Danesha to digitize oil fields from Los Angeles HOLC maps

---

### 9.2.2021 Th
- I downloaded the 1940s census tract data from IPUMS, with the same variables from the Nardone et al. 2020 asthma paper
- I wrote a script to tidy up the IPUMS census tract data

### 9.1.2021 W
- Today I'm focusing on finalizing the exposure assessment (at least this iteration of it)
- I set up the post-1935 wells dataset
  - 8,520 wells met the criteria for both pre- and post-1935 wells (had production dates before *and* after 1935); these wells will be categorized as pre-1935
- I adapted the pre-1935 exposure assessment script to make a post-1935 script
- I started running the exposure assessment code; hopefully this will be done within a few hours

### 8.31.2021 Tu
- I made a memo to explore the pre-1935 wells exposure data
- I added an exposure assessment for pre-1935 unknown wells; there are 30,034 of these, nearly all of the 30,093 unknown wells in the full dataset. I'll need to think through what to do about these; I think it makes sense to include them in the pre-1935 analysis and maybe to handle them apart from the rest, though I'd expect them to be oil/gas wells.
-

### 8.30.2021 M
- I worked on the manuscript draft, expanding the outline and filling out some of the descriptive statistics for the datasets
- I re-did the city-level exposure assessments for cities; I found an error in that I'd failed to account for cities that have the same name in different states (e.g., Columbus OH and GA--but that may be the only case). I also combined the NYC boroughs into one variable for New York City
- Potential issue for inactive/postprod wells - Enverus doesn't report data, as far as I can tell, for well status. We can get this for states where we have production data (e.g., CA and PA), but we may not be able to do this for all cities with HOLC grades and wells
- I started a file for supplemental materials and added a Table 1 with the count of wells within 1, 3, and 10 km of the HOLC-graded neighborhoods.
- *Defining timing of the well.* We're dividing the study period in two: pre-1935 and post-1935. This may be too rough (i.e., HOLC grading may have not have occurred at the same time in all cities), but this should be sufficient for now. There are four date variables in the dataset: spud_date, completion_date, first_prod_date, and last_prod_date. There are missingdiffernt degrees of missingness for spud, completion, and produciton (though for every first prod date there's a last prod date). I'll define the time period for all wells using these criteria:
  - Pre-1935: Either spud_date or completion-date or first_prod_date or last_prod_date was on or before 12/31/1934
  - Post-1935: Either spud_date or completion_date or first_prod_date was on or after 1/1/1935
  - *Note:* This could lead to some wells being categorized in both if, for example, spud date was before 1935 and first_prod_date was after; in those cases, I'll assign the well to pre-1935 (i.e., I'll filter out all pre-1935 wells from the post-1935 group)
- I started the neighborhood-level exposure assessment for pre-1935 wells


...

### 8.23.2021 M
- I started the exposure assessment for the count of oil or gas wells within 1 and 3 km of neighborhood centroids

### 8.20.2021 F
- I finished exposure assessments for HOLC neighborhoods for producing wells and production volume, both 1 km and 3 km
- On Joan C's suggestion, I downloaded the 2008 TIGER/Line shapefile for the 1940 U.S. census tracts from NHGIS (IPUMS)
  - Note: there are shapefiles from both 2000 and 2008; 2008 is better for making comparisons with modern census tracts, which we may want to do. See this note:
    - "For users who have no need to compare historical boundaries with boundaries from 2010 or later, we recommend using the original 2000-based NHGIS boundary files. For users who do wish to compare or overlay historical boundaries with boundaries from 2010 or later, we recommend downloading and examining both the 2000- and 2008-based versions of historical boundaries in order to determine which is more suitable for your study area and analysis."
- This dataset is now saved under `data/raw/ipums/nhgis0001_shapefile_tl2008_us_tract_1940`

### 8.19.2021 Th
- After some final debugging, I ran the initial exposure assessment for wells within 3 km of the centroid of each HOLC neighborhood
- I started code overnight to run the exposure assessment to both all wells and producing wells within 1 km of neighborhood centroids
- I started a memo to explore the exposure data so far
- Most exposed HOLC neighborhoods are in five states: CA, OH, OK, PA, and TX

### 8.18.2021 W
- I finished writing the `assessExposureBufferCount` function and tested it; it gave me the same results as the lost function from last week! It looks like we're al set.

### 8.17.2021 Tu
- I wrote some code last week to assess exposure and make Figures 1 and 2, but unfortunately lost it all in a GitHub mishap. I made a new repo (that I own) and am starting from scratch to rewrite the code
- HOLC grading color hex codes:
  - A (green)  - #8D9B5C
  - B (blue)   - #8DA3A5
  - C (yellow) - #D0B561
  - D (red)    - #C0757E
- I finished script to re-make Figure 2, which shows the exposure assessment method
-

### 7.9.2021 F
- I talked with Joan C and Rachel M-F about this project; they're enthusiastic and we discussed some of the
- Danesha is invited to all the meetings, calendar invites
- Questions
    - Which cities do not have pre-HOLC drilling?
        - Tulsa and LA do, possibly others
        - Cities with pre-HOLC drilling may not be comparable with other cities
    - How many wells per city?
    - Direct intersections vs. intersect with buffers?
    - Can look at production volume, well density, and siting of wells
        - Also duration of production (start vs. end date)
    - Present-day abandoned and orphaned wells, too
- Jonathan Bonaporte at Harvard is putting together a database of wastewater disposal wells
    - Susceptibility to well failure
    - Question-- Are disposal wells in the dataset

### 7.2.2021 F
- DG and DB had a meeting to discuss sharing code and data
- We updated the project directory and synced it on GitHub
- We talked through how to organize project code + data

### 4.16.2021 F
- I got quick and detailed feedback from Rachel, Joan, and Wil
- I revised the abstract based on the feedback; we're still under 250 words!
- I submitted the abstract!
  - "Notification for complete applications will be sent by the May 24."

### 4.15.2021 Th
- I drafted an abstract to submit to the SACNAS National Diversity in STEM conference. I solicited feedback from Rachel M-F, Joan C, and Wil L-C; they got back quickly so we should be all set

### 3.24.2021
- Color hex codes for HOLC grades (get the standard ones)

### 3.19.2021
- I tidied the HOLC and Enverus wells data
- I tested the code for the intersection between the wells and HOLC data
- Summary statistics:
  - There were 28 cities from 13 states that had a least 10 wells that intersected with HOLC-graded neighborhoods
  - Cities with the most well intersections:
    - Los Angeles, CA - 5,866
    - Oklahoma City, OK - 978
    - Cleveland, Oh - 945
    - San Antonio, TX - 837
    - Erie, PA - 974
  - 7 of the cities were in Ohio; 3 cities each in Michigan, New York, Texas, and West Virginia
  - Wells per graded area:
    - A - 415
    - B - 1,078
    - C - 3,572
    - D - 5,596

### 3.16.2021
- I downloaded the Enverus wells data for most of the rest of the states
- I still need to download the data for PA, TX, and WV, as well as CA post-2015

### 3.13.2021
- I made a list of U.S. county names (with states) that intersect with the HOLC data
- I exported the list as `data/interim/holc_counties.csv`
- I'll use this list to go through the Enverus DrillingInfo data and download it by state or, for states with lots of drilling, by county
- I added a `data status` column to track whether I've downloaded the data yet
