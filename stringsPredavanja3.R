library(stringr)

paste(2,"je najmanjse prastevilo!")->mhm

for (i in 1:10) {

  res<-ifelse(i%%2==0,"sodo", "liho")
  print(str_c(i,"je",res,"število!", sep=" "))

}

ime<-c("Anne","Alja","Aljus")

str_to_lower(ime)
str_to_upper(ime)
ime

naslov<-c("hehe hihi hohoho","huhu ha","hehe hi")
str_to_title(naslov)
str_to_sentence(naslov)

sum(str_ends(naslov, 'a'))
naslov[str_ends(naslov, 'a', negate = T)]

library(janeaustenr)
knjige<-austen_books()
text<-knjige$text
sum(str_count(text, "John"))

textSkupaj<-paste(knjige$text, collapse = ", ")
str_count(textSkupaj, "John")
str_count(textSkupaj, "Anne")
