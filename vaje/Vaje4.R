library(tidyverse)
df1<-read.csv("dataVaje3/time_series_covid19_confirmed_global.csv")
df1 %>% .[1:5,1:5]

# vaje 3 naloge B
df1 %>% .[,ncol(.)] %>% sum() #kumulativno
df1 %>% .[,ncol(.)-0:1] %>% {sum(.[,1])-sum(.[,2])} #samo novi na zadnji dan
df1 %>% .[,c(2,ncol(.))] %>% write.csv(gzfile("dataVaje3/covidGlobalno.csv.gz"))

# naloge C
"dataVaje3/SI.zip" %>% unzip(list = T)
"dataVaje3/SI.zip" %>% unzip(exdir = "dataVaje3")
"dataVaje3/SI.txt" %>% read.table(sep="\t") %>% .[,-4:-9] -> zip
zip %>% head()

c("Peter", "Janko", "Metka", "Medo")->imena
grep("e", imena)
grepl("e", imena)
stringr::str_detect(imena, "e")
imena[grepl("e",imena)]
zip$V3 %>% .[grepl("z",.)]
zip %>% .[grep("z",.$V3),2:3]
zip %>% .[grep("h|H",.$V3),2:3]
zip %>% .[grep("[hH]",.$V3),2:3]
zip %>% .[grep("r$",.$V3),2:3]

zip %>% .[.$V2>=6000 & .$V2<=7000,2:3] %>% {colnames(.)<-c("zip", "kraj");.} %>% write.table(
  "dataVaje3/obala.tsv", sep = "\t", row.names = F)

# naloge D
dir(recursive = T, pattern = "\\.xlsx?$")
library(readxl)
readxl::read_excel("dataVaje3/Sample - Superstore.xls") -> store
store %>% .[seq(100,nrow(.),100),1:7] %>% writexl::write_xlsx("dataVaje3/trgovina.xlsx")
readxl::excel_sheets("dataVaje3/Sample - Superstore.xls")

store$`Customer Name` %>% unique() %>% .[grepl(" [^ ]+ ",.)]

# vaje 4 naloge A
library(lubridate)
Sys.time() %>% class()
Sys.Date() %>% class()
today() %>% class()
today() %>% month(label = T, abbr = F, locale = "sl_SI.utf8")
today() %>% lubridate::wday(label = T)
v1 <- c("13.1.2021", "3.Jan.2011", "4 March 14")
v1 %>% lubridate::dmy()
"1.Feb.2020" %>% dmy() %>% difftime(today(),.,units = "weeks")
dmy("1.1.24") %>% {.+years(1) - .}

"25.12.2010" %>% dmy() %>% {.+years(0:9)} %>% .[wday(.,label = T, abbr = F)>="ponedeljek" & wday(.,label = T, abbr = F)<="petek"]
"25.12.2010" %>% dmy() %>% {.+years(0:9)} %>% .[wday(.)>1 & wday(.)<7] %>% year()

# nal. A8
"3.1.2021" %>% dmy() %>% {.+years(0:100)} %>% {.[wday(.)==1]<-.[wday(.)==1]+days(1);.} %>% {.[wday(.)==7]<-.[wday(.)==7]+days(2);.}

# B
dB1<-"April 5th 22";dB2<-"30.1.2020"; dB3<-"2/14/00";
dB4<-"2010-6-19"; dB5<-"4. Jan 1999"
mdy(dB1) %>% format("%d.%m.%Y")
dmy(dB2) %>% format("%m/%d/%y")
mdy(dB3) %>% format("%Y-%m-%d")
ymd(dB4) %>% format("%d. %h %Y")
dmy(dB5) %>% format("%h %dth %y")


