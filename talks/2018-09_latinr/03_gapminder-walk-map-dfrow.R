library(tidyverse)
library(gapminder)

countries <- c("Argentina", "Brazil", "Canada")
gap_small <- gapminder %>%
  filter(country %in% countries, year > 1996)
gap_small

write_one <- function(x) {
  filename <- paste0(x, ".csv")
  dataset <- filter(gap_small, country == x)
  write_csv(dataset, filename)
}

walk(countries, write_one)
list.files(pattern = "*.csv")

library(tidyverse)

csv_files <- list.files(pattern = "*.csv")
csv_files

map_dfr(csv_files, ~ read_csv(.x))


