#+ include = FALSE
R.version

#+ include = FALSE
library(gapminder)
library(tidyverse)

#+ include = FALSE
gapminder

#+ include = FALSE
gapminder %>%
  count(continent)

#+ eval = FALSE, include = FALSE
africa <- gapminder[gapminder$continent == "Africa", ]
africa_mm <- max(africa$lifeExp) - min(africa$lifeExp)

americas <- gapminder[gapminder$continent == "Americas", ]
americas_mm <- max(americas$lifeExp) - min(americas$lifeExp)

asia <- gapminder[gapminder$continent == "Asia", ]
asia_mm <- max(asia$lifeExp) - min(africa$lifeExp)

europe <- gapminder[gapminder$continent == "Europe", ]
europe_mm <- max(europe$lifeExp) - min(europe$lifeExp)

oceania <- gapminder[gapminder$continent == "Oceania", ]
oceania_mm <- max(europe$lifeExp) - min(oceania$lifeExp)

cbind(
  continent = c("Africa", "Asias", "Europe", "Oceania"),
  max_minus_min = c(africa_mm, americas_mm, asia_mm,
                    europe_mm, oceania_mm)
)

#+ eval = FALSE
gapminder %>%
  group_by(continent) %>%
  summarize(max_minus_min = max(lifeExp) - min(lifeExp))

#+ eval = TRUE
child <- c("Reed", "Wesley", "Eli", "Toby")
age   <- c(    14,       12,    12,      1)

s <- rep_len("", length(child))
for (i in seq_along(s)) {
  s[i] <- paste(child[i], "is", age[i], "years old")
}
s

paste(child, "is", age, "years old")
glue::glue("{child} is {age} years old")

#+ eval = FALSE
install.packages("tidyverse") # <-- install purrr + much more
install.packages("purrr")     # <-- installs only purrr

library(tidyverse) # <-- loads purrr + much more
library(purrr)     # <-- loads only purrr

#+ eval = FALSE
.x <- SOME VECTOR OR LIST
out <- vector(mode = "list", length = length(.x))
for (i in seq_along(out)) {
  out[[i]] <- .f(.x[[i]])
}
out
