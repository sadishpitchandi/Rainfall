getwd()
setwd("C:/Users/DELL/Desktop/work")
Data<-read.csv("itwork.csv")
ef1<-read.csv("dates-1.csv")
ef2<-read.csv("dates-2.csv")
ef3<-read.csv("dates-3.csv")
ef4<-read.csv("dates-4.csv")


library(shiny)

ui=fluidPage( 
  titlePanel("Analysis"),  
  sidebarLayout(
    sidebarPanel(
      selectizeInput("District","District",choices=Data$District),
      selectInput("Station","Station",choices="",selected=""),
      selectInput("Season","Season",choices=c("Winter","Pre-Monsoon","Monsoon","Post-Monsoon"),selected="")
    ),
    
    mainPanel(
      tableOutput("GivenData"),
      tableOutput("SpecifiedSeason")
    ))
  
)

server=shinyServer(function(session,input,output)
{
  
  observeEvent(
    input$District,
    updateSelectInput(session,"Station","Station",
                      choices=Data$Station[Data$District==input$District])
  )
  
  output$GivenData<-renderTable({
    Stationfilter<-subset(Data,Data$Station==input$Station)
  })
df<-reactive(
  Stationfilter<-subset(Data,Data$Station==input$Station)
 )
  df1<-reactive({
  if(input$Season==Winter){
    df1<-cbind(ef1$S1,c(Data$JAN,Data$FEB))
  }else if (input$Season==Pre-Monsoon){
    df1<-cbind(ef2$S2,c(Data$MAR,Data$APR,Data$MAY))
  }else if(input$Season==Monsoon){
    df1<-cbind(ef3$S3,c(Data$JUN,Data$JUL,Data$AUG,Data$SEP))
  }else if(input$Season==Post-Monsoon){
    df1<-cbind(ef4$S4,c(Data$OCT,Data$NOV,Data$DEC))
  }
    return(df1)
} )  

update(
  output
)
})  

shinyApp(ui,server)

