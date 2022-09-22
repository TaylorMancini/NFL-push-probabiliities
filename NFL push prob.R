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
short_schedule <- schedule %>% filter(abs(spread_line)<=4.5)
long_schedule <- schedule %>% filter(abs(spread_line)>4.5)

#calculate push probabilities for full game nfl spreads
spread_shortfavW <- short_schedule %>% select(result,spread_line) %>% filter(sign(spread_line)==sign(result))
spread_shortfavW$spread_line <- NULL
spread_shortdogW <- short_schedule %>% select(result,spread_line) %>% filter(sign(spread_line)!=sign(result))
spread_shortdogW$spread_line <- NULL
spread_longfavW <- long_schedule %>% select(result,spread_line) %>% filter(sign(spread_line)==sign(result))
spread_longfavW$spread_line <- NULL
spread_longdogW <- long_schedule %>% select(result,spread_line) %>% filter(sign(spread_line)!=sign(result))
spread_longdogW$spread_line <- NULL
spread_push_prob_shortfavW <- as.data.frame(table(abs(spread_shortfavW)))
spread_push_prob_shortdogW <- as.data.frame(table(abs(spread_shortdogW)))
spread_push_prob_shortfavW$Freq <- as.numeric(spread_push_prob_shortfavW$Freq)/as.numeric(nrow(short_schedule))
spread_push_prob_shortdogW$Freq <- as.numeric(spread_push_prob_shortdogW$Freq)/as.numeric(nrow(short_schedule))
spread_push_prob_longfavW <- as.data.frame(table(abs(spread_longfavW)))
spread_push_prob_longdogW <- as.data.frame(table(abs(spread_longdogW)))
spread_push_prob_longfavW$Freq <- as.numeric(spread_push_prob_longfavW$Freq)/as.numeric(nrow(long_schedule))
spread_push_prob_longdogW$Freq <- as.numeric(spread_push_prob_longdogW$Freq)/as.numeric(nrow(long_schedule))
sum(spread_push_prob_shortfavW$Freq)+sum(spread_push_prob_shortdogW$Freq)+sum(spread_push_prob_longfavW$Freq)+sum(spread_push_prob_longdogW$Freq)

#calculate push probabilities for full game nfl totals
total <- schedule %>% select(total)
total_push_prob <- as.data.frame(table(abs(total)))
total_push_prob$Freq <- as.numeric(total_push_prob$Freq)/as.numeric(sum(total_push_prob$Freq))
sum(total_push_prob$Freq)

