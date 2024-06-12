library(tidyverse)
fak3<-\(n){ifelse(n<=1, 1, n*fak3(n-1))}
1:5 %>% fak3()

# vaje 5 B
{-360:360/360*pi} %>% {plot(sin(.), cos(.), type='l')}
{-100:100/100} %>% plot(.,-sqrt(1-.^2)) # je omejeno na pol kroga

incircle <- function(x,y){x^2 + y^2 <= 1}
incircle(1,1)
{0:10/10} %>% points(.,.)
{0:10/10} %>% incircle(.,.)

nrt <- \(x, n=2){x^(1/n)}
nrt(4)
nrt(8,3)
nrt(81,4)

# C
minMat <- \(m) {apply(m, 2, min)}
matrix(1:9, 3, 3) %>% minMat()

minolovec <- \(nrow, ncol, nmines=floor(nrow*ncol/5)){
  c(rep(T, nmines), rep(F, ncol*nrow-nmines)) %>% sample() %>% matrix(nrow, ncol) %>%
    tryCatch(error = \(x){message("Podatki so nesmiselni."); NaN})
}
minolovec(3,4)
minolovec(6,6,30)
minolovec(3,3,90)

# D
tapply(1:10, rep(c('a','b'),5), sum)
tapply(iris[,1], iris$Species, mean)
apply(iris[,-ncol(iris)], 2, \(x){
  tapply(x, iris$Species, mean)
})
aggr2 <- \(vekt, df, funk) {
  sapply(df, \(x){tapply(x, vekt, funk)})
}
aggr2(iris[,5], iris[,-5], mean)

inputdf<-data.frame(From=c("colour","lift","centre"), To=c("color","elevator","center"),stringsAsFactors=F)
inputstring<-"In the centre of the lift there was a banana"
translate <- \(str, df){
  str %>% str_split(" |\n")  %>% unlist() %>% {.==inputdf[2,1]}
 }

inputstring %>% str_split(" |\n")  %>% unlist() %>% {sapply(inputdf[,1], \(x){x==.})}


