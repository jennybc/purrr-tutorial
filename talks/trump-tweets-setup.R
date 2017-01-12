library(tidyverse)
library(here)

if (!file.exists(here("trump_tweets_df.rda"))) {
  download.file("http://varianceexplained.org/files/trump_tweets_df.rda",
                "trump_tweets_df.rda")
}

load(here("trump_tweets_df.rda"))
regex <- "badly|crazy|weak|spent|strong|dumb|joke|guns|funny|dead"
tdf <- tibble(
  tweet = trump_tweets_df$text,
  source = trump_tweets_df$statusSource,
  created = trump_tweets_df$created,
  matches = gregexpr(regex, tweet),
  n_matches = map_int(matches, ~ sum(.x > 0))
)
tdf %>%
  count(n_matches)
## # A tibble: 4 x 2
##   n_matches     n
##       <int> <int>
## 1         0  1429
## 2         1    72
## 3         2    10
## 4         3     1
tdf %>%
  mutate(row_num = seq_len(nrow(.))) %>%
  group_by(n_matches) %>%
  top_n(2, created) %>%
  .$row_num
## [1]   1   2   5   6 198 347 919

keepers <- tdf[c(1, 2, 5, 6, 198, 347, 919), ]
if (interactive()) View(keepers)
keepers %>%
  select(tweet, source, created) %>%
  write_csv(here("talks", "trump-tweets.csv"))
