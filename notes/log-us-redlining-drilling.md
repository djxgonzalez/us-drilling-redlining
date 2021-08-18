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
- Get hex codes for HOLC grades

---

### 8.17.2021
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
