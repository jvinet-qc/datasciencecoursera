corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the csv files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    
    source("complete.R")
    nobs_by_mon <- complete(directory)

    # valide_cases <- nobs$nobs > threshold
    # for (case in nobs[valide_cases,]) {
    #     file_id <- case$id
    #     filename <- paste(directory, "\\", formatC(file_id, width=3, flag="0"), ".csv", sep = "")
    #     #print(filename)
    #     single_df <- read.csv(filename)
    #     #cor_res = cor(cases)
    #     
    # }
    
    all_cor <- vector(mode = "numeric")
    
    for (i in 1:nrow(nobs_by_mon)) {
        #correlation = 0
        
        monitor <- nobs_by_mon[i,]
        if (monitor$nobs > threshold) {
            file_id <- monitor$id
            filename <- paste(directory, "\\", formatC(file_id, width=3, flag="0"), ".csv", sep = "")
            #print(filename)
            single_df <- read.csv(filename)
            
            correlation = cor(single_df$sulfate, single_df$nitrate, use = "complete")
            
            all_cor <- c(all_cor, correlation)
        }
        
        #all_cor <- c(all_cor, correlation)

    }
    
    all_cor
}

## Example output:
# source("corr.R")
# source("complete.R")
# cr <- corr("specdata", 150)
# head(cr)
# ## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
# cr <- corr("specdata", 400)
# head(cr)
# ## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630
# cr <- corr("specdata", 5000)
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## 
# length(cr)
# ## [1] 0
# cr <- corr("specdata")
# summary(cr)
# ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# ## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
# length(cr)
# ## [1] 323
