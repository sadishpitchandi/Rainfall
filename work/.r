getwd()
df<-read.csv("Nungambakkam.csv",header = TRUE,sep = ",")
df
season1=c(df$JAN,df$FEB)
season2=c(df$MAR,df$APR,df$MAY)
season3=c(df$JUN,df$JUL,df$AUG,df$SEP)
season4=c(df$OCT,df$NOV,df$DEC)
season1
season2
season3
season4
df<-read.csv("Saidapet.csv",header = TRUE,sep = ",")
df
season1=c(df$JAN,df$FEB)
season2=c(df$MAR,df$APR,df$MAY)
season3=c(df$JUN,df$JUL,df$AUG,df$SEP)
season4=c(df$OCT,df$NOV,df$DEC)
season1
season2
season3
season4