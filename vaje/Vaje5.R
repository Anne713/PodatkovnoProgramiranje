library(tidyverse)

dir(recursive = T, pattern = 'store') %>% readxl::read_excel() -> store
store %>% {difftime(.$`Ship Date`,.$`Order Date`, units = "days")} -> store$`Order Delay`
head(store$`Order Delay`)

# C
"2009-1-14 18:30:00" %>% ymd_hms() %>% as.Date()
"2009-1-14 18:30:00" %>% stringr::str_extract("^[^ ]+")
"2009-1-14 18:30:00" %>% stringr::str_remove(" .+") %>% ymd()

"24.10.1999" %>% dmy() %>% {c(day(.), month(.), year(.))}
"24.10.1999" %>% str_split('\\.') %>% unlist()

"1/1/2017 9:15" %>% dmy_hm()
"9:15:00 5 Jan 2020" %>% strsplit(" ") %>% .[[1]] %>% {paste(.[2], .[3], .[4], .[1], collapse = " ")} %>% dmy_hms() %>% as.Date()
"9:15:00 5 Jan 2020" %>% str_remove("^[^ ]* ") %>% dmy()

# D
"Zive naj vsi narodi
ki hrepene docakat dan,
da koder sonce hodi,
prepir iz sveta bo pregnan,
da koder sonce hodi,
prepir iz sveta bo pregnan,
da rojak
prost bo vsak,
ne vrag, le sosed bo mejak." -> himna

himna %>% cat()
himna %>% str_split(" |\n") %>% unlist() %>% length()
himna %>% nchar()
himna %>% str_count(".")

dir(recursive = T, pattern = "word") %>% read.csv() -> word
word %>% .[grep("age",.[,1]),]
word$X2 %>% strsplit("") %>% unlist() %>% tolower() %>% factor() %>% summary() %>% .[order(-.)]

"a|A" %>% str_count(word$X2,.) %>% sum()
paste(letters, LETTERS, sep = "|") %>% sapply(\(x){
  x %>% str_count(word$X2,.) %>% sum()
}) %>% .[order(-.)]

store$`Customer Name` %>% strsplit(" ") %>% sapply(\(x){
  paste(str_sub(x[1],1,1),'.',str_sub(x[length(x)],1,1),'.', sep = "")
}) -> store$C.N.

# vaje 5 naloge A
fak <- function(n) {
  if (n<=1) {1} else {n*fak(n-1)}
}
fak2 <- \(n){prod(1:n)}
fak2(4)

naravno <- \(n) {
  if(is.numeric(n)) {n>0 & n%%1==0} else {F}
}
naravno(-1)
naravno(3.4)
naravno(4)
naravno('a')
c(4,1,0,-2,3.4) %>% naravno()

1:5 %>% sapply(fak)
