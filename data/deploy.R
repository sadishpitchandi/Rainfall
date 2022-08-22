getwd()
setwd("C:/Users/sadish/OneDrive/Desktop/work")
Data<-read.csv("dummy.csv")

library(shiny)

ui=(fluidPage( 
  titlePanel("Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("District","District",choices=Data$District),
      selectInput("Station","Station",choices="",selected=""),
    ),
    
    mainPanel(
      tableOutput("GivenData")
    ))
  
))

server=shinyServer(function(session,input,output)
{
  
  observeEvent(
    input$District,
    updateSelectInput(session,"Station","Station",
                      choices=data$Station[data$District==input$District])
  )
  output$GivenData<-renderTable({
    Stationfilter<-subset(Data,Data$Station==input$Station)
  })
  
})  

shinyApp(ui,server)

