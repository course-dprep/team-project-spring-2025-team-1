## Plotting our variables (numeric)
# Now that we have a Dataset where all the NA values are removed, lets plot the different variables. 
#For our numeric variables we are going to be using Barplots and Boxplots. For variables that only have a value of  0 or 1 (binary or boolean), 
#it does not make sense to create a Boxplot since the distribution is not continuous or ordinal. For variables that are not binary boxplots make 
#more sense as we can glean quartiles, medians and extreme values quite easily.

# As we already have information on whether a variable is binary from our previous analysis, 
#we can use this information again to create our plots without manually coding the boxplot 
#or the barplot depending on what type of variable we are dealing with

## these are all our numeric variables
remaining_columns_sans_genre = c("isAdult", "startYear", "endYear", "averageRating", "numVotes")
fig_number = 13


for (col in remaining_columns_sans_genre) {
  ## IF the factor was previously identified as numeric
  
  data_type = data_types_summary[which(data_types_summary$variable == col),"type"]
  
  if (data_type == "numeric") {
    
    binary = data_types_numeric[which(data_types_numeric$variable == col),"binary"]
    
    if (binary == 0) {
      
      boxplot(TV_series_data_clean[[col]], main = paste("Fig", fig_number, ": Boxplot of", col), ylab = col)
      
    } else {
      
      barplot(table(TV_series_data_clean[[col]]), main = paste("Fig", fig_number, ": Barplot of", col), xlab = col, ylab = "Count", col = c("red", "green"))
      
    }
  }
  
  fig_number = fig_number +1
  
}


### interpretation of plots:
#(1) barplot isAdult: Is is clearly evident that the number of TV-series that have an adult rating 
# is significantly smaller than those who do not have an adult rating
#(2) Startyear: there are significant more TV-series that have started airing in the early to 
#late 2000s than the late 1900 (Negatively skewed). This makes sense as IMDB has only been around since 
#1990, and showrunners from that time might be less concerned about adding their tv Show. 
#Moreover, given IMDBs recent popularity, this might also be considered a birgger priority for current shows. 
#(3) Endyear: we observe the same thing for Endyear as we did for Startyear, this makes sense for the same reasoning
#(4) Averagerating: averageRating looks normal but is slightly negatively skewed, indicating that people are
#in general a positive (as otherwise 5 would be the average)
#(5) Numvotes:NumVotes is quite positively skewed, indicating that most shows receive a (relative)
#low number of votes and a few shows get a very large number of votes. In other words, popularity is not discributed normally. 


## GENRE encoding 
#now lets look at genre. As a TV show can have several Genre tags we cannot simply plot a single 
#variable but use pivot longer to count the percentage of occurences of a genre in total. 
#Thus in the table below percentage indicates the percentage of times a genre is tagged in general
# (not the percentage of times a genre is tagged for a TV show).

genre_counts <- TV_series_data_clean %>%
  select(Genre1, Genre2, Genre3) %>%  
  pivot_longer(cols = everything(), names_to = "Genre_Type", values_to = "Genre") %>%  
  drop_na() %>% 
  count(Genre, sort = TRUE)  

# Display the result

genre_counts = genre_counts %>%
  mutate(percentage = (n/sum(n)*100))

kable(genre_counts, caption = "Frequency of Genres occurences in our dataset")

# As is evident from the table and the graph below, the most common genre is comedy, and drama, whereas western, war and musical are less popular

ggplot(genre_counts, aes(x = reorder(Genre, -n), y = n, fill = Genre)) +
  geom_bar(stat = "identity") +
  labs(title = "Fig 18: TV Genre Distribution", x = "Genres", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  guides(fill = "none") 


# Count occurrences of each genre
genre_counts <- TV_series_data_clean %>%
  select(Genre1, Genre2, Genre3) %>%
  pivot_longer(everything(), names_to = "Genre_Type", values_to = "Genre") %>%
  drop_na() %>%
  count(Genre, sort = TRUE) %>%
  mutate(percentage = (n / sum(n)) * 100)

# Display the result
kable(genre_counts, 
      col.names = c("Genre", "number of times observed", "percentage"),
      caption = "Fig19: Frequency of Genre Occurrences in Dataset")
