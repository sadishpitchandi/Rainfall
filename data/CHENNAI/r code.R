getwd()
setwd("C:/Users/sadish/OneDrive/Desktop/work")
Data<-read.csv("dummy.csv")
library(rsconnect)
library(shiny)

ui=shinydashboard::dashboardSidebar( 
  titlePanel("Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("District","District",choices=Data$District),
      selectInput("Station","Station",choices="",selected=""),
      selectInput("Month","Select Month",choices=colnames(Data[,4:15]),selected = ""),
      selectInput("StartDate","Select Start Date",choices = Data$DATE,selected = "1"),
      selectInput("EndDate","Select End Date",choices = Data$DATE,selected = "31"),
      
      ),
    
    mainPanel(
    tableOutput("GivenData"),
    tableOutput("PentaData"),
    tableOutput("Date")
    
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
  
  output$Date<-renderTable({
    Data
  })
    
    
    
  observeEvent(
    input$Month,
    output$PentaData<-renderTable({
      Monthfilter<-subset(Data,colnames(Data[,4:15])==input$Month) 
    })
  )
  
})  
  
shinyApp(ui,server)