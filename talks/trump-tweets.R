library(tidyverse)
library(stringr)
library(lubridate)
library(here)

tb_raw <- read_csv(here("talks", "trump-tweets.csv"))
tb_raw
if (interactive()) View(tb_raw)

source_regex <- "android|iphone"
tword_regex <- "badly|crazy|weak|spent|strong|dumb|joke|guns|funny|dead"

tb <- tb_raw %>%
  mutate(source = str_extract(source, source_regex),
         twords = str_extract_all(tweet, tword_regex))

tb$tweet

tb %>% select(-tweet)
if (interactive()) View(tb)

if (interactive()) str_view_all(tb$tweet, tword_regex)

tb <- tb %>%
  mutate(n = lengths(twords),
         hour = hour(created),
         start = gregexpr(tword_regex, tweet))
# another possibilty that would require more processing
# so less useful for a talk example
# but more useful IRL:
# str_locate_all(tweet, tword_regex))

if (interactive()) View(tb)

tb$twords[c(4, 7)]
tb$start[[7]]

tb %>%
  filter(hour < 14,        ## created before 2pm
         between(n, 1, 2), ## containing 1 or 2 Android words
         between(map_int(start, min), 0, 30)) ## Android word in 1st 30 chars

tb %>%
  filter(map_lgl(twords, ~ all(c("strong", "weak") %in% .x)))
