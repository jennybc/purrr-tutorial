#+ include = FALSE
library(purrr)
library(repurrrsive)
got_chars_named <- set_names(got_chars, map_chr(got_chars, "name"))

#+ include = FALSE
daenerys <- got_chars[[9]]
## View(daenerys)

daenerys[["aliases"]]

length(daenerys[["aliases"]])

#+ include = FALSE
asha <- got_chars[[13]]
## View(asha)

asha[["aliases"]]

length(asha[["aliases"]])

#+ eval = FALSE, include = FALSE
.x <- got_chars[[i]]

length(.x[["aliases"]])

#+ include = FALSE, include = FALSE
map(got_chars, ~ length(.x[["aliases"]]))

#+ include = FALSE
map_int(got_chars, ~ length(.x[["aliases"]]))

#+ eval = FALSE, include = FALSE
# What's each character's name?
map(got_chars, ~.x[["name"]])
map(sw_people, ~.x[["name"]])

# What color is each SW character's hair?
map(sw_people, ~ .x[["hair_color"]])

# Is the GoT character alive?
map(got_chars, ~ .x[["alive"]])

# Is the SW character female?
map(sw_people, ~ .x[["gender"]] == "female")

# How heavy is each SW character?
map(sw_people, ~ .x[["mass"]])



#+ eval = FALSE, include = FALSE
# What's each character's name?
map(got_chars, ~.x[["name"]])
map(sw_people, ~.x[["name"]])

# What color is each SW character's hair?
map(sw_people, ~ .x[["hair_color"]])

# Is the GoT character alive?
map(got_chars, ~ .x[["alive"]])

# Is the SW character female?
map(sw_people, ~ .x[["gender"]] == "female")

# How heavy is each SW character?
map(sw_people, ~ .x[["mass"]])

#+ eval = FALSE, include = FALSE
map_lgl(sw_people, ~ .x[["gender"]] == "female")

map_int(got_chars, ~ length(.x$allegiances))

map_chr(got_chars, ~ .x[["name"]])

#+ eval = FALSE, include = FALSE
map_chr(got_chars, ~ .x[["name"]])

map_chr(got_chars, "name")

#+ eval = FALSE, include = FALSE
map_??(got_chars, ??)
map_??(sw_??, ??)

#+ eval = FALSE, include = FALSE
map(sw_people, ~ names(.x)) %>%
  flatten_chr() %>%
  table()
map(got_chars, ~ names(.x)) %>%
  flatten_chr() %>%
  table()

#+ eval = TRUE, include = FALSE
map(sw_vehicles, "pilots", .default = NA)

#+ eval = TRUE, include = FALSE
map_chr(sw_vehicles, list("pilots", 1), .default = NA)

#+ eval = FALSE, include = FALSE
map(got_chars, c(14, 1))
map_chr(sw_vehicles, list("pilots", 1), .default = NA)

#+ eval = TRUE, include = FALSE
map_chr(got_chars, "name")

got_chars_named <- set_names(got_chars, map_chr(got_chars, "name"))

got_chars_named %>%
  map_lgl("alive")

#+ include = TRUE
allegiances <- map(got_chars_named, "allegiances")
tibble::enframe(allegiances, value = "allegiances")

#+ include = FALSE
books <- map(got_chars_named, "books")
map_chr(books[1:2], paste, collapse = ", ")
map_chr(books[1:2], ~ paste(.x, collapse = ", "))

map(got_chars, o)
