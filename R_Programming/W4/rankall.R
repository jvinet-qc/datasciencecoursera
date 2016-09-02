## From outcome-of-care-measures.csv code book:
# Row 2 = Hospital Name
# Row 7 = State: varchar (2)
# Row 11 = Hospital 30-Day Death (Mortality) Rates from Heart Attack: 
# Row 17 = Hospital 30-Day Death (Mortality) Rates from Heart Failure: 
# Row 23 = Hospital 30-Day Death (Mortality) Rates from Pneumonia: 

GetHospitalFromRank <- function(hospitalRanking, num){
    rank <- NULL
    if (num == "best"){
        rank <- 1
    }
    else if (num == "worst"){
        rank <- nrow(hospitalRanking)
    }
    else{
        rank <- as.numeric(num)
    }
    
    hospitalRanking[rank,1]
}

rankall <- function(outcome, num = "best", debug = FALSE) {
    
    source("printdbg.R")
    
    ## Read outcome data
    outcome_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    valid_outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    outcome_id <- valid_outcomes[outcome]
    if ( is.na(outcome_id) ){
        stop("invalid outcome")
    }
    printdbg(paste("Outcome =", names(valid_outcomes[outcome]),
                   "and ID =", outcome_id),
             debug)
    
    ## Subset the data frame and rename the columns
    subset_df <- subset( outcome_df, 
                         select = names(outcome_df)[c(2,7,outcome_id)] )
    names(subset_df) <- c("Hospital", "State", "Outcome")
    ## Make sure outcome is numeric
    suppressWarnings(subset_df$Outcome <- as.numeric(subset_df$Outcome))
    
    ## Order the subset by state, outcome, hospital
    subset_df <- subset_df[order(subset_df$State, subset_df$Outcome, subset_df$Hospita, na.last = NA), ]
    
    ranking_list  <- sapply(split(subset_df, subset_df$State), GetHospitalFromRank, num = num)
    ## lapply + unlist version:
    # ranking_list  <- lapply(split(subset_df, subset_df$State), GetHospitalFromRank, num = num)
    # unlist(ranking_list)
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    ranking_df <- data.frame(hospital=ranking_list, state=names(ranking_list), row.names=names(ranking_list))
    ranking_df
}