library(tidyverse)
library(janitor)

mtcars |> 
  dplyr::select(mpg:hp, wt) |>
  head()

mtcars |> 
  dplyr::select(-(qsec:carb)) |>
  head()

mtcars |> 
  dplyr::select(ends_with('p'), contains("se")) |>
  head()

iris |>
  clean_names() |>
  dplyr::select_if(is.numeric) |>
  head()

iris |>
  clean_names() |>
  dplyr::select(where(is.numeric)) |>
  head()

moto<-mtcars
rownames(moto)<-str_replace_all(tolower(rownames(moto)), " ", "_")
head(moto)

mtcars |> 
  dplyr::select(where(is.numeric) & any_of(c('mpg', 'test', 'hp', 'wt', 'ok'))) |>
  head()
