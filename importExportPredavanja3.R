df1<-data.frame(A=c(1,2,3),B=c("apple","banana","lemon"))
df2<-data.frame(C=c("car","truck","bus"))
df3<-cbind(df1,df2)

df4<-data.frame(A=c(1,2,3),B=c("apple","banana","lemon"))
df5<-data.frame(A=c(4,5,6),B=c("bike","plane","train"))
df6<-rbind(df4,df5)