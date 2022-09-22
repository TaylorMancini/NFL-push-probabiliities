install.packages("tidyverse")
install.packages("nflfastR")
install.packages("ggimage")
install.packages("gt")

# Load packages
library(tidyverse)
library(nflfastR)
library(ggimage)
library(gt)

# Load the end game data for 2020 and 2021
schedule <- fast_scraper_schedules(2017:2021)

#calculate push probabilities for full game nfl spreads
spread_favW <- schedule %>% select(result,spread_line) %>% filter(sign(spread_line)==sign(result))
spread_favW$spread_line <- NULL
spread_dogW <- schedule %>% select(result,spread_line) %>% filter(sign(spread_line)!=sign(result))
spread_dogW$spread_line <- NULL
spread_push_prob_favW <- as.data.frame(table(abs(spread_favW)))
spread_push_prob_dogW <- as.data.frame(table(abs(spread_dogW)))
spread_push_prob_favW$Freq <- as.numeric(spread_push_prob_favW$Freq)/as.numeric(nrow(schedule))
spread_push_prob_dogW$Freq <- as.numeric(spread_push_prob_dogW$Freq)/as.numeric(nrow(schedule))
sum(spread_push_prob_favW$Freq)+sum(spread_push_prob_dogW$Freq)

#calculate push probabilities for full game nfl totals
total <- schedule %>% select(total)
total_push_prob <- as.data.frame(table(abs(total)))
total_push_prob$Freq <- as.numeric(total_push_prob$Freq)/as.numeric(sum(total_push_prob$Freq))
sum(total_push_prob$Freq)

