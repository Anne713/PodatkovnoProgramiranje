library(tidyverse)
library(arrow)

sales_data <- tibble(
  salesperson = c('Alice', 'Bob', 'Catherine', 'Alice', 'Bob', 'Catherine', 'Alice', 'Bob', 'Catherine'),
  region = c('East', 'East', 'East', 'West', 'West', 'West', 'North', 'North', 'North'),
  sales = c(300, 250, 450, 500, 400, 550, 600, 350, 500)
)

sales_data %>%
  group_by(salesperson) %>%
  summarise(prodaja=sum(sales)) %>%
  ungroup()
# isto kot ..
sales_data %>%
  summarise(prodaja=sum(sales), .by = "salesperson")
  
nyc <- read_parquet("podatki/yellow_tripdata_2023-01.parquet")

nyc %>%
  colnames()

nyc_payType_ratecode <- nyc %>%
  mutate(pay_type = as.character(payment_type)) %>%
  summarise(stevilo = n(), .by = c("pay_type", "RatecodeID")) %>%
  arrange(desc(stevilo)) 
  
nyc_payType_ratecode %>%
  summarise(stevilo = sum(stevilo), .by = "RatecodeID")

library(esquisse)
library(ggplot2)

ggplot(nyc_payType_ratecode) +
  aes(x = pay_type, y = stevilo) +
  geom_col(fill = "#112446") +
  labs(x = "tip placila", 
       y = "stevilo prevozov", title = "Stevilo prevozov", subtitle = "Prevozi po placilu in okraju") +
  theme_classic()

# prestavljanje stolpcev
mtcars[,c(10,1:9,11)] %>% 
  as_tibble()
# isto ampak lazje:
mtcars %>%
  relocate(c("gear", "mpg"), .after = "vs") %>%
  as_tibble()

data <- tibble(person = c("Anne", NA, NA, "Claire", NA), measurment = c(2,3,4,1,5))

filled_data <- data %>%
  fill(person, .direction = "down")

mtcars %>%
  mutate(avto = row.names(.)) %>%
  pivot_longer(cols=mpg:carb, 
               names_to = "lastnost",
               values_to = "vrednost") %>%
  as_tibble()

airquality %>%
  dplyr::select(Month, Day, Temp) %>%
  dplyr::filter(Month %in% c(5,6,7) & Day < 4) %>%
  pivot_wider(names_from = "Month",
              values_from = "Temp",
              names_prefix = "mesec_")
      
# slice helperji
mtcars %>%
  mutate(avto = row.names(.)) %>%
  as_tibble() %>%
  dplyr::select(avto, mpg) %>%
  slice_max(order_by = mpg, n=3)

dfAvto <- mtcars %>%
  mutate(avto = row.names(.)) %>%
  dplyr::select(avto, mpg, wt)

ggplot(dfAvto) +
aes(x = mpg, y = wt) +
geom_point(shape = "circle", size = 2.85, colour = "#112446") +
geom_smooth(method = "lm", se=FALSE)+
theme_minimal()

mtcars %>%
  slice_sample(prop = 0.2)

mtcars %>%
  mutate(avto = row.names(.)) %>%
  dplyr::select(avto, mpg, wt, cyl) %>%
  slice_max(by = "cyl", order_by = mpg, n=3)
# isto kot po starem: 
mtcars %>%
  mutate(avto = row.names(.)) %>%
  dplyr::select(avto, mpg, wt, cyl) %>%
  group_by(cyl) %>%
  slice_max(n=3, order_by = mpg) %>%
  ungroup()









