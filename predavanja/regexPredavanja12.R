string <- "car"
pattern <- "car"
grep(pattern, string)

string <- c("car", "cars", "in a car", "truck", "car's trunk")
pattern <- "car"
grep(pattern, string)
grepl(pattern, string)
string[grepl(pattern, string)]

library(stringr)
str_detect(string, pattern)
str_count(string, pattern)

# regex
stringy <- c("car", "cars", "in a car", "truck", "car's trunk", "core", "acrobat", "cat")
grepl("^c.r", stringy)
grepl("^c..$", stringy)
grepl("^c.r.$", stringy)

grep("\\w", c(" ", "a", "1", "A", "%", "\t"))
grep("\\W", c(" ", "a", "1", "A", "%", "\t"))
grep("\\d", c(" ", "a", "1", "A", "%", "\t"))
grep("\\D", c(" ", "a", "1", "A", "%", "\t"))
grep("\\s", c(" ", "a", "1", "A", "%", "\t", "\n"))
grep("\\S", c(" ", "a", "1", "A", "%", "\t", "\n"))

grepl("^[aci]\\w\\w", stringy)
grepl("^[aci]\\w\\s", stringy)
grepl("^[^c]", stringy)

words <- c("avto", "Polona", "in a car", "car", "cAt", "lepo-grdo", "no.2", "bes", "besede", "Beni", "Avto Moto", "colonel", "tic")
nums <- c("1", "20", "0", "zero", "nic", "is it 100%", "09")

grepl("^[1-9]", nums)
grepl("[0-9]", nums)
grep("((\\d)|([1-9]\\d))", c("1", "20", "0", "zero", "it is 100%", "09"))

abc <- c("a", "ac", "abc", "abbc", "abbbc", "abbbbc", "abbbbbc", "abbbbbbc")
grepl("ab?c", abc)
grepl("ab+c", abc)
grepl("ab*c", abc)
grepl("ab{3}c", abc)
grepl("ab{2,5}c", abc)
grepl("ab{4,}c", abc)

mno <- c("m", "mn", "mno", "mmmno", "mnmno", "nnnnmno", "mnmnmn", "mnmnmno", "monnmmn", "nom", "nomnom")
mno[grepl("((mn)*)o$", mno)]
mno[grepl("(mn){3}", mno)]
mno[grepl("m+n+", mno)]

grep("^([a-z]+ )*[a-z1-3]+$", c("words", "words or sentences", "123 no", "Words"," word","word 123"))
grep("^([a-z]+ )", c("words", "words or sentences", "123 no", "Words"," word","word 123"))

text<-"Yesterday I had 100 Euros, today I only have 45 Euros left."
regmatches(text, gregexpr("(\\d+)",text)) %>%
  list_c()
str_extract_all(text, "\\d+") %>% 
  purrr::as_vector()

