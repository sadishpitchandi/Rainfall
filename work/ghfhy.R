library(shiny)
set.seed(121)
mydate=seq(Sys.Date(),by="day",length.out=30)
mystatus=sample(c("completed","cancelled"),30,replace=TRUE)
mydf=data.frame(date=mydate,status=mystatus)
mydate
mystatus
mydf

ui<-fluidPage(
  h5("R shiny demo-daterangeInput"),
  hr(),
  dateRangeInput(
    inputId="datarange",
    label="select the data range",
    start=min(mydf$date),
    end=max(mydf$date),
    format="yyyy/mm/dd",
    separator="-"
  ),
  textOutput("startdate"),
  textOutput("enddate"),
  textOutput("range"),
  tableOutput("subdata"),
  
  
)
server<-function(input,output,session){
  output$startdate<-renderText({
    as.character(input$daterange[1])
  })
  output$enddate<-renderText({
    as.character(input$daterange[2])
  })
  output$range<-renderText({
   paste("selected date range is",input$daterange[1],"to",input$daterange[2])
  })
  output$subdata<-renderTable({
    s=subset(mydf,mydf$date>=input$daterange[1]&mydf$date<input$daterange[2])
    table(s$status)
    
  })
}


shinyApp(ui,server)



