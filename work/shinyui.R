library(shiny)

ui=(fluidPage(
  titlePanel("INTERNSHIP"),
  sidebarLayout(
    sidebarPanel(
      selectInput("districtnames","select the district",c("chennai","namakkal","kancheepuram","dharmapuri"), selectize = FALSE)
    ),
    mainPanel(
      textOutput("district")
    )
  )
))

server=shinyServer(function(input,output){
  output$district<-renderText(input$districtnames)
})

shinyApp(ui,server) 

