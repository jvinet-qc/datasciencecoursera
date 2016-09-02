## From outcome-of-care-measures.csv code book:
#
# 2. Hospital Name: varchar (50) Lists the name of the hospital.
# 7. State: varchar (2) Lists the 2 letter State code in which the 
#       hospital is located.
# 11. Hospital 30-Day Death (Mortality) Rates from Heart Attack: 
#       Lists the risk adjusted rate (percentage) for each hospital.
# 17. Hospital 30-Day Death (Mortality) Rates from Heart Failure: 
#       Lists the risk adjusted rate (percentage) for each hospital.
# 23. Hospital 30-Day Death (Mortality) Rates from Pneumonia: 
#       Lists the risk adjusted rate (percentage) for each hospital.

best <- function(state, outcome,
                 debug = FALSE) {
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
    
    ## Return hospital name in that state with lowest 30-day death rate
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
    
    state_subset_df <- subset(outcome_df, outcome_df[,7] == state)
    suppressWarnings(state_subset_df[, outcome_id] <- as.numeric(state_subset_df[, outcome_id]))
    
    lowest_rate <- min(state_subset_df[,outcome_id], na.rm = TRUE)
    printdbg(paste("Lowest rate =", lowest_rate), debug)
    
    best <- subset(state_subset_df, state_subset_df[,outcome_id] == lowest_rate, select = c(2, 7, outcome_id))
    ## To test sorting when multiple hospitals are equals:
    #best <- subset(state_subset_df, state_subset_df[,outcome_id] == 10.0, select = c(2, 7, outcome_id))
    printdbg(paste("Number of hospitals with lowest rate =", nrow(best)), debug)
    printdbg("Unsorted best hospitals:", debug)
    printdbg(head(best), debug)

    best_sorted <- best[order(best[,1]), ]
    printdbg("Sorted best hospitals:", debug)
    printdbg(head(best_sorted), debug)
    best_sorted[1,1]
    
}