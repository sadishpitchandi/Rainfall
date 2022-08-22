getwd()
setwd("C:/Users/sadish/OneDrive/Desktop/work")
ef1<-read.csv("dates-1.csv")
ef2<-read.csv("dates-2.csv")
ef3<-read.csv("dates-3.csv")
ef4<-read.csv("dates-4.csv")
setwd("C:/Users/sadish/OneDrive/Desktop/work/CHENNAI")
list.files()
df<-read.csv("CH_NUNGAMBAKKAM.csv")
A=c(df$JAN,df$FEB)
B=c(df$MAR,df$APR,df$MAY)
C=c(df$JUN,df$JUL,df$AUG,df$SEP)
D=c(df$OCT,df$NOV,df$DEC)
S1=cbind(ef1$S1,c(df$JAN,df$FEB))
S2=cbind(ef2$S2,c(df$MAR,df$APR,df$MAY))
S3=cbind(ef3$S3,c(df$JUN,df$JUL,df$AUG,df$SEP))
S4=cbind(ef4$S4,c(df$OCT,df$NOV,df$DEC))

PTA=C[48]-C[43]

# check the season 2 (mar,apr,may= premonsoon) and season 4 (oct,nov,dec = Post monsoon)
x1<-B
y1<-D
plot(x1,(y1))

ggplot(peryear %>% aes(x=B,y=cumsum(D))) + geom_point()+geom_line()
ggplot(peryear %>% filter(places=="out"),aes(x=B,y=cumsum(count))) + geom_point()+geom_line()



df
x1
y1
library(ggplot2)
y=ggplot(df, aes(x=x1, y=cumsum(y1))) + geom_line() + geom_point()
y



df
df[jan]

s=df$DATE
s
o=s[5:8]
0
setwd("C:/Users/sadish/OneDrive/Desktop/work")
setwd("C:/Users/sadish/OneDrive/Desktop/work/NAMMAKKAL")

df<-read.csv("NAM_RASIPURAM.csv")
df
s=c(df$JAN,df$FEB)
s
s1 <- na.omit(s)
s1
X1<-ts(s1)
#install.packages("tseries")
library(tseries)
adf.test(X1)
plot(X1)
acf(X1)
pacf(X1)

##one way anova test
##H0=same percent of rainfall over month (jan,mar)
##h1: rainfall differ  over month (jan, mar) 

setwd("C:/Users/sadish/OneDrive/Desktop/work/CHENNAI")
df<-read.csv("CH_NUNGAMBAKKAM.csv")

df
rainfall=data.frame(cbind(df$JanMariginal,df$febMariginal))
rainfall
summary(rainfall)
anova=aov(X1~X2,data=rainfall)
summary(anova)
