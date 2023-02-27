library(dplyr)
library(readr)
library(stringr)
library(ggplot2)
library(tidyverse)
library(rcompanion)

# Read in CSV file of chess games
games <- read_csv("~/R/Projects/Chess/games.csv")

# Split the moves column into a list of individual moves
moves_list <- strsplit(as.character(games$moves), " ")
moves_list

# Determine which player moves their queen first in each game
queen_first_moves <- sapply(moves_list, function(moves) {
  # Find the indices of all queen moves
  queens <- grep("^Q", moves)
  if (length(queens) > 0) {
    # If a queen move is found, determine which player moved it
    if (queens[1] %% 2 == 1) {
      return("white")
    } else {
      return("black")
    }
  } else {
    # If no queen moves are found, return NA
    return(NA)
  }
})

# Add the queen_first_moves column to the data frame
games$queen_first_moves <- queen_first_moves

# Filter the data to include only games with small rating differences and low ratings
games_filtered <- games %>% 
  filter(abs(white_rating - black_rating) <= 100, # rating difference filter
         black_rating < 2000, # black rating filter
         white_rating < 2000) %>% # white rating filter
  group_by(queen_first_moves, winner) %>% # group by queen_first_moves and winner
  summarize(count = n()) %>% # count the number of games in each group
  mutate(percentage = count / sum(count) * 100) %>% # calculate the percentage of games in each group
  drop_na(queen_first_moves) # remove any rows with missing values in queen_first_moves column

# Create data frames with the count and percentage of wins, losses, and draws for each player based on queen moves
white_moves <- filter(games_filtered, queen_first_moves == "white")
black_moves <- filter(games_filtered, queen_first_moves == "black")


# Create a contingency table of wins, losses, and draws for each player based on queen moves
cont_table <- matrix(c(white_moves$count[white_moves$winner == "white"],
                       white_moves$count[white_moves$winner == "black"],
                       sum(games_filtered$count[games_filtered$queen_first_moves == "white" & games_filtered$winner == "draw"]),
                       black_moves$count[black_moves$winner == "white"],
                       black_moves$count[black_moves$winner == "black"],
                       sum(games_filtered$count[games_filtered$queen_first_moves == "black" & games_filtered$winner == "draw"])),
                     nrow = 2, byrow = TRUE)

# Set column names for the contingency table
colnames(cont_table) <- c("white wins", "black wins", "draws")

# Set row names for the contingency table
rownames(cont_table) <- c("white queen first", "black queen first")

# Perform a chi-squared test of independence on the contingency table
chisq_test <- chisq.test(cont_table)

# Cramer V test to check effect size 
cramer_test <- cramerV(cont_table)

# Create a bar chart of the count by winner and queen_first_moves
ggplot(games_filtered, aes(x = winner, y = count, fill = queen_first_moves)) +
  geom_col(position = "dodge") +
  labs(title = "Games Filtered", x = "Winner", y = "Count") +
  scale_fill_manual(values = c("white" = "gray80", "black" = "gray20")) +
  theme_minimal()



# Create a bar plot of games_filtered to show percentages
ggplot(games_filtered, aes(x = queen_first_moves, y = count, fill = winner)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste(round(percentage, 1), "%")), position = position_dodge(width = 1), vjust = -0.5) +
  scale_fill_manual(values = c("white" = "#F8766D", "black" = "#00BFC4", "draw" = "#A3A3A3")) +
  labs(x = "Queen First Move", y = "Count", fill = "Winner") +
  theme_minimal()



