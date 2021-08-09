library(nbastatR)
library(tidyverse)
library(gt)

NBAData <- bref_players_stats(tables = c("per_game", "totals"), seasons = 2021)

NBAData <- NBAData %>% 
  filter(countGames > 50 & ptsPerGame > 20 & pctEFG > 0.5) %>%
  select(namePlayer, countGames, ptsPerGame, pctEFG)

brPal <- colorRampPalette(c("blue", "red"))

color <- brPal(10)[as.numeric(cut(NBAData$pctEFG, breaks = 10))]

plot(NBAData$ptsPerGame, NBAData$pctEFG,
     main = "EFG% vs PPG",
     xlab = "PPG",
     ylab = "EFG%",
     ylim = range(0.5, 0.62),
     xlim = range(20:35),
     cex = 1.5,
     pch = 20,
     col = color)

text(NBAData$ptsPerGame, NBAData$pctEFG, labels = NBAData$namePlayer, 
     cex = 0.6, pos = 4)
