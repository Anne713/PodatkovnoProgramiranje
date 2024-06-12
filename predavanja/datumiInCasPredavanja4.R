library(lubridate)
library(tidyverse)

oldDate<-ymd("12020320")
as.numeric(oldDate)

df<-data.frame(date=c(20240301, 20240302, 20240320, 20240321))
df %>% mutate(datum=ymd(date))

date<-"2019-05-05"
time<-"18:51:32"

datetime<-paste(date,time)

as.POSIXct(datetime) ## base R

Sys.getlocale()
mdy("januar, 17 2024", locale = "sl_SI.utf8")
mdy("März 31, 2017", locale="de_DE.utf8")

#-------------
#mini nalogica

library(arrow)
df1<-read_parquet("./podatki/yellow_tripdata_2023-01.parquet")
pickup<-df1$tpep_pickup_datetime

pickupDan<-wday(pickup, label=T, abbr=F, locale="sl_SI.utf8")
summary(pickupDan)

#-------------

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

mdy(d1)
ymd(d2)
dmy(d3)
mdy(d4)
mdy(d5)

#druga nalogica
RD<-ymd(20041127)
wday(RD, label = T)
RDs<-ymd(20441127)
wday(RDs, label = T)
wday(RD+years(40), label=T) #easier

#--------------

mojaStarost<-as.duration(today()-RD)
ddays(365)
today()+dyears(10)
today()+years(10)
wday(RD+years(40), label=T)
seconds_to_period(mojaStarost)


#tretja nalogica
pickupdatetime<-ymd_hms(df1$tpep_pickup_datetime)
dropoffdatetime<-ymd_hms(df1$tpep_dropoff_datetime)
as.duration(dropoffdatetime-pickupdatetime)->razlike
seconds_to_period(mean(razlike, na.rm=T))
df2<-data.frame(razlika=razlike)
head(df2)

#cetrta nalogica
mdy("08,30,1930")
mdy("Aug30,1930")
dmy("30aug1930")
#---------------

#poisci tiste, kjer pickup dan ni isti kot dropoff
library(dplyr)
df3<-df1 %>%
  mutate(pickDan=wday(pickupdatetime),
         dropDan=wday(dropoffdatetime)) %>%
  dplyr::filter(pickDan!=dropDan)
df3
