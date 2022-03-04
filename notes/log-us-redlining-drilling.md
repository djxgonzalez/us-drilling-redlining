**Project Log**

# Historic redlining and siting of oil and gas wells in the United States

### Meta
- **Authors:**
  - David J.X. Gonzalez, UC Berkeley, djxgonz@berkeley.edu
  - Anthony Nardone, UC San Francisco, Anthony.nardone@ucsf.edu
  - Andrew V. Nguyen, UC Berkeley, andrew_nguyen@berkeley.edu, orcid.org/0000-0002-5585-9184
  - Rachel Morello-Frosch, University of California, Berkeley; rmf@berkeley.edu, orcid.org/0000-0003-1153-7287
  - Joan A. Casey, Columbia University, jac2250@cumc.columbia.edu, orcid.org/0000-0002-9809-4695
- **Journals:**
  1. Environmental Health (APC: $2,790)[submitted: 1.26.2022; desk rejection 1.31.2022]
  2. Journal of Exposure Science and Environmental Epidemiology (JESEE) (APC: $4,480) [submitted: 1.31.2022; revision submitted 3.3.2022]
  3. Journal of Urban Health
  4. Environmental Science & Technology (ES&T)
  5. Environmental Justice [may be a good home for the Los Angeles study]
- **Suggested Reviewers:**
  - Mahasin S. Mujahid - mmujahid@berkeley.edu - Professor of Public Health, UC Berkeley - Published a 2021 study on redlining and cardiovascular health
  - Jeremy S. Hoffman - jhoffman@smv.org - Scientist, Science Museum of Virginia - Published a 2019 study on redlining and urban heat exposure
  - Vivek Shandas - vshandas@pdx.edu - Professor, Portland State U - Co-author on a 2019 study on redlining and urban heat exposure
- **Presentations:**
  - SACNAS, October 2021 [abstract submitted 4.16.21, accepted 6.21, presented 10.21]

---

### Cover Letter

Drilling and operating oil and gas wells in residential neighborhoods exposes residents to pollution and other stressors that can increase risk of many types of disease. An estimated 17 million U.S. residents live within 1.6 km (1 mile) of active wells. Recent research has reported that residential proximity to wells is associated with adverse cardiovascular, respiratory, mental, and reproductive health outcomes. Several studies of these studies found that risk was heightened among racially and socioeconomically marginalized people, but the structural processes that could cause these racialized health disparities are not well understood. These studies could be driven by historic and persistent racist policies in housing, lending, and urban planning policies, including through a process known as redlining. In this study, we conducted a retrospective assessment of the association between grades assigned on racially discriminatory neighborhood security maps from the federal Home Owners Loan Corporation and the siting of oil and gas wells. In neighborhoods that were comparable at the time of appraisal but that received a different HOLC grades, the neighborhoods with worse grades had a significantly higher number and density of wells. The presence of wells in historically redlined neighborhoods remains relevant, as many of these redlined neighborhoods have persistent social inequities and the presence of wells, both active and post-production, can contribute to ongoing pollution. This work responds to the recent calls by in the literature for environmental health scientists to directly address structural factors that contribute to health disparities. To our knowledge, this is the first study to estimate the effect of redlining on the siting of oil wells.

The material in this manuscript is original research. We the authors have no potential competing interests to declare. All authors have approved the manuscript for submission. The content of the manuscript has not been published and it is not under consideration for publication elsewhere.

The corresponding author is Dr. David J.X. Gonzalez at the University of California, Berkeley. He is available by email at djxgonz@berkeley.edu and by phone at +1-805-714-6243.

---

### Tasks
- organize code and prep to post on GitHub
- re-submit and/or respond to reviewers as needed
- add Williams et al. (2021) citation for abandoned wells; maybe glean some details

---

### 03.03.2022 Th
- We got minor revisions from JESEE and some very positive (and kind) comments from peer reviewers
- I made the revisions and re-submitted in the evening

### 01.31.2022 M
- We got a desk rejection from Environmental Health; the editor did not think our study was a good fit (despite a recently-published call for more studies of structural racism in environmental health sciences)
- I prepared the manuscript for submission to JESEE

### 01.26.2022 W
- I drafted the cover letter above
- I made the fixes noted below to the exposure dataset
- After fixing the exposure data, I re-ran the TMLE models and updated the results table with point estimates and 95% confidence intervals
- I re-made the following results figures: Figs. 3 and 4, supplemental Figs. S7 and S8
- I also updated Table S1 with the correct count of wells in New York City
- I revised the manuscript text to reflect the updated estimates
- And that's a wrap!
- I finalized the submission on the EH author portal and attached all files
- I hit submit!

### 01.25.2022 Tu
- I noticed a discrepancy in the exposure data that sent up a red flag. I did some investigating over the past couple days and concluded that there were three (relatively minor) errors in the exposure assessment. I don't expect these to affect the overall, though this will likely change some of the point estimates.
  1. In the pre- and post-HOLC exposure assessments, I did not filter the wells to the types we're interested in (oil, gas, oil and gas, injection, unknown). This resulted in an over-count of the pre- and post-HOLC wells in some neighborhoods. I fixed this by editing the code and re-running all pre- and post-HOLC exposure assessments.
  2. In the post-HOLC analyses, I did not exclude wells that had pre-HOLC dates between 1935 and the year of appraisal (I did exclude pre-1935 wells). This resulted in some wells being counted twice, and consequently some neighborhoods had more pre-/post-HOLC wells than all-time wells, an obvious error. I fixed this error mathematically: post-HOLC wells = (post-HOLC wells - (all wells - (pre-HOLC + post-HOLC wells))).
  3. In the all wells (i.e., not pre- or post-HOLC) exposure assessment, I did not combine the New York boroughs into one city, which means when I filtered to cities with wells, these neighborhoods were not included and, consequently, assigned zero wells. This was not an issue for the pre- and post-HOLC analyses. I fixed this error by re-assessing exposure for NYC.
- I also got organized with the submission on Environmental Health and added suggested reviewers above

### 01.24.2022 M
- Exposure re-assessment is done, I'll verify tomorrow and make edits if needed
- I finished addressing comments from co-authors and Xing G, who provided some helpful feedback
- Pending the data quality check, we're good to go; hopefully I won't need to re-work too much

### 01.22.2022 Sa
- I troubleshooted the exposure assessment code; we have more pre/post-HOLC wells than all wells, which is clearly an error
- I made a Rmd notebook to address this
- I think I found the error and fixed it in the code
- I re-ran pre/post-apprisal exposure assessment

### 01.21.2022 F
- At this point, I have feedback from the co-authors + Xing G on the most recent draft of the manuscript
- Joan C is good with submitting, once we address the comments
- Rachel M-F would like an opportunity for another look, so I'll aim to send the paper to her today or tomorrow (and give her ~24 hrs to look it over)
- We should be ready to submit to *Environmental Health* in the next few days
- I started with revisions for the supplemental materials
- I renumbered code for making figures and copied over the propensity score matching code, so we can post everything to GitHub; I'll need to do some more wrangling and organizing to get everything ready, but we'll get there
- I finished revising supplemental materials before my lunch break, including some details in the figures.

...

### 01.11.2022 Tu
- I did some more work on revisions based on Joan's comments, including for the figures
- I met with Andrew N; he helped with a couple of the comments and revising the new Figure S2 (flowchart)

### 01.10.2022 M
- Coming back from winter break last week, I picked up work on the manuscript
- I've addressed most of Joan C's comments, just a few more points to address, including some revisions to the figures
- I'll finish these up tomorrow and re-send everything to the co-authors
- Also need to ask Andrew to make some revisions to Figure S2 he made

### 12.17.2021 F
- I re-made Figure 2 to focus on neighborhood D53 with a 100 m buffer for all wells (no pre-/post-HOLC distinction now)
- Andrew sent a revised Table 1 and updated propensity score-matched datasets

### 12.16.2021 Th
- Anthony N sent over the corrected apportioned census dataset; apparently the dataset we've been using from Rachel's server was corrupted
- I incorporated this data into the processed neighborhood exposure dataset; I also fixed the 100 m oil/gas exposure dataset (turns out I'd made a typo and replaced the 100 m with the 0 m dataset)
- I sent the dataset to Andrew and updated it on Box
- In the West Oakland Environmental Indicators Project meeting I attended yesterday, Miss Margaret asked Joan to define a technical term and, importantly, whether they'd defined the term in their manuscript. This is an important issue that I want to keep in mind; we're writing for multiple audiences, not just other scientists or peer reviewers, but also affected communities and advocates
- With that in mind, I revised the manuscript for readability; I removed some of the technical terms and made sure to explain things more clearly rather than relying on citations to speak for themselves (and for the readers to be familiar with the literature). I think this is particularly important for this study.
- Also: I called dad to zero in on Mama Grande’s house: 1863 E Vernon Ave., Vernon, CA (it’s on the corner of Vernon and Alameda). I wanted to look up where it is in relation to the HOLC redlining map of Los Angeles. The house is in an area that was labeled industrial, a block away from a redlined neighborhood. It turns out, the home is on the Figure 2 map I’ve been making for the redlining paper. My mind was blown, and so was dad’s. Also, some interesting details on the neighborhood adjacent to Mama Grande’s from Mapping Inequality (D52 in Los Angeles).

### 12.15.2021 W
- Andrew N found some apparent errors in the apportioned census data; I asked him to email Anthony N to see if there's a corrected dataset
- Andrew also noticed an apparent error in the exposure assessment; for the oil/gas-specific exposure data, the 0 m and 100 m buffer exposure data were the same

### 12.07.2021 W
- I finalized the draft manuscript and circulated it to co-authors for comment!
- This was a big step; I've been making a big push the last week to get to this stage
- There are a few items left to do, but I'll focus on other projects for the next few days and get back to this one early next week

### 12.06.2021 Tu
- Next up:
  - Check distribution (by city) of wells without dates; maybe we can get these from state-level datasets (especially for LA)
  - Re-do TMLE with revised propensity score-matched datasets
  - Re-make Figure 4
  - Andrew:
    - Re-do propensity scores without exposure to wells
    - Make Figure 3a-style figures for each of the three well types: oil & gas; unknown, injection (it's labeled `production_type`)
    - Make Figure 4-style figures for 0 m and 1 km buffers

### 12.05.2021 M
- I verified that we in fact don't have census data for Oklahoma or Texas cities with wells
- I changed Table S2 to Table 1 and revised it to restrict to cities with wells within 100 m of HOLC neighborhoods (it was 3 km previously)
- I worked on the manuscript, filled in results

### 11.29.2021 M
- I reviewed submission criteria from *Environmental Health*:
  - double-spaced, line and page numbers, no page breaks
  - encourage depositing data into public repository
  - information about data availability should be detailed in an ‘Availability of data and materials’ section
    - "The dataset(s) supporting the conclusions of this article is(are) available in the [repository name] repository, [unique persistent identifier and hyperlink to dataset(s) in http:// format]."
  - more: https://ehjournal.biomedcentral.com/submission-guidelines/preparing-your-manuscript
- I logged into author central using my OrcID and started a submission for this manuscript
- My goal is to submit in the next couple weeks!
- I got back to work putting together the analytic dataset for this analysis
- I found an error in the exposure assessment data (there was a missing 100 m buffer dataset), and went through the data and code to see what I'd missed--I'd mistakenly labeled the `holc_neighborhoods_buffer_100m_wells_oil_gas.csv` as `holc_neighborhoods_buffer_0km_wells_oil_gas.csv` when I called the export function
  - I re-named the file and re-ran the 0 km exposure assessment
  - I checked the data; this was the only mis-labeled dataset
- Dropped three neighborhoods with area of 0
- Seemed to be an error when summarizing 100 m city-level exposure; a few NAs pop up; I re-ran the exposure code
-

### 11.23.2021 Tu
- I worked on re-assembling the analytic dataset, with the 100 m buffer exposure data included

### 11.22.2021 M
- I've been working on descriptive stats for the exposure
- Add to Fig. 3 - distinct b/t wells within 0 km and 1 km
- Made a big-ish decision today - we're going to scrap the 3 km and 1 km buffers and use a smaller buffer
- Email to Joan and Rachel:
  Following up on our discussion on buffers, here's the quartiles for neighborhood area (in km2), restricted to neighborhoods with any wells:

  0.0775225  0.7886793  1.3999435  2.8726211 22.5530093

  A neighborhood with an area of 0.08 km^2 could be 280 x 280 m (if it's a square) or 100 x 800 m if it's on the longer side. Given that, my thought is to go with a buffer of 100 m so as not to subsume adjacent polygons.
- We may want to use the 1 km (or maybe a 500 m) buffer if we get pushback from reviewers; otherwise, I think we'll be fine with no buffer + 100 m buffer (with 100 m as the primary)
- I set up and ran the 100 m exposure assessment overnight, for all wells, pre-HOLC, and post-HOLC wells (also divided by type)
-

### 11.19.2021 F
- I made a draft of Figure 3

### 11.18.2021 Th
- Revised abstract, article methods
- Looked into journal APCs, impact factors
- Let's go with Environmental Health first - lower APC and higher impact

### 11.17.2021 W
- I made Table S2, which summarizes census data by HOLC grade

### 11.13.2021 Sa
- I set up the exposure assessment to run for oil/gas wells, injection wells, unknown wells, and all wells (the aggregate of the other three categories) *without* taking timing into account (i.e., not pre- or post-HOLC)
  - This should include wells that don't have production dates; it'll be interesting to see how many additional wells this is compared to the restrictions with dates (and if there are patterns in the missingness)

### 11.12.2021 F
- I finalized the analytic dataset; will need to add some exposure variables but we're in great shape
- We'll omit shale play/oil basins data; the polygons are too big, not helpful for differentiating neighborhoods
- For propensity score analyses, we'll calculate scores for neighborhoods with adjacent gradings: D-C, C-B, and B-A
- Andrew N made some progress with

### 11.10.2021 W
- I joined the HOLC dataset I've been working off of with the Nardone data using centroid coordinates, on Andrew N's excellent suggestion
- It worked! But there's one weird thing--we have 30 additional neighborhoods not in the HOLC dataset I've been working off of; these may be in one of the cities omitted from the current study that doesn't have oil/gas wells

### 11.06.2021 Sa
- Revise Figure 2, moved to new neighborhood that illustrates better; feel like it looks good, may be final!

### 11.05.2021 F
- I worked on writing the methods section, and carefully re-read the Nardone et al. 2021 paper
- They did use HOLC neighborhoods as unit of observation; I think Joan may have been mistaken last week when she said they used tracts
- I emailed Joan to see what she thinks and if we're good to go with HOLC neighborhoods instead of census tracts
- Worked on Fig. 2a and 2b; let's shift to NE Los Angeles for a better viz of pre- and post-HOLC well placement to emphasize what we're seeing

### 11.03.2021 W
- I updated the scripts and data on the Box folder so Andrew N can have access to it
-  I revise the draft Figure 1 and added it to the draft manuscript

### 11.02.2021 Tu
- Looked at overlap of wells and play in LA; seems to mostly agree, a few well outside of it
  - what type of wells?
- I met with Andrew N to discuss his contributions to the study, now that he's had some time to get up to speed
- We also reviewed my organization method and approach to structuring code and project folders; he said it was helpful, and it seems potentially worth writing up and sharing more broadly
- Andrew be helping with the propensity score matching; I sent him Sainani (2012), which reviews this method
- I shared the Box project folder with Andrew so he has access to our code and data

### 11.01.2021 M
- I looked into the availability of oil fields data; we're interested in smaller scale data so we can differentiate neighborhoods that could have plausibly had oil wells sited with neighborhoods that couldn't because they were not near exploitable oil or gas reservers
- The EIA dataset that Joan sent has oil basins and plays, but these seem to be broader geographic scales than what we're looking for; I think we need oil fields
- I'll search the EIA and DrillingInfo sites for shapefiles on oil fields
- Also -- I no longer have access to Enverus DrillingInfo through Stanford; I'll need to request access through Rachel's group. I couldn't find instructions on the Enverus website, so I signed up for more info; if they don't get in touch in the next day or two, I'll send an email
  - they called me to see what my needs are (think they respond quickly to prospective industry contacts)
  - they said they'd put me in touch with someone about getting access; I'll follow-up if that doesn't happen

### 10.29.2021 F
- Discussed concept note with Joan and Rachel, got constructive feedback
- They convinced me that it makes the most sense to focus on 1940s census tracts as the unit of observation
- We'll go that route, which is simpler, since we have those data already from the Nardone et al. (2021) study
- Anthony Nardone is already onboard; since we're leaning so heavily on his data and methods, I think he should be second author
- I started revising the concept note (draft 03) to reflect these changes
- Next: finish revising the concept note, then get organized with the 1940s census tracts data, figure out which cities we're including (10 wells within 3 km of HOLC-graded neighborhoods), and do the exposure assessments
- Also, update the tasks above (well density per tract; revise figures; etc.)

### 10.27.2021 W
- I took a look at he data fro the Nardone greenspace study, labeled as 'for peter' (I think for the Harvard Peter)
- I renamed the folder as `data/interim/holc_census_1940` and re-named the shapefile and csv to match
- This dataset includes 1940s census tract data aggregated to the HOLC neighborhood; what we don't have is 1940 census tracts themselves
- I reviewed the Nardone et al. studies; the 2021 greenspace paper is most relevant to use, since it's national, so I'll use those data
- I downloaded 1940s census tract GIS files from https://www.nhgis.org/
  - It looks like I already did this; should've checked my notes!

### 10.20.2021 W
- I added the `us redlining drilling` project folder to the SHE lab box, so that I can share it with collaborators

### 10.19.2021
- I met with Andrew Nguyen, a first-year MPH student interested in learning geospatial methods in R; we discussed the redlining project and whether he's interested in contributing, and he said he was
- I'll aim to get Andrew up to speed quickly so he can get to work
- I sent Andrew an email with relevant papers and R training resources
- Also, I asked Claire M re: ACS data download, and she suggested using an API instead of manually downloading the data (as she did for the CA proximity project)
  - Claire will ask her classmates for API suggestions

### 10.15.2021
- Got 1940s census tracts data made by Antony Nardone, labeled as ‘For Peter’ on the SHE Lab server
- Add this under 'Redlining' folder in `data/interim/`

### 10.13.2021 W
- I finished putting together the draft slide presentation for SACNAS NDiSTEM 2021
- Took most of the day; got preliminary results that I visualized, specifically, wells within 1 km of HOLC neighborhood boundaries

### 10.12.2021 Tu
- I finished drafts of Figures 1 and 2 for the presentation
- I revised Figure 2 to reflect the new exposure assessment for HOLC neighborhoods, i.e., 1 km buffer around neighborhood boundaries
  - Note: this will be panel a; panel b will be block group-level exposure with centroids (since this is national, can't do dasymetric)

### 10.11.2021 M
- The exposure assessment for original HOLC neighborhoods is done
- I still need to assess exposure to block groups; will need to get those data for outside California
- I worked on draft Figure 1 to include in the NDiSTEM presentation; ran into some hurdles, took longer than it should have

### 10.9.2021 Sa
- I set up and started running
- For this set of analyses, I decided to focus on wells that had any production dates after January 1, 1935. For each city, we filter wells that were drilled before appraisal
- I started running the code at 9:45am to test it. It works
- I'll likely run the code overnight we get to Soulsbyville for the weekend

### 10.8.2021 F
- Adapted pre-HOLC exposure assessment to account do the post-HOLC exposure assessment
- Defaulted to 1940 as year to use when appraisal date missing; latest date, most conservative estimate; could also use median year (which was 1938)

### 10.7.2021 Th
- I fixed the issue! I forgot to take out the `st_centroid` call when setting up the environment with the neighborhoods data, so I was looking at intersections of points on points (which is why it was all 0s)
- Finished the pre-HOLC exposure assessment for all wells
- I set up and ran the rest of the pre-HOLC exposure assessments (oil/gas wells, injection wells, 'unknown' wells [which are nearly all pre-HOLC, so we're including them])
- Stopped before unknown's; run those later tonight

### 10.6.2021 W
- Trouble-shooting an error where the pre-HOLC exposure assessment without buffering (i.e., direct intersection with the neighborhoods) has 0 wells for all neighborhoods

### 9.23.2021 Th
- Revised exposure assessment for pre-appraisal
- Verified it work--seems to!
- Ran exposure assessment for pre-appraisal
- Revised concept note; described two arms in exposure assessment..

### 9.20.2021 M
- I revised the neighborhood-level exposure assessment code, omitting producing wells and production volume (we're going to do that for only the LA-specific study)
- The years each HOLC map was generated are reported in the Univ. of Richmond website; we can glean these from the maps themselves and also from the links to each city's map (an easier way to do it!)
- I copied the years each map was published to the Table S1 csv I'd previously exported
  - Specific dates are available, but I don't think we need to be fine-grained with the dates; wells drilled the month before the map was published shouldn't have any effect
  - Need to back this up so I don't delete it by accident!
    - Backed it up under the resources folder
- There are some missing years of appraisal, e.g., Council Bluffs, IA
  - Not reported on the website; couldn't find it on the scanned map
  - We could assume appraisal happened in 1935 and just include wells developed before then
  - We'd need to be thoughtful about post-apprisal wells - could assume 1940 for that!
  - Maybe see how many wells were drilled in the year of appraisal for each city (and the years before and after)
- Note: All five New York City boroughs had maps published in 1938


### 9.17.2021 F
- Additions to exposure assessment protocol after talking with Joan C:
  1. Pre-appraisal - use the neighborhoods themselves
    - Count wells near neighborhoods using (1) direct intersections with the polygon and (2) 1 km buffer from the polygon boundary
      - Can also normalize to wells per sq km
      - See if these converge in terms of most/least exposed neighborhoods
    - Also - use census tracts data to get pop estimates at each neighborhood
  2. Post-appraisal - use dasymetric data (populated areas) within census block groups
    - maybe compare with centroid method to make sure they converge
    - assign HOLC grades to block groups
    - could look into treating populated areas as unit of obs; could work for this pop proximity study
  - look into lit from other disciplines for sub-bg level exposures, dasymetric analyses

### 9.16.2021 Th
- I put some thought into exposure assessment, and have some ideas
- I don't think it makes sense to use modern datasets to assess historic exposure to wells; we'll rely on the data we have from the 1930s, which includes 1940s census tracts and the HOLC neighborhoods themselves
- In this study, we're asking two sets of questions (pre-appraisal and post-appraisal siting), so should do the exposure assessment in two parts:
  1. Pre-appraisal - use the neighborhoods themselves
    - Count wells near neighborhoods using (1) centroid method, (2) direct intersections with the polygon, and (3) 1 km buffer from the polygon boundary
    - See if these generally agree; if so, categorize neighborhoods based on n wells; if not, re-assess
  2. Post-appraisal - can use census block groups
    - assign block groups HOLC grade (maybe proportionally?)

### 9.8.2021 W
- Today I worked on revising the concept note for this project, making changes based on recent feedback from Rachel and Joan
- I had a call with Danesha B; she may be interested in continuing to contribute to this project, but needs to assess whether she has capacity. We'll talk again next week

### 9.3.2021 F
- Action items and changes based on conversation with Rachel and Joan:
  - Split this into two studies:
    - National study
      - Focus on exposure to all wells, excluding those with few
    - Los Angeles
      - Investigate well types, production volume (using more recent data, e.g. 2000-2019)
  - Questions to answer
    - Where are the CBM (coal bed methane) wells located?
- Next steps:
  - Find a way to normalize the neighborhoods by area


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
