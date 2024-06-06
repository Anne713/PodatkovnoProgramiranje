df<-airquality
sapply(df,mean,na.rm=T)
summary(df)

mtcars->df2
tapply(df2$mpg, df2$cyl,mean)

#lastne funkcije -----
izpisiVsoto<-function(x,y) {
  vsota<-x+y
  paste0("Vsota ",x," in ",y," je ",vsota)
}
izpisiVsoto(2,7)


nc<-sample(1000000,10000,replace=T)
sum(ifelse(nc%%2 == 0, T, F))/length(nc)   

vsotaRazlika<-function(x,y) {
  vsota<-x+y
  razlika<-x-y
  list(vsota=vsota, razlika=razlika)->rez
  return(rez)
}
vsotaRazlika(4,2)

mapply(function(x,y,z) {3 * x*y*z},list(1,2,3),MoreArgs=list(2,3))

results<-sapply(1:3, function(x) {
                        res<-sqrt(x)+4
                        return(res)
})