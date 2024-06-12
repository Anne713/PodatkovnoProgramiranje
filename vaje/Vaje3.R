rep(c("kava","caj","pivo","sok"),30)->pijace
sample(factor(rep(c("kava","caj","pivo","sok"),30)))->pijaceMixed
c('b','d','a','c')->v
order(v)
v[order(v)]
pijaceMixed[order(pijaceMixed)]

library(dplyr)
1:4 %>% sum()
1:4 |> sum()
1:12 %>% matrix(3,4) # je enako kot
3 %>% matrix(1:12,.,4) # je enako kot
4 %>% matrix(1:12,12/.,.)
4 %>% {matrix(1:12,12/.,.)} # ustavimo privzeto nastavitev, da gre argument na prvo mesto

4 %>% letters[.]
sample(letters) %>% .[order(.)]

#naloge 2 E
iris %>% head()
iris$Species %>% levels()
iris[iris$Species=="setosa" & iris$Petal.Length<1.5,]

airquality %>% .[.$Temp >= 50 & .$Temp <= 60,]
airquality %>% .[.$Wind>15,c("Wind","Day","Month")] # to je v mph, mi pa hocemo vec od 15 kmh
?airquality
airquality %>% .[.$Wind>15/1.609,c("Wind","Day","Month")]

paste0(LETTERS,letters, collapse = " ")
paste0(sample(LETTERS[-c(1,5,9,15,21)], 50, replace = T), 
      sample(letters[c(1,5,9,15,21)], 50, replace = T), 
      sample(letters[-c(1,5,9,15,21)], 50, replace = T), 
      sample(letters[c(1,5,9,15,21)], 50, replace = T), 
      sample(letters[-c(1,5,9,15,21)], 50, replace = T))

1:26 %>% {names(.)<-letters;.} %>% .[c('a','e','i','o','u')]

1:4 %in% 3:6

# vaje 3 ----------
library(readxl)
install.packages("readxl")
install.packages("writexl")

dir.create("dataVaje3")
dir(recursive = T)
"dataVaje3/file_example_XLS_50.xls" %>% readxl::read_excel(skip = 2) %>% as.data.frame()
"dataVaje3/data.csv" %>% read.csv() %>% writexl::write_xlsx("dataVaje3/drzave.xlsx")

df1<-read.csv("dataVaje3/time_series_covid19_confirmed_global.csv")
View(df1)
dim(df1)
df1 %>% .[.$Country.Region=="Slovenia",c(1:4,ncol(.)-6:0)] %>% write.csv("dataVaje3/covidSlo.csv")
