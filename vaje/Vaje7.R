library(tidyverse)
library(esquisse)

# vaje 7 A
n<-1000
x<-(1:n-1)^((sqrt(5)-1)/2)*cos((1:n-1)*2*pi*(sqrt(5)-1)/2)
y<-(1:n-1)^((sqrt(5)-1)/2)*sin((1:n-1)*2*pi*(sqrt(5)-1)/2)
plot(x,y)
lattice::xyplot(y~x)
data.frame(X=x, Y=y) %>% ggplot()+aes(x=X,y=Y)+geom_point()
# z esquisse: pod Addins
data.frame(X=x, Y=y) -> df

# moznosti pri ggplotu
ggplot(df) + aes(x=X,y=Y) + geom_point()
ggplot(df, aes(x=X,y=Y)) + geom_point()
ggplot(df) + geom_point(aes(x=X,y=Y))

seq(-pi, pi, 0.1) %>% plot(., sin(.), type="l")
plot(sin, -pi, pi)
seq(-pi, pi, 0.1) %>% data.frame(X=., Y=sin(.)) %>%
  ggplot() + aes(x=X, y=Y) + geom_line()

seq(-pi, pi, 0.01) %>% {plot(cos(.), sin(.), type="l", xlab="x os", ylab="y os", main="krog")}
lines(c(1,1,-1,-1,1),c(1,-1,-1,1,1), type = "l", col = "blue") 
# isto z gg plotom:
seq(-pi, pi, 0.05) %>% {data.frame(X=c(cos(.),c(1,1,-1,-1,1)), 
                                  Y=c(sin(.),c(1,-1,-1,1,1)), 
                                  tip=rep(c("krog","kvadrat"),c(length(.),5)))} %>%
  ggplot() + 
  aes(x=X, y=Y, group=tip, color=tip) +
  geom_path()

seq(-pi, pi, 0.05) %>% {data.frame(X=c(cos(.),c(1,1,-1,-1,1)), 
                                   Y=c(sin(.),c(1,-1,-1,1,1)), 
                                   tip=rep(c("krog","kvadrat"),c(length(.),5)))} %>%
  ggplot() + 
  aes(x=X, y=Y) +
  geom_path() + 
  facet_wrap(vars(tip))

seq(-pi, pi, 0.05) %>% data.frame(alpha=., S=sin(.), C=cos(.)) %>%
  ggplot() +
  geom_path(aes(x=alpha, y=S)) + geom_path(aes(x=alpha,y=C)) + geom_path(aes(x=C, y=S))

# B
funky <- \(n){
  seq(-pi, pi, 0.01) %>% {plot(cos(.), sin(.), type="l", xlab="x os", ylab="y os", main="krog", col="blue")}
  lines(c(1,1,-1,-1,1),c(1,-1,-1,1,1), type = "l", col = "cyan")
  x <- runif(n,-1,1)
  y <- runif(n,-1,1)
  points(x, y, col = ifelse(x^2+y^2<=1, "darkgreen", "red"), pch = 19)
  4*sum(x^2+y^2<=1)/n
}
funky(100)

data.frame(X=x, Y=y) %>% 
  ggplot() + 
  aes(x=X,y=Y, color = 1:1000, size = sqrt(x^2+y^2)) + 
  geom_point() +
  scale_color_gradient(low="#800909", high = "#CC9900") +
  scale_size_continuous(range = c(0.5, 2))

# C
iris %>%
  ggplot() +
  aes(x=Petal.Length, fill=Species) + 
  geom_histogram() +
  theme_minimal()

iris %>%
  filter(Species=="virginica") %>%
  ggplot() +
  aes(x=Petal.Length) + 
  geom_histogram()

# tortni diagram (direkt iz htmlja, ne rabmo znat)
dfB1<-data.frame(labels=c("no","no, but in yellow"),"values"=c(7,1))
ggplot(dfB1, aes(x="", y=values,fill=labels))+
  geom_bar(width = 1, stat = "identity")+coord_polar("y", start=0.2)+
  scale_fill_manual(values=c("#2030DD", "#FFDD44"))+
  #  ggtitle("Is this meme funny?")
  labs(title="Is this meme funny?",x="",y="")+
  theme(plot.title = element_text(size=30),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank(),
        legend.title=element_blank(),
        legend.text = element_text(size = 16, face = "bold"))

data.frame(X=x, Y=y) %>% 
  ggplot() + 
  aes(x=X,y=Y, color = 1:1000, size = sqrt(x^2+y^2)) + 
  geom_point() +
  scale_color_gradient(low="#800909", high = "#CC9900") +
  scale_size_continuous(range = c(1, 5)) +
  geom_abline(slope=4, intercept = -1)



