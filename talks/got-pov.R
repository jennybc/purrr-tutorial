library(repurrrsive)
library(tidyverse)
library(httr)
library(stringr)
library(here)

pov <- set_names(map_int(got_chars, "id"),
                 map_chr(got_chars, "name"))

tail(pov, 5)

ice <- pov %>%
  enframe(value = "id")
ice

ice_and_fire_url <- "https://anapioficeandfire.com/"
if (file.exists(here("talks", "ice.rds"))) {
  ice <- readRDS(here("talks", "ice.rds"))
} else {
  ice <- ice %>%
    mutate(
      response = map(id,
                     ~ GET(ice_and_fire_url,
                           path = c("api", "characters", .x))),
      stuff = map(response, ~ content(.x, as = "parsed",
                                      simplifyVector = TRUE))
    ) %>%
    select(-id, -response)
  saveRDS(ice, here("talks", "ice.rds"))
}
ice

str(ice$stuff[[9]], max.level = 1)    ## list.len also good stuff!
if (interactive()) {
  listviewer::jsonedit(ice$stuff[[2]], mode = "view", width = 500, height = 530)
}

## at this point, I switched to a version of ice taken from the list in my
## repurrrsive package, where I have resolved, e.g., houses
## i.e. they are actual houses instead of API URLs

ice2 <- tibble(
  name = map_chr(got_chars, "name"),
  stuff = got_chars
)
ice2
str(ice2$stuff[[9]], max.level = 1)    ## list.len also good stuff!
if (interactive()) {
  listviewer::jsonedit(ice2$stuff[[2]], mode = "view", width = 500, height = 530)
}

template <- "${name} was born ${born}."
birth_announcements <- ice2 %>%
  mutate(birth = map_chr(stuff, str_interp, string = template)) %>%
  select(-stuff)
if (interactive()) View(birth_announcements)
birth_announcements

allegiances <- ice2 %>%
  transmute(name,
            houses = map(stuff, "allegiances")) %>%
  filter(lengths(houses) > 1) %>%
  unnest()
if (interactive()) View(allegiances)
allegiances
