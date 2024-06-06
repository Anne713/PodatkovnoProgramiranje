# v base R
index<-data.frame(year=as.factor(2007:2016), pop=sample(10000:20000, size=10))
# če daš kot factor, pol je kt bar chart sam s črtami, sicer pa "razsevni grafikon" - točke
plot(index$year,index$pop,
     main="populacija skozi leto",    #labels
     ylab="populacija",
     xlab="leto")

# lattice
library(lattice)

barchart(pop~year, data=index,
         main="populacija skozi leto",
         ylab="populacija",
         xlab="leto")
xyplot(pop~year, data=index,
       main="populacija skozi leto",
       ylab="populacija",
       xlab="leto")

xyplot(mpg~wt|as.factor(cyl), data=mtcars)

# ggplot2
library(tidyverse)

ggplot(data=faithful,
       mapping=aes(x=eruptions,
                   y=waiting))+
  geom_point()

ggplot(faithful, aes(x=eruptions, y=waiting, color=eruptions<3)) +
  geom_point() +
  geom_density_2d()

ggplot(data=faithful) + #tuki color ne nardi nc, ker se ne vid
  geom_histogram(mapping = aes(x=eruptions))

# nalogica 1
ggplot(faithful, aes(x = eruptions, y = waiting)) + 
  geom_point(shape=ifelse(faithful$eruptions<3,15,17), size=3, alpha=0.3)

# nalogica 2 in 3
ggplot(faithful, aes(x = eruptions, fill=waiting<60)) + 
  geom_histogram(position = "dodge")

# nalogica 4
ggplot(faithful) + 
  geom_point(aes(x = eruptions, y = waiting)) +
  geom_vline(xintercept = 3, linetype = 4, color = "blue", size = 2)

# nalogica 5
ggplot(mpg) + 
  geom_jitter(aes(x = class, y = hwy), width = 0.2) +
  stat_summary(aes(x = class, y = hwy), fun = "mean", color = "brown", size = 1, alpha = 0.5) +
  stat_summary(aes(x = class, y = hwy), fun = "median", color = "blue", size = 1, alpha = 0.5)

ggplot(mpg) + 
  geom_point(
    aes(x = displ, 
        y = hwy, 
        colour = class))

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class, size = cyl)) + 
  scale_colour_brewer(type = 'qual', palette = "Set3") +
  scale_size_continuous(breaks = c(5,6,8), range = c(1.5,4))

library(ggthemes)
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class, size = cyl)) +
  scale_color_colorblind()

# facet
ggplot(mpg) +
  geom_point(aes(x=displ, y=hwy)) +
  facet_wrap(~class, scale="free")

ggplot(mpg) + 
  geom_bar(aes(y = manufacturer)) + 
  facet_grid(class ~ ., scale="free", space = "free")

ggplot(mpg) + 
  geom_bar(aes(x = class)) + 
  scale_y_continuous(limits = c(0, 40)) #pokaze samo tiste ki so pod 40

ggplot(mpg) + 
  geom_bar(aes(x = class)) + 
  coord_cartesian(ylim = c(0,30))

df <- mpg %>% count(class)

ggplot(df) + 
  geom_bar(aes(x = reorder(class, n), y = n), stat = "identity") + 
  coord_polar(theta = 'y') + 
  expand_limits(y = 70)




