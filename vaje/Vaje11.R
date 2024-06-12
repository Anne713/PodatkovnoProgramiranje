library(tidyverse)
dir(recursive = T, pattern = "Sport") -> filename
filename %>% readxl::excel_sheets() %>% sapply(\(x){readxl::read_excel(filename, sheet=x)}) -> L
L$Coaches

c(1,4,10,2,20) %>% lead() #isto kot ..
c(1,4,10,2,20) %>% {c(.[-1], NA)}
c(1,4,10,2,20) %>% lag()
c(1,4,10,2,20) %>% diff()

# naloge A
dfA<-data.frame(Day=1:50,Infected=round(1.2^(1:50)))

dfA %>% mutate(New=Infected-lag(Infected))
dfA %>% mutate(New2=c(NA, diff(Infected)))

dfA %>% arrange(desc(Day)) %>%
  mutate(New=Infected-lead(Infected))
dfA %>% arrange(desc(Day)) %>%
  mutate(New2=c(-diff(Infected), NA))

# naloge B
L$Coaches %>% 
  mutate(Name=paste(FirstName, LastName, sep = ' ')) %>%
  select(Name)
L$Coaches %>%
  unite("Name", 2:3, sep = " ")

# B2
L$Teams %>%
  separate(Colors, c("Color1", "Color2"), sep = "/") %>%
  pivot_longer(3:4) %>%
  group_by(Barva=value) %>%
  summarise(St=n(), StPrva=sum(name=="Color1"), StDruga=sum(name=="Color2"))

# naloge C
L$Players %>% inner_join(L$Teams) %>%
  select(contains("name"), BirthDate) -> C1
C1 %>% {.$BirthDate<-mdy(.$BirthDate) %>% year();.} %>%
  arrange(Nickname) %>%
  group_by(Nickname) %>% 
  filter(BirthDate==min(BirthDate))
C1 %>% {.$BirthDate<-mdy(.$BirthDate);.} %>%
  arrange(Nickname) %>%
  group_by(Nickname) %>% 
  top_n(1, desc(BirthDate))

# C2
L$Players %>% select(ID=PlayerID, Address) %>%
  separate(2, c("num", "add"), sep = " ", extra = "merge") %>%
  separate(3, c("a", "b", "c", "tip"), sep = " ", fill = "left") %>%
  unite("add", a:c, sep = " ", na.rm = T)

# text to dataframe: 
p3<-"P0001 Julie Zion 6754 Lakeview Dr. Coral Springs
P0002 Britta Zarinsky 4532 Maplewood Dr. Coral Springs
P0003 Jenna Moldof 100 Oak Lane Coral Springs
P0004 Melissa Kimble 1101 Ramblewood Rd. Coral Springs
P0005 Jessica Anderson 1345 University Dr. Coral Springs
P0006 Leslie Ericson 8922 Coral Ridge Dr. Coral Springs
P0007 Jessica Goodman 3800 Westview Dr. Coral Springs
P0008 Marci Barber 4545 Westview Dr. Coral Springs
P0009 Nancy Dorman 900 Ramblewood Rd Coral Springs
P0010 Julie Fraser 4566 Parkside Dr. Coral Springs
P0011 Kelly James 800 Coral Springs Dr. Coral Springs
P0012 Sherrie Green 6600 Main Street Coral Springs
P0013 Priscilla Pearson 2450 Maplewood Dr. Coral Springs
P0014 Kerri Stone 550 Sample Road Coral Springs
P0015 Toni Moldof 522 Coral Springs Dr. Coral Springs
P0016 Shelly Parker 1001 Coral Ridge Dr. Coral Springs
P0017 Amy Kinzer 922 Sample Road Coral Springs
P0018 Mary Citron 500 Oak Lane Coral Springs
P0019 Jessica Grauer 1881 Vestal Road Coral Springs
P0020 Sonja Freed 2210 Main Street Coral Springs
P0021 Lori Pryor 2001 Parkside Dr. Coral Springs
P0022 Lauren Howard 1520 University Dr. Coral Springs
P0023 Katie Remmen 2200 Cedarwood Dr. Coral Springs
P0024 Katherine Akong 1705 Ramblewood Dr. Coral Springs
P0025 Lilly Taboas 1025 Coral Springs Dr. Coral Springs"

p3 %>% str_split("\n") %>%
  unlist() %>% 
  data.frame(A=.) %>% 
  separate(A, c("ID", "ime", "priimek", "naslov"), sep = " ", extra = "merge")

# purrr::map funkcije
L %>% lapply(head,2) # isto kot..
L %>% map(\(x){head(x,2)})

L$Games %>% summarise_if(is.numeric, mean)
L$Games %>% map_if(is.numeric, mean) %>% #ohrani tiste ki niso numeric kot vector
  map_if(is.POSIXct, \(x){as.numeric(max(x)-min(x))}) %>%
  unlist()

# dodatno iz starega izpita
p1<-data.frame(Event=c("World cup","Ozivela ulica","Euro Math Congress","Summer school Rogla","Final exams","HL3 release date"),Year=c(2022,2021,2004,2022,1999,2077),Day=c(11,2,30,14,5,6),Month=c(12,3,4,7,10,10),stringsAsFactors=F)

p1 %>% mutate(Datum=dmy(paste(Day, Month, Year))) %>%
  arrange(Datum)

p4<-list(mtcars,iris,airquality)
mtcars %>% summarise_if(is.numeric, max)

p4 %>% map(\(x){summarise_if(x, is.numeric, max, na.rm = T)}) %>%
  unlist()























