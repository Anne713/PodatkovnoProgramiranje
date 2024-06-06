library(tidyverse)
library(janitor)

people <- tibble(
  name = c('Alice', 'Bob', 'Catherine', 'David', 'Emma'),
  age = c(25, 58, 33, 15, 46)
)

people %>% mutate(ageGroup = if_else(age<18, 'otrok', 
                                     if_else(age<50), 'odrasel', 'senior'))

people %>% mutate(age_group = case_when(age<18~'otrok', age>50~'senior',
                                        age>40~'kriza srednjih let',
                                        .default = 'odrasel'))

peoples <- tibble(
  name = c('Alice, Jim', 'Bob,Kathra', 'Catherine', 'David', 'Emma'),
  age = c(25, 58, 33, 15, 46)
)
peoples %>% separate_longer_delim(name, ",") %>%
  mutate(name=trimws(name))

#map family

airquality %>%
  clean_names() %>%
  map(mean, na.rm=T)

#gt
library(gt)

sp500 %>%
  dplyr::select(date:close) %>%
  head() %>%
  gt(caption="first gt object") %>%
  tab_header(title = "mhm ja naslov", 
             subtitle = "podnaslovoooovov") %>%
  fmt_currency(columns = c(open:close), currency = "EUR") %>%
  fmt_date(columns = date, date_style = 7)

sp500 %>%
  dplyr::select(date:close) %>% 
  mutate(teden=week(date),
         dan_v_tednu=lubridate::wday(date, abbr = FALSE, label=TRUE)) %>%
  head(14) %>%
  arrange((teden)) %>%
  dplyr::filter(between(teden,50,52)) %>% 
  gt(caption="First gt object", groupname_col = "teden") %>%
  tab_header(title="SP500 example",
             subtitle = "trgovanje v 6 dneh") %>%
  fmt_currency(columns=c(open:close),
               currency = "EUR") %>%
  fmt_date(columns=date,
           date_style = 7) %>%
  summary_rows(columns = c(high, low), 
               fns = list(average = "mean"),
               fmt=~fmt_currency(.,
                                 currency="EUR"))
#oz ista stvar malo lepse urejena:
library(gt)
library(lubridate)

# kreiranje dataframe
df<-sp500 |>
  dplyr::select(date:close) |> 
  mutate(teden=week(date),
         dan_v_tednu=lubridate::wday(date, abbr = FALSE, label=TRUE)) |> 
  head(14) |>
  arrange((teden))|> 
  dplyr::filter(between(teden,50,52)) 

#kreiranje gt objekta
gt<-df |> 
  gt(caption="First gt object",
     groupname_col = "teden") |> 
  tab_header(title="SP500 example",
             subtitle = "trgovanje v 6 dneh") |> 
  fmt_currency(columns=c(open:close),
               currency = "EUR") |> 
  fmt_date(columns=date,
           date_style = 7) 

#dodajanje povzetka
gt|> 
  summary_rows(
    columns = c(high, low),
    fns = list(average = "mean"),
    fmt=~fmt_currency(.,
                      currency="EUR"))

library(gtsummary)

airquality %>%
  clean_names() %>%
  filter(month %in% 5:6) %>%
  tbl_summary(include=c(ozone, temp, month, wind),
              by = month,
              missing = "no",
              statistic = list(all_continuous() ~ "{mean} ({sd})")) %>%
  add_p()





