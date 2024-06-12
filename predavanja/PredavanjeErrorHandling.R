tryCatch(sqrt("a"), error=function(e) print("Ne mores"))

covid19<-read.csv("./dataVaje3/time_series_covid19_confirmed_global.csv")

sapply(c(4,9,"covid19"), function(x) tryCatch(sqrt(as.numeric(x)), error=function(e) NA))
sapply(covid19$X3.9.23, function(x) tryCatch(sqrt(x), error=function(e) NA))

for (x in c(4, 9, "mhm", 16)) {
  tryCatch(sqrt(as.numeric(x)), error=function(e) NA)
}

# vaja

divide1<-function(x,y) {
  if (y!=0){
    print(x/y)
  } else {print("Cannot divide by zero!")}
}
divide2<-function(x,y) {
  tryCatch(print(x/y), error=function(e) {print("Problem")})
}
divide3<-function(x,y) {
  tryCatch({
    if(y!=0) {
      print(x/y)
    } else {
      error
    }}, error=function(e) {print("Problem")})
}
divide4<-function(x,y) {
  tryCatch({if(y!=0) {print(x/y)} else {error}}, error=function(e) {print("Problem")})
}

divide1(4,2)
divide1(4,0)
divide2(4,2)
divide2(4,0)
divide2(4,"0")
divide4(4,2)
divide4(4,0)
divide4(4,"0")


