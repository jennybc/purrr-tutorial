#' ---
#' output: rtf_document
#' ---

library(tidyverse)
library(repurrrsive)
library(gapminder)
library(stringr)
library(listviewer)

titles <- got_chars %>% {
  tibble(name = map_chr(., "name"),
         titles = map(., "titles"))
}
titles
View(titles)
titles %>%
  filter(name %in% c("Daenerys Targaryen",
                     "Asha Greyjoy", "Cersei Lannister")) %>%
  View()
#  {set_names(.$titles, .$name)}

map(got_chars, "name")
map_chr(got_chars, "name")
map_df(got_chars, `[`, c("name", "culture", "gender", "born"))

got_chars %>% {
  tibble(name = map_chr(., "name"),
         houses = map(., "allegiances"))
} %>%
  filter(lengths(houses) > 1) %>%
  unnest()


gap_nested <- gapminder %>%
  group_by(country, continent) %>%
  nest()
gap_nested
gap_nested %>%
  mutate(fit = map(data, ~ lm(lifeExp ~ year, data = .x))) %>%
  filter(continent == "Oceania") %>%
  mutate(coefs = map(fit, coef))
gap_nested %>%
  mutate(fit = map(data, ~ lm(lifeExp ~ year, data = .x))) %>%
  filter(continent == "Oceania") %>%
  mutate(coefs = map(fit, coef)) %>%
  mutate(intercept = map_dbl(coefs, 1),
         slope = map_dbl(coefs, 2)) %>%
  select(country, continent, intercept, slope)

library(gapminder)
library(tidyr)
library(dplyr)
gap_nested %>%
  group_by(country) %>%
  summarize(lifeExp = map_dbl(data, ~ mean(.x$lifeExp)))
gapminder %>%
  group_by(country) %>%
  summarize(lifeExp = mean(lifeExp))
