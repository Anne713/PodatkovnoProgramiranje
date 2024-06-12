library(tidyverse)

jePalindrom <- \(x){
y <- x %>%
  strsplit("") %>%
  unlist() %>%
  rev() %>%
  str_c(collapse = "")
return(x==y)
}
jePalindrom("madam")
jePalindrom("bleh")
jePalindrom("noon")

# "exploratory data analysis"

# library(psych)
library(gt)
library(gtExtras)
library(knitr)

statistika <- describe(mtcars)

statistika %>% 
  as.data.frame() %>%
  mutate(vars=row.names(statistika)) %>%
  relocate(vars, .before = "n") %>%
  gt() %>%
  gt_theme_dot_matrix()

library(dataMaid)
makeDataReport(mtcars, output="html", file="dummyReport.html")

library(skimr)
skim(mtcars)

# nazaj na RegEx
library(janeaustenr)
knjige <- austen_books()
knjige$book %>% unique()

#vsota vseh stevil v besedilu
knjige$text %>%
  str_extract_all("\\d+") %>%
  unlist() %>%
  as.numeric() %>%
  sum()
  
knjige$text %>%
  str_count("[jJ]ane") %>%
  sum()

knjige$text %>%
  str_count("[dD][aA][rR][cC][yY]") %>%
  sum()

# word count
besede <- str_split(knjige$text, pattern = "\\W") %>%
  list_c() %>%
  {.[nchar(.)>0]}
besede %>%
  length()

df <- as.data.frame(tolower(besede))
colnames(df) <- "besede"

df %>%
  dplyr::filter(nchar(besede)>3) %>%
  count(besede, sort=T) %>%
  head(20)

# challenge s spletne ucilnice teden 9

library(readxl)
library(janitor)
obcine <- read_xlsx("dataVaje3/challenge.xlsx", sheet = 3, skip = 10)

obi <- obcine %>% 
  clean_names() %>%
  mutate(id=row_number()) %>%
  relocate(id, .before = "sr_12") %>%
  slice(2:213) %>%
  rename_with(~paste0("2000_",.x), preb_tot_3:ekonv_tot_31) %>%
  rename_with(~paste0("2010_",.x), preb_tot_32:ekonv_tot_60) %>%
  rename_with(~paste0("2020_",.x), preb_tot_61:ekonv_tot_89) 

obi %>%
  colnames()

cincin <- obi %>%
  pivot_longer(cols = "2000_preb_tot_3":"2020_ekonv_tot_89",
               names_pattern = "(\\d{4})_(.*)",
               names_to = c("leto", "spremenljivka"), 
               values_transform = as.character) %>%
  mutate(spremenljivka = str_replace_all(spremenljivka, "_\\d+$", ""), 
         value = str_replace_all(value, "\\D+", "NA"), 
         value = as.numeric(value))

cincin %>%
  select(id, spremenljivka, leto, value) %>%
  filter(spremenljivka == "kmg_dz_1") %>%
  pivot_wider(id_cols = c(id, leto), names_from = "spremenljivka", values_from = "value") %>%
  pivot_wider(id_cols = c(id), names_from = "leto", values_from = "kmg_dz_1")

