## From outcome-of-care-measures.csv code book:
# Row 2 = Hospital Name
# Row 7 = State: varchar (2)
# Row 11 = Hospital 30-Day Death (Mortality) Rates from Heart Attack: 
# Row 17 = Hospital 30-Day Death (Mortality) Rates from Heart Failure: 
# Row 23 = Hospital 30-Day Death (Mortality) Rates from Pneumonia: 
rankhospital <- function(state, outcome, num = "best", debug = FALSE) {
    source("printdbg.R")
    ## Read outcome data
    outcome_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    valid_states <- unique(outcome_df[, 7])
    if (charmatch(state, valid_states, nomatch = 0) == 0){
        stop("invalid state")
    }
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (charmatch(outcome, valid_outcomes, nomatch = 0) == 0){
        stop("invalid outcome")
    }
    
    outcome_id = NULL
    if (outcome == valid_outcomes[1]){
        outcome_id <- 11
        printdbg("outcome = heart attack", debug)
    }
    else if (outcome == valid_outcomes[2]){
        outcome_id <- 17
        printdbg("outcome = heart failure", debug)
    }
    else if (outcome == valid_outcomes[3]){
        outcome_id <- 23
        printdbg("outcome = pneumonia", debug)
    }
    
    ## Return hospital name in that state with the given rank 30-day death rate
    state_subset_df <- subset(outcome_df, outcome_df[,7] == state)
    suppressWarnings(state_subset_df[, outcome_id] <- as.numeric(state_subset_df[, outcome_id]))
    
    rate_ordered <- state_subset_df[order(state_subset_df[,outcome_id], state_subset_df[,2], na.last = NA), ]
    
    rank = NULL
    if (num == "best"){
        rank <- 1
    }
    else if (num == "worst"){
        rank <- nrow(rate_ordered)
    }
    else{
        rank <- as.numeric(num)
    }
    printdbg(rank, debug)
    
    printdbg(head(rate_ordered), debug)
    rate_ordered[rank,2]
    
}