#A
a=3+5-10;a
a<-3+5-10
3+5-10->a
4^5
4**5
log(3*4)
exp(1)
exp(2.484907)
sin(pi)
sin(pi)==0
sqrt(4)/log10(100)
abs(-10)+floor(4.6)+ceiling(3.2)

#B
c("miza","stol",'omara',"okno")->v0
v0[4]
v1<-c(1,4,3,15,75)
v2<-c(5,6,0,sqrt(2),-4)
v1;v2
v1+3
v1+v2->v3
sum(v1*v2)
c(v1,v2)

#C
c(1,'a',T)
c(1,F)
1:100->v
sum(v)
sum(v*v)
v*v
sum(v)/length(v)
mean(v)
min(v)
max(v)
letters
v[-1:-70]<-0
v
v[1:20*-5]<--1
v
seq(-5,-100,-5)

#D
100:1
-100:-1
-(1:100)
seq(-50,1000,10)
seq(1,106,3)
1:36*3-2

#E
list(1, 'a', T)->l1
l1
list(2,3,2,'banana',1:10)->l2
l2
l1[[2]]
l2[5]
l2[[3]]<-'0'
l3<-c(l2,l1)
l3.1<-list(l2,l1)
l3.2<-l2;l2[[6]]<-l1
l3.2[[6]][[1]]
l2[[5]][4]
l4<-list('pivo', 4.3, l1, "Koper", l2)
l4
l4[[3]][3]<--2
l5<-list(4,5.3,1.4,0,-3,3,3)
sum(unlist(l5))

#F
matrix(1,4,3)
matrix(c(1,0,0,0,0),4,4)
matrix(1:5,4,4)
m2<-matrix(9:1,3,3)
m2
matrix(1:12,3)
m1<-matrix(1:9,3,3,T)
?matrix
m1
m1.1<-matrix(1:9,3,byrow = T)
m1.1
m3<-matrix(1:4,2,6)
m3
m1+m2
m3-10->m3
m3
rbind(cbind(m1,m2), m3)
m1^2
m1 %*% m1
dim(m1)
m1
m1[2,1]<--1
m1
m1[,1]
m2
m2[1:3,2]
m2[,2]
m2[1:2,1:2]
