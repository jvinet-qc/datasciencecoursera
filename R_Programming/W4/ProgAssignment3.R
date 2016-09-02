## 1: Plot the 30-day mortality rates for heart attack
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11]) 
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])

## 2: Finding the best hospital in a state
## Here is some sample output from the function.
source("best.R")
best("TX", "heart attack")
#[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
best("TX", "heart failure")
#[1] "FORT DUNCAN MEDICAL CENTER"
best("MD", "heart attack")
#[1] "JOHNS HOPKINS HOSPITAL, THE"
best("MD", "pneumonia")
#[1] "GREATER BALTIMORE MEDICAL CENTER"
best("BB", "heart attack")
#Error in best("BB", "heart attack") : invalid state
best("NY", "hert attack")
#Error in best("NY", "hert attack") : invalid outcome

## 3: Ranking hospitals by outcome in a state
## Here is some sample output from the function.
source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
#[1] "DETAR HOSPITAL NAVARRO"
rankhospital("MD", "heart attack", "worst")
#[1] "HARFORD MEMORIAL HOSPITAL"
rankhospital("MN", "heart attack", 5000)
#[1] NA

## 4: Ranking hospitals in all states
source("rankall.R")
head(rankall("heart attack", 20), 10)
#       hospital                            state
# AK <NA>                                   AK
# AL D W MCMILLAN MEMORIAL HOSPITAL         AL
# AR ARKANSAS METHODIST MEDICAL CENTER      AR
# AZ JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
# CA SHERMAN OAKS HOSPITAL                  CA
# CO SKY RIDGE MEDICAL CENTER               CO
# CT MIDSTATE MEDICAL CENTER                CT
# DC <NA>                                   DC
# DE <NA>                                   DE
# FL SOUTH FLORIDA BAPTIST HOSPITAL         FL
tail(rankall("pneumonia", "worst"), 3)
#       hospital                                state
# WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
# WV PLATEAU MEDICAL CENTER                     WV
# WY NORTH BIG HORN HOSPITAL DISTRICT           WY
tail(rankall("heart failure"), 10)
#       hospital                                                        state
# TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL                          TN
# TX FORT DUNCAN MEDICAL CENTER                                         TX
# UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER  UT
# VA SENTARA POTOMAC HOSPITAL                                           VA
# VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR                             VI
# VT SPRINGFIELD HOSPITAL                                               VT
# WA HARBORVIEW MEDICAL CENTER                                          WA
# WI AURORA ST LUKES MEDICAL CENTER                                     WI
# WV FAIRMONT GENERAL HOSPITAL                                          WV
# WY CHEYENNE VA MEDICAL CENTER                                         WY


##-------------------------------
## Programming Assignment 3: Quiz
##-------------------------------
source("best.R")
# Q1:
best("SC", "heart attack")
#[1] "MUSC MEDICAL CENTER"

# Q2:
best("NY", "pneumonia")
#[1] "MAIMONIDES MEDICAL CENTER"

# Q3:
best("AK", "pneumonia")
#[1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"

source("rankhospital.R")
# Q4:
rankhospital("NC", "heart attack", "worst")
#[1] "WAYNE MEMORIAL HOSPITAL"

# Q5:
rankhospital("WA", "heart attack", 7)
#[1] "YAKIMA VALLEY MEMORIAL HOSPITAL"

# Q6:
rankhospital("TX", "pneumonia", 10)
#[1] "SETON SMITHVILLE REGIONAL HOSPITAL"

# Q7:
rankhospital("NY", "heart attack", 7)
#[1] "BELLEVUE HOSPITAL CENTER"

source("rankall.R")
# Q8:
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)
#[1] "CASTLE MEDICAL CENTER"

# Q9:
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
#[1] "BERGEN REGIONAL MEDICAL CENTER"

# Q10:
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
#[1] "RENOWN SOUTH MEADOWS MEDICAL CENTER"