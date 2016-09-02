pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the csv files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate"
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## NOTE: Do not round the results
    
    full_df <- NULL
    
    for (file_id in id) {
        filename <- paste(directory, "\\", formatC(file_id, width=3, flag="0"), ".csv", sep = "")
        #print(filename)
        single_df <- read.csv(filename)
        #subset <- single_df[complete.cases(single_df),]
        full_df <- rbind(full_df, single_df)
    }
    
    mean(full_df[[pollutant]], na.rm = TRUE)
}


## Example output:
# source("pollutantmean.R")
# pollutantmean("specdata", "sulfate", 1:10)
# ## [1] 4.064
# pollutantmean("specdata", "nitrate", 70:72)
# ## [1] 1.706
# pollutantmean("specdata", "nitrate", 23)
# ## [1] 1.281