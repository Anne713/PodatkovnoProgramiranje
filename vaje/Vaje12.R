# star izpit sept 2022

# Problem 2: Napišite funkcijo, ki za dan data.frame vrne isti data.frame 
# ampak samo s stolpci, ki ne vsebujejo NA vrednosti. 
# Poženite svojo funkcijo na data.frame-u **airquality**.

library(tidyverse)
p2<-\(df){df %>% select_if(\(x){!is.na(max(x))})}
p2(airquality)

# Problem 5: V priloženi datoteki **OrderDatabase.xlsx** so 3 delovni listi, od katerih vsak vsebuje data.frame.
# Kolikšen je skupni prihodek artiklov, naročenih dne 3.3.2006?
library(readxl)
filename <- dir(recursive = T, pattern = "OrderDatabase")
excel_sheets(filename) %>%
  sapply(\(x){read_excel(filename, sheet = x)}) -> p5
p5$orders %>%
  inner_join(p5$orderline) %>% 
  inner_join(p5$stock) %>%
  select(OrderDate, Qty, UnitCost) %>%
  filter(OrderDate == dmy("3.3.2006")) %>%
  {sum(.$Qty*.$UnitCost)}

# Problem 6: Glede na data.frame **tidyr::billboard** prikaži 5 najpogosteje uporabljenih besed 
# v imenih pesmi skupaj z njihovim številom (kombinacije, kot so "Can't", naj štejejo kot 1 beseda za ta problem).
tidyr::billboard %>%
  .$track %>%
  str_split("[^A-Za-z0-9'-]") %>%
  unlist() %>%
  .[.!=""] %>%
  as.factor() %>%
  summary() %>%
  .[1:5]

# Problem 7: Dan je data.frame o Titaniku https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv,
# potniški ladji, potopljeni leta 1912. Raziščite, ali so med potniki, ko je prišlo na pomoč, res imele 
# prednost "ženske in otroci" pred "moškimi". 
# Narišite histogram štirih skupin (vsaka kombinacija starosti in spola), ki prikazuje odstotek preživelih izmed populacije te skupine.

"https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv" %>%
  read.csv() %>%
  group_by(age, sex) %>%
  summarise(skupaj = n(), preziveli = sum(survived == "yes"), odstotek = 100*preziveli/skupaj) %>%
  {print(.);.} %>%
  ggplot() + aes(x=paste(age,sex), weight=odstotek) + geom_bar()

# "izpit"
# Naloga 1: Naključno generirajte 100 **celih** števil med -40 in 40. 
# Prikažite porazdelitev vrednosti s histogramom. Histogram naj ima naslov "Porazdelitev nakljucnih vrednosti".
sample(-40:40, 100, replace = T) %>%
  data.frame(A=.) %>%
  ggplot() + aes(x=A) + geom_bar() + labs(title = "Porazdelitev nakljucnih vrednosti")

# Naloga 2: Nakljucno generirajte 1000 **celih** stevil med 1 ter 10000. Koliko stevil je lihih in koliko je sodih?
sample(1:10000, 1000, replace = T) %>%
  {c(Soda=length(.)-sum(. %% 2), Liha=sum(.%%2))}

# Naloga 3: Nakljucno generirajte 1000 **celih** stevil med 1 ter 10000. Koliko stevil je lihih in koliko je sodih?
letters %>% sample(50, replace = T) %>% paste0(collapse = "") %>%
  {print(.);.} %>%
  strsplit("") %>% unlist() %>% data.frame(A=.) %>%
  ggplot() + aes(x=A) + geom_bar()

# Naloga 4: Pretvorite data.frame grades is wider to longer obliko s pomocjo funkcije pivot_longer, 
# kjer bosta stolpca math ter history shranjena v stolpec z imenom "predmet", ocene pa v stolpcu z imenom "ocena".
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                     math = c(95, 80, 90, 85), 
                     history = c(90, 85, 85, 90))
grades %>%
  pivot_longer(math:history, names_to = "predmet", values_to = "ocena")

# Naloga 5: S pomocjo tidyverse slovnice odgovorite na naslednja vprasanje, in sicer, 
# kaksen je odstotek umorov glede na populacijo po regijah. 
# Rezultate razvrstite padajoce po odstotku. 
install.packages("dslabs")
dslabs::murders %>% group_by(region) %>% 
  summarise(pop = sum(population), murders = sum(total)) %>%
  mutate(odstotek = 100*murders/pop) %>%
  arrange(desc(odstotek))

# Kasen je ta odstotek po prvi crki drzave?
dslabs::murders %>% 
  mutate(prva = str_sub(state, 1, 1)) %>%
  group_by(prva) %>% 
  summarise(pop = sum(population), murders = sum(total)) %>%
  mutate(odstotek = 100*murders/pop) %>%
  arrange(desc(odstotek))
  
# Naloga 6: S pomocjo regular expressiona iz texta: a) pridobite vsa imena b) pridobite vsa stevila
text<-"Drew has 3 watermelons, Shawn has 4 hamburgers, Karina has 12 tamales, and Anna has 6 soft pretzels"
text %>%
  str_extract_all("[A-Z][a-z]*")
text %>%
  str_extract_all("\\d+")

# Naloga 7: Kaksna je razlika v dnevih med datumoma?
x <- "11 th april 2012"
y <- "April 24th 2018 11:59:59"
as.Date(mdy_hms(y)) - dmy(x)





