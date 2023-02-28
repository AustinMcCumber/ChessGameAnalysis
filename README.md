# Chess Game Analysis

This repository contains code analyzing a dataset of 20,058 chess games from the website Lichess.org. The objective of this analysis was to determine 
whether or not developing the Queen before the opponent does has a significant impact on win rates. 

### Data

A CSV file was scraped from the Lichess games database by Kaggle user Mitchell J (datasnaek). The data contains 20,058 different chess games and includes
columns such as: winner, white player rating, black player rating, a list of moves for each game, and more. 

### Process

1. Data imported into R.
2. Moves for each game were split into list. Iterated through each game to determine which player's queen moved first, if at all. 
3. Filtered to include only games where specific conditions were met. A variety of parameters were adjusted and tested. For example:
including only games where both players were rated under 2000, including only games where players were within 200 rating points of each other,
and other combinations of these variables. For the final analysis, I chose to use the above examples for final analysis but the results were
similar under all parameters I tested. 
4. Created contingency table. 
5. Tested for significance based on Chi-Squared test. Due to the large sample size, Cramer's V was also tested. 
6. Plotted tables to visualize results. 

### Results

The results are visualized in the bar chart below.  

![PCTWIN](https://user-images.githubusercontent.com/98286027/221739170-fb448b24-1a7a-43b3-ab27-a34d72494e55.png)

In the games analyzed, we can see that when White moves the queen first, they have a Win/Loss/Draw percentage split of 51/44.1/4.8.
This is a significant differential between win and loss when White moves the queen first. It appears that White may have a small advantage.
However, the same does not appear to be true for black, as the W/L split is nearly identical. 

To further investigate the results, a Chi-Squared test of significance was conducted as well. At the alpha = .01 significance level, we find a
Chi-Squared value of 9.3511 and p-value = .00932, indicating that there is sufficent evidence to conclude that an association between which queen moves first
and the outcome of the game exists. 

However, because the sample size is large, it would be beneficial to also calculate Cramer's V statistic. This is based on the calculated Chi-Squared, but scaled
based on sample size. In our case, Cramer's V = .03371. Cramer's V is scaled so that values range from 0 to 1, with higher values indicating a stronger effect.
Interestingly, we find a very week association between the variables now. Based on the bar plot, I believe the lack of diffeence in W/L percentage when black moves 
the queen first is causing the statistical effect to appear lessened. 

### Chess Specific Commentary

This project was inspired by two things: the conventional wisdom and teachings that the queen should be held in reserve in the opening, and a very strange article I read 
about the "Matrix Chess" system created by Bernard Parham, who was known to play the Wayward Queen opening in blitz games.

In my personal experience, I found that as a complete beginner I frequently lost to early queen attacks. As I advanced in chess (slightly!) I became better at defending
against these attacks and taking advantage of the position, but still did make mistakes in shorter time controls. However, I was intrigued after reading about Matrix Chess. See the article [here](https://www.thechessdrum.net/talkingdrum/TheMatrix/index.html).

To be clear, the Matrix Chess system is extremely unconventional and I do not advise attempting to learn it. However, its creator Bernard Parham notes that after observing 
thousands of amateur games, he noticed that the players that attacked with the queen early nearly always won. I hypothesize that this is likely due to the increase in 
tactical opportunities that accompanies an early queen move. We know that at as rating decreases from Grandmaster to amateur, the percentage of games won due to tactical 
shots increases dramatically. According to GM Axel Smith of "The Woodpecker Method", 42% of GM level games are lost due to tactical errors, while for players under rated under 
2000 the percentage had increased to over 70%. 

So, why is the traditional advice different? 

1. Traditional advice generally focuses on classical time controls. When players have more time to think, the risks of developing the queen early may outweigh the benefits. 
2. Traditional advice focuses on the best practices of strong, titled players. Casual chess players should understand that what works for a GM may not be
appropriate for an amateur. This is why I chose the 2000 rating threshold - The vast majority of chess learners are under this and should take note of the results. 

Final conclusion: If you are an amateur chess player, developing the queen early seems like a valid, or even advantageous opening option as white. Consider researching 
the Wayward Queen opening and its known lines. 

### Further Questions

In the future, I will update this post to analyze data for specific time controls. I hypothesize that shorter time controls will result in an even higher win rate for 
white when the queen is developed first. Additionally, I would like to check how the games ended - resignations, time outs, or mates. Openings should also be looked at 
in these cases as well; I believe that the Wayward Queen and Scholar's Mate are likely common patterns here. 

# Technical

### Installation
To run the code, the following packages need to be installed:

dplyr
readr
stringr
ggplot2
tidyverse
rcompanion
You can install these packages using the following command:

```
install.packages(c("dplyr", "readr", "stringr", "ggplot2", "tidyverse", "rcompanion"))
```

### Usage

Download or clone the repository to your local machine.
Open RStudio or your preferred R environment.
Set your working directory to the location of the downloaded repository.
Open the chessanalysis.R file.
Run the code line by line or all at once.
The results of the analysis will be displayed in the console and in a plot.





