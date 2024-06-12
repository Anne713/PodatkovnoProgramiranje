library(tidyverse)
library(janitor)

df<-mtcars %>% slice_sample(n=10)

df %>%
  mutate(id=row_number()) %>%
  relocate(id, .before = "mpg")

df %>%
  group_by(cyl) %>%
  mutate(id=row_number()) %>%
  relocate(id, .before = "mpg")

# ntile naredi glede na izbrani stolpec izbrano stevilo skupin
df %>%
  mutate(skupina=ntile(mpg, 3)) %>%
  relocate(skupina, .before = "mpg")

df %>%
  dplyr::select(mpg, cyl) %>%
  mutate(vrstni_red = min_rank(-mpg))
# dense_rank naredi isto, samo da po iznacenih nadaljuje po vrsti, ne spusti stevilke
df %>%
  dplyr::select(mpg, cyl) %>%
  mutate(vrstni_red = dense_rank(-mpg))

df1 <- airquality %>%
  clean_names() %>%
  dplyr::filter(month==5) %>%
  head(10)

df1 %>% 
  mutate(temp_lag=lag(temp), 
         procent_spr=round((temp_lag-temp)/temp*100,2))

library(readxl)
df2 <- read_xlsx("./podatki/import_problematic.xlsx", 
                 sheet = 3,
                 skip = 10)

df2 %>%
  slice(2:213) %>%
  tail()

fTOc<-function(x) {round((x-32)*5/9,0)}
input<-c(100, 102, 99)
fTOc(input)

airquality %>%
  clean_names() %>%
  mutate(temp_c = fTOc(temp)) %>%
  head()

stupidFunction<-function(x,y){return(sum(x,y))}

airquality %>% 
  clean_names() %>%
  mutate(something=stupidFunction(month, day)) %>%
  head(3)
# sesteje cel stolpec month in cel stolpec day, namesto v vsaki vrstici (pri agregatnih funkcijah)
# mozne resitve: 
stupidFunctionV<-Vectorize(stupidFunction)
airquality %>% 
  clean_names() %>%
  mutate(something=stupidFunctionV(month, day)) %>%
  head(3)

airquality %>% 
  clean_names() %>%
  rowwise() %>% #naredi vsako vrstico svojo groupo essentially
  mutate(something=stupidFunction(month, day)) %>%
  head(3) #ce bi rd delou naprej naredi se ungroup()

airquality %>% 
  clean_names() %>%
  mutate(id=row_number()) %>% #prakticno isto kot rowwise
  mutate(something=stupidFunction(month, day), .by = id) %>%
  head(3)

#neki po mescih
airquality %>%
  clean_names() %>%
  mutate(avg=mean(temp), .by = month) %>%
  head()

# nalogica
mpgTOlkm <- \(x){
  if (x==0) return(0)
  else return(round(235.21/x, 2))
  }

mtcars %>%
  mutate(car=row.names()) %>% # ????
  rowwise() %>%
  mutate(lkm=mpgTOlkm(mpg)) %>%
  relocate(lkm, .before = mpg) %>%
  ggplot() + aes(x=lkm, y=wt, label=car) + geom_point() +
  geom_label() +
  geom_smooth(method = "lm", se=F)
  
# zdruzevanje vec tabelic
band_members %>%
  inner_join(band_instruments, #izpise tiste ki so v obeh
             join_by(name==name))
  
band_members %>%
  full_join(band_instruments, #zdruzi vse in napise NA kjer nima podatka
             join_by(name==name))

band_members %>%
  anti_join(band_instruments, #samo stolpce iz prvega df in to tiste vrstice, ki niso v drugem
             join_by(name==name))

band_members %>%
  semi_join(band_instruments,
             join_by(name==name))

band_members %>%
  cross_join(band_instruments) #kartezicni produkt vsak z vsakim

# naloga prvi nacin
library(arrow)
fielding <- read.csv("podatki/FieldingOF.csv")

fieldi <- fielding %>%
  as_tibble() %>%
  dplyr::filter(yearID %in% 1940:1950) %>%
  summarise(games=sum(Gcf), .by = c("playerID", "yearID")) %>%
  arrange(yearID) %>%
  group_by(yearID) %>%
  mutate(vrstni_red = dense_rank(-games)) %>%
  dplyr::filter(vrstni_red == 2)

people %>%
  dplyr::select(playerID, nameFirst, nameLast) %>%
  inner_join(fieldi, join_by(playerID==playerID)) %>%
  arrange(yearID)

# naloga drugi nacin

fieldin <- fielding %>%
  as_tibble() %>%
  dplyr::filter(yearID %in% 1940:1950) %>%
  summarise(games=sum(Gcf), .by = c("playerID", "yearID")) %>%
  arrange(yearID) %>%
  group_by(yearID) %>%
  slice_max(n=2, order_by = games) %>%
  slice_min(order_by = games)

people %>%
  dplyr::select(playerID, nameFirst, nameLast) %>%
  inner_join(fieldin, join_by(playerID==playerID)) %>%
  arrange(yearID)












