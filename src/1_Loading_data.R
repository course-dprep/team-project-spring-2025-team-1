# Step 1: Loading the data 

# We will load the needed data files from the internet. 
# It is all information that is not to do with the people that work on the 
# movies/series, but rather the characteristics of the movies/series themselves

#1.1 install required packages

# Define required packages
required_packages <- c("glue", "readr", "dplyr", "ggplot2", "knitr")

# Install missing packages
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages)) install.packages(new_packages, type = "binary")

# Suppress startup messages while loading packages
suppressPackageStartupMessages({
  library(glue)
  library(readr)
  library(dplyr)
  library(ggplot2)
  library(knitr)
  library(tidyr)})


#1.2 Download all datasets

# Downloading IMDb datasets
options(timeout = 600)
download.file("https://datasets.imdbws.com/title.akas.tsv.gz", "title.akas.tsv.gz")
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", "title.basics.tsv.gz")
download.file("https://datasets.imdbws.com/title.episode.tsv.gz", "title.episode.tsv.gz")
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", "title.ratings.tsv.gz")

# Read and process the data using readr functions and dplyr
akas_data <- read_tsv("title.akas.tsv.gz", col_names = TRUE, na = "\\N")

basics_data <- read_tsv("title.basics.tsv.gz", col_names = TRUE, na = "\\N")

episode_data <- read_tsv("title.episode.tsv.gz", col_names = TRUE, na = "\\N")

ratings_data <- read_tsv("title.ratings.tsv.gz", col_names = TRUE, na = "\\N") 


## 1.3  Code Tests
# In order to ensure that all our dafaframes are downloaded correctly we have a piece of
# code that checks if they all exists. moreover it is nice to get a description of the raw data (such as the number of rows and columns)
#which is why we will create a dataframe raw_data_info that will print these specifications



## THIS first chunk of code checks if the following dataframes exist in our environment

# Define frame names
our_datasets = c("akas_data", "basics_data", "episode_data", "ratings_data")


# Create a dataframe with predefined structure this will show the number of old rows and new rows
# column descriptors: raw_datafram (name of raw dataframe), num_rows (number of rows dataframes) and num_cols (number of columns in dataframe )
raw_data_info <- data.frame(raw_dataframe = our_datasets,
                           num_rows = rep(NA_integer_, length(our_datasets)),
                           num_cols = rep(NA_integer_, length(our_datasets)),  # Correct initialization# Correct initialization
                           stringsAsFactors = FALSE)

# we initialise n_datasets at 0. we do this so that we can later check if all for datasets our correctly downloaded using our for loop below
n_datasets = 0

for (i in seq_along(our_datasets)) {
  df <- our_datasets[i]  # Get dataset name
  
  if (exists(df)) {
    print(paste("Dataframe", df, "successfully created"))
    n_datasets <- n_datasets + 1
    raw_data_info$num_rows[i] <- nrow(get(df))  # Update new row count
    raw_data_info$num_cols[i] <- ncol(get(df))  # Update new column count
    
  } else {
    print(paste("Dataframe", df, "does not exist"))
    raw_data_info$num_rows[i] <- NA  # Mark as NA if dataset does not exist    raw_data_info$num_rows[i] <- nrow(get(df))  # Update new row count
    raw_data_info$num_cols[i] <- nrow(get(df))  # Update new row count
    
  }
}


## The following dataframe provides an overview of our raw data. we can download this and add it to our final report using the following specifications
kable(raw_data_info, 
      col.names = c("Dataset Name", "Old Row Count", "New Row Count"), 
      caption = "Fig 1: Summary of Raw Dataframes")


## lastly, The subsequent code checks if all the dataframes are here. we check this
# using the n_datasets variable

#if all the raw dataframes exist, n_datasets should be 4
if (n_datasets == 4) {
  print("all dataframes are downloaded")
} else {
  print("an error occured, check again if all datasets are downlaoaded correctly")
}

