# Data cleaning and EDA


## Variables that are available
# In our dataset we have several variables available to us. In order to conduct 
# a proper analysis we must start with defining what all of the variables mean and how they are calculated. We will derive the definition of these variables from the IMDB website from which we downloaded these sources:
  
#   
# Existing variables in the dataset
#  
# **(1) tconst** - alphanumeric unique identifier of the title
# **(2) parentTconst (string)** - alphanumeric identifier of the parent TV Series
# **(3) seasonNumber (integer)** – season number the episode belongs to. In the 
#   case of our dataset the number of seasons is stored here (so 8 translates to 8 seasons).
# **(4) episodeNumber (integer)** – episode number of the tconst in the TV series. 
#   In the case of our dataset episode number refers to the most recent episode released (so a if the most recent season is episode so if this was season 5 episode 3 for a given show, this would be denoted as 3)
# **(5) titleType (string)** – the type/format of the title (e.g. movie, short, 
#   tvseries, tvepisode, video, etc)
# **(6) titleprimaryTitle (string)** – the more popular title / the title used 
#   by the filmmakers on promotional materials at the point of release
# **(7) originalTitle (string)** - original title, in the original language
# **(8) isAdult (boolean)** - 0: non-adult title; 1: adult title
# **(9) startYear (YYYY)** – represents the release year of a title. In the case
#   of TV Series, it is the series start year
# **(10) endYear (YYYY)** – TV Series end year. '\N' for all other title types
# **(11) runtimeMinutes** – primary runtime of the title, in minutes
# **(12) ordering (integer)** – a number to uniquely identify rows for a given 
#   titleId
# **(13) title (string)** – the localized title
#  
# **(14) region (string)** - the region for this version of the title
# **(15) language (string)** - the language of the title
#   types (array) - Enumerated set of attributes for this alternative title. One or 
#   more of the following: "alternative", "dvd", "festival", "tv", "video", "working", 
#   "original", "imdbDisplay". New values may be added in the future without warning
# **(16) types (array)** - Enumerated set of attributes for this alternative title. 
#   One or more of the following: "alternative", "dvd", "festival", "tv", "video", 
#   "working", "original", "imdbDisplay". New values may be added in the future without 
#   warning
# **(17) attributes (array**) - Additional terms to describe this alternative 
#   title, not enumerated
# **(18)isOriginalTitle (boolean)** – 0: not original title; 1: original title
# **(19) averageRating** – weighted average of all the individual user ratings
# **(20) numVotes** - number of votes the title has received

# Our own generated variables
# Lastly, in the data preparation process, we created our own varibales that we 
#   used for subsequent analysis. Below the variable name and what it entails is documented. 
 
# **(21) renewed** - this variable encodes whether a given TV series has been 
#   renewed for a second season. This was deduced based on whether a season two 
#   was on file. When a TV show had more than one season, this was encoded as 1, 
#   when a TV show only had one season in the dataset, this was encoded as a 0. 
#
# **Genre1, Genre2 and Genre3** - a problem with the raw data set was that the 
#   first, second and third genres were all collected in one big variable. This 
#  makes analysis of these genres quite challenging as this creates a very large
#  number of unique combinations. Thus, for ease of analysis, it was decided to 
#  break up the string of genres into three different columns: genre 1, genre 2, 
#  genre 3. Genre 1 thus denotes the first genre tagged in the database, genre 2 
#  the second and genre 3 the third.Though it seems logical to assume that the 
#  first genre tagged is the primary (or main) genre, we cannot operate under 
#  this assumption as this is not noted anywhere. 

# **Genre1_encoded, Genre2_encoded and Genre3_encoded**
#   These variables were used to create Genre1, Genre 2 and Genre3 but by 
#   themselves do not mean much.

# Removing useless variables and taking a quick glimpse
# A lot of variables in the dataset TV_series_data_genre is not information we 
#   need to keep for later analysis. Thus we start by removing the following 
#   variables, since they are not necessary for our analysis or are repetative:
#   
# **(1) SeasonNumber**: we are looking at whether a TV show is renewed in the first 
#   season or not, whether a TV show runs for 2 or 5 seasons is outside the scope of out study
# **(2) Titletype**: all our title types are TV-series since this is what we want 
#   to be looking at exclusively
# **(3) EpisodeNumber**: this variable does not tell as much, only the most recent 
#   episode number
# **(4) RuntimeMinutes**: a tv show renewed for a second season will have a longer 
#   runtime, moreover a TV show that has been renewed several seasons will have a 
#   longer runtime. This is more a product of renewal, not something that influences renewal itself.
# **(5) genre1_encoded, genre2_encoded, genre3_encoded.** : This is a numeric value 
#   used in the data preperation process but is not much use to us in the actual analysis
# **(6) ordering**: used to identify rowsin one dataset but is not something that 
#   carries over in other datasets
# **(7) tconst**: repetative information (was used in merging)

# Okay so lets just review all the data we have by breaking down and looking at 
#   the summary and glimpse per review. We have already removes some columns that
#   are no longer relevant. At this point in time we are keeping variables such as 
#   whether the tv show is targeted towards adults or not since we might want to 
#   use them later for a predictive analysis (possiby).


summary(TV_series_data_genre)
TV_series_data_clean = TV_series_data_genre %>%
  select(c(-seasonNumber, -titleType, -attributes, -runtimeMinutes, 
           -episodeNumber, -Genre1_encoded, -Genre2_encoded, -Genre3_encoded, 
           -ordering, -tconst))

glimpse(TV_series_data_clean)
summary(TV_series_data_clean)



# ## A clear overview: 
# Though the glimpse function is useful, lets create a custom overview, so that we
#   can analyse the data in more detail. We will create 3 table overviews:
#   
# **1) data_types_summary**: This table will include three different columns that 
#   summarises the following about TV_series_data_clean
# 1.1 Variable: Name of the variable
# 1.2 type: type of variable that is stored (numeric, string etc.)
# 1.3 Percentage_na: the percentage of NAs for this variable in our dataset
# 
# **2) data_types_numeric**
# 2.1 Variable: Name of the variable
# 2.2 minimum: the lowest value for a given variable
# 2.3 maximum: the highest value for a given variable
# 2.4 average_mean: the mean average  for a given variable
# 2.5 average_median: the median average  for a given variable
# 2.6 average_mode: the mode average  for a given variable
# 2.7 binary: checks if the only unique values are 1 or 0. if this is true it is 
#   likely this variable is one for which a condition is either true or false


# **3) data_types_char**
# 3.1 Variable: Name of the variable 
# 3.2 unique_values: checks the number of unique character values, might be useful
#   with plotting (for example if a given variable has over 1000 unique variables 
#   versus 8, this might influence how we choose to plot or visually represent them)



## create 3 empty dataframes. the first one stores whether a vector is a character or numeric. then based on this 
data_types_summary = data.frame(variable = character(), type = character(), 
                                percentage_na = character(), stringsAsFactors = FALSE)
data_types_numeric = data.frame(variable = character(), minimum = numeric(), 
                                maximum = numeric(), average_mean = numeric(), 
                                average_median = numeric(), average_mode = numeric(), 
                                binary = numeric(), stringsAsFactors = FALSE)
data_types_char = data.frame(variable = character(), unique_values = character(), 
                             stringsAsFactors = FALSE)

## We could not find a mode average function in r so we got this one from online 
## https://www.tutorialspoint.com/r/r_mean_median_mode.htm 

getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}

## Create a function whether a variable is binary (either true or false)

binary_check = function(v) {
  if (all(v %in% c(0, 1))) {
  return(1)
  } else { 
  return(0)
    }
  
}


for (col in columns) {
  
  column_type = class(TV_series_data_clean[[col]])
  amount_na = (mean(is.na(TV_series_data_clean[[col]]))) * 100
  
  ## df1: The type of data from our main dataframe
  data_types_summary <- rbind(data_types_summary, data.frame(variable = col, type = column_type, percentage_na = amount_na, stringsAsFactors = FALSE))
  
  if (column_type == "numeric") {
    
    ## DF2: if a value is numeric the min and max value will be collected for this variable 
    min_value = min(TV_series_data_clean[[col]], na.rm = T)
    max_value = max(TV_series_data_clean[[col]], na.rm = T)
    mean_value =  mean(TV_series_data_clean[[col]], na.rm = T)
    median_value = median(TV_series_data_clean[[col]], na.rm = T)
    mode_value = getmode(TV_series_data_clean[[col]])
    binary_value = binary_check(TV_series_data_clean[[col]])

    
    data_types_numeric <- rbind(data_types_numeric, data.frame(variable = col, minumum = min_value, maximum = max_value, average_mean = mean_value, average_median = median_value, average_mode = mode_value, binary = binary_value, stringsAsFactors = FALSE))
    
  } else {
    
    ## DF3: if a value is not numeric it has to be character so the number of NAs are collected 
    number_unique_var = length(unique(TV_series_data_clean[[col]]))

    data_types_char <- rbind(data_types_char, data.frame(variable = col, unique_values = number_unique_var, stringsAsFactors = FALSE))
    
  }
  
  
}

### create a figure with variable type, datatype and percentage na
kable(data_types_summary, 
      col.names = c("Variable name", "type", "percentage na"), 
      caption = "Fig2: Overview of all variables in merged dataframe")

### create a figure with an overview of all numeric figures
kable(data_types_numeric, 
      col.names = c("variable name", "lowest value", "highest value", "average (mean)", "average (median)", "average (mode)", "is binary?"),
      caption = "Fig3: Data Types Summary: Numeric Only")

### create a figure for character variable with numer of unique values
kable(data_types_char, 
      col.names = c("variable name", "number unique values"),
      caption = "Fig4: Data Types Summary: only Characters")

## variable inspection and subsequent course correction

# Most of the ranges in the numeric table seems to be normal, however the variable 
# startyear has values p to 2026. This makes sense as a production might have already 
# added a TV series to IMDB in order to add trailers, even though the show has not 
# started airing. However, this creates an unfair bias where more recent shows will 
# be less likely to have been renewed, through virtue of not having finished airing 
# or having had the opportunity to renew a show. In an analysis by parrot analytics 
# they used a range of 80 days to determine whether a show would be renewed or not 
# (Parrot Analytics, 2023). Since this data has been updated as of March 2024, its 
# more fair to only include data up to 2023 (to avoid recency bias)

# Moreover, isOriginalTitle is a variable for which all the values are 1, in other 
# words all titles in the database are original. Thus for analysis purposes, 
# it does not make sense to include this varibale in future analysis. The same goes 
# for Types, for which the variable is either original or NA, which does not much either. 

# Notwithstanding the Startyear and the NA's, the data seems to be in regular 
# ranges, The variable types are also correct.



TV_series_data_clean = TV_series_data_clean %>%
  filter(startYear < 2024)


TV_series_data_clean = TV_series_data_clean %>%
  select(-isOriginalTitle, -types)



## Looking at all the available NA variables

# Okay so as mentioned earlier there are some NA's in the Dataset, 
# for ones which the amount of na's is 100 percent will naturally have to be 
# removed (as this means there is no data on them). as for the variables that do
# have an NAs it could be interesting to explore whether the NA data has different 
# properties than the data which does not have NAs (for example if a lot of NA data
# on number of votes also has no renewals, this could influence how we interpret our final results)

# First let show a bar plot of all the percentage of missing values.


ggplot(data_types_summary, aes(x = reorder(variable, -percentage_na), y = percentage_na)) +
  geom_bar(stat = "identity") + 
  labs(title = "Fig5: Percentage of missing values per column",
       x = "Type variable",
       y = "Percentage of na values") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 



# As was already evident in data_types_summary, and is visualized in the plot above,
# some variables have values for which all the information is missing, and thus can be removed. 


## collecting variables for which there is no data (100 percent NA)
all_missing_data <- data_types_summary$variable[which(data_types_summary$percentage_na == 100)]

# Print the result
glue("missing all the data for: {all_missing_data}")


TV_series_data_clean <- TV_series_data_clean %>%
  select(-all_of(all_missing_data))



## Looking at our NA distribution before removing it
# HOw our NA's are distributed among the independent variable is of relevance to 
# our analysis. After all, if we find Na's to be much more present in either 
# conditions, the analysis performed might be limited by data storage or collection 
# practices done by IMDB.

# Though we can manually code each individual plot and their NA ratios per variable, 
# looping through our variables can make our code less repetitive and makes the 
# result less prone to human errors such as typo's.  


## All NA plots



### values which in the summary had more than one percent NA's
target_columns = data_types_summary$variable[which(data_types_summary$percentage_na > 1)]
## TAKE out already removed columns

columns = colnames(TV_series_data_clean)

target_columns <- target_columns[target_columns %in% columns]

## As we have already filtered startyear (and discarded NA variables in this category) we will not be analysing it for this part

target_columns <- setdiff(target_columns, c("startYear", "title", "Genre1_encoded_encoded", "Genre2_encoded_encoded", "Genre3_encoded_encoded"))


start_number = 6

for (col in target_columns) {
  print(
    ggplot(TV_series_data_clean, aes(x = as.factor(Renewed), fill = as.factor(is.na(.data[[col]])))) +
      geom_bar(position = "dodge") +  
      labs(title = paste("Fig", start_number, ": Comparison of Missing values in", col, "based on Renewal Status"),
           x = "Renewal Status",
           y = "Count",
           fill = "Category") +
      scale_fill_manual(values = c("TRUE" = "red", "FALSE" = "blue"), 
                        labels = c(paste(col, "Data Available"), paste(col, "Data Missing"))) +
      theme_minimal()
  )
  
  start_number = start_number + 1
}



# A table Summary With all the NAs
# Though the plots are useful, it is also useful to have the exact percentages of 
# the NAs for both renewed conditions to just see how much data is missing relatively 
# (and not in terms of count). This has been added below using the table as follows:
# (1) Variable: Name of variable
# (2) na_perc_total: total percentage of NA's for a variable
# (3) na_perc_ren: percentage of NA's for which a variable is renewed (1)
# (4) na_per_ren:percentage of NA's for which a variable is not renewed (0)




na_summary_df <- data.frame(
  Variable = character(),
  na_perc_total = numeric(),
  na_perc_ren = numeric(),
  na_perc_not_ren = numeric(),
  stringsAsFactors = FALSE
)

for (col in target_columns) {
  
  Na_count <- sum(is.na(TV_series_data_clean[[col]]))
  na_count_renewed <- sum(is.na(TV_series_data_clean[[col]]) & TV_series_data_clean$Renewed == 1)
  na_count_not_renewed <- sum(is.na(TV_series_data_clean[[col]]) & TV_series_data_clean$Renewed == 0)
  
  Na_percentage <- (Na_count / nrow(TV_series_data_clean)) * 100
  Na_percentage_renew <- (na_count_renewed / sum(TV_series_data_clean$Renewed == 1)) * 100
  Na_percentage_not_renew <- (na_count_not_renewed / sum(TV_series_data_clean$Renewed == 0)) * 100
  
  na_summary_df <- rbind(na_summary_df, data.frame(
    Variable = col,
    na_perc_total = Na_percentage,
    na_perc_ren = Na_percentage_renew,
    na_perc_not_ren = Na_percentage_not_renew
  ))
}

# Print final dataframe
kable(na_summary_df, 
      col.names = c("variabe name", "na % total", "na % in renewals", "na % in non renewals"),
      caption = "Fig 12: Summary of percentage of missing variables in Total and Renewal Conditions")



## Interpretation of the NA values

# (1) Endyear: more of the Endyear data is missing for shows that have not been 
# renewed. This could be because no Endyear has yet been determined (and thus not 
# listed). This might be interesting to consider in the final analysis with our results.

# (2) Genre 1: we can see that the percentage of shows which have no genre tag is 
# greater in those who have not been renewed, notwithstanding the difference is not 
# that large (3.96% missing in renewed shows, 7.32% in those which have not been renewed). 

# (3) Genre2 & Genre3: though a missing Genre2 and Genre3 is not a indicative of 
# anything (it could mean a show only has 1 tag) it is interesting to analyse. For 
# example both for Genre2 and Genre3 have more missing values for shows which were 
# not renewed (in other words renewed shows might have more tags). This could be 
# interesting to look at in further analysis

# (4) AverageRating: There is a lot more data missing for AverageRating in shows 
# that have not been renewed, than for those who have. according to IMDB's 
# own policy, it does not show ratings for shows which have less than 5 ratings. 
# Perhaps the higher number average ratings are missing for shows that are not 
# renewed is thus a byproduct of them not being popular. Ergo, are future analysis 
# should note that shows that have less than 5 ratings were removed in the analysis process. 

# (5) NumVotes: Again, this ties in with the average ratings. Perhaps a number of 
# votes is also not noted when this number is too low.Again, by filter out the 
# datapoints for which NA values are missing, we are also filtering out shows 
# which are very unpopular on IMDB.  



## Removing the NA 
# as our research is primarily concerned with renewals,average rating, popularity 
# (lanauge is no longer in the dataset so that cant be studied), lets remove the 
# data for which we have NA's for average rating and popularity (num votes)


TV_series_data_clean = TV_series_data_clean %>%
  filter(!is.na(averageRating) & !is.na(numVotes))

head(TV_series_data_clean)

rm(TV_series_data_genre)