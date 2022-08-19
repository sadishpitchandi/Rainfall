library(shinydashboard)
library(shiny)

getwd()
setwd("C:/Users/sadish/OneDrive/Desktop/work/shiny_Pareto_app-master")
#Data<-read.csv("Failure_pareto.csv")
#Data

ui <-dashboardPage(
  dashboardHeader(title  ="Rainforecasting Analysis Dashboard", titleWidth = 600),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data Loading", tabName = "loadTab", icon = icon("upload")),
      menuItem("Dashboard", tabName = "dashTab",icon = icon("dashboard")),
      menuItem("Summary Stats", tabName = "summaryTab",icon = icon("bar-chart")),
      menuItem("Inspect the Data", tabName = "dataTab",icon = icon("th"))
      
    )# end of sidebarMenu
    
  ),# end of dashboardSidebar
  dashboardBody(
    tabItems(
      
      #Data loading Tab content
      tabItem(tabName = "loadTab",
              h2("Select input dataset:"),
              fileInput(
                "file1","Upload an csv file",accept = ".csv"
              ),
              p("After uploading your CSV file, click on the 'Inspect the Data' tab")
        
      ),# End of Data loading Tab
      
      # Dashboard tab content
      tabItem(tabName = "dashTab",
              h2("Rain forecasting Analysis"),
              h6("(Note: The Pareto plot will be presented once you load a dataset in the 'Data Loading' tab)"),
              tags$hr(),
              p("Pareto analysis is a formal technique useful where many possible courses of action are competing for attention."),
              p("The barplot below may be useful to define which causes should be addressed first."),
              p("Usually a good starting point is the 80/20 Rule that states that most of the results in any situation (80% actually) are determined by a  small number of causes (20% of all the causes)"),

              fluidRow(
                
                box(width = 12, plotOutput("plot1", height = 250))#,

              )# End of fluidRow
        
      ),
      
      # Summary Stats tab content
      tabItem(tabName = "summaryTab",
              h2("Summary Statistics"),
              verbatimTextOutput("summary")
      ),
      # Data tab content
      tabItem(tabName = "dataTab",
              h2("Inspect the data"),
              p("Here is the raw data from the xlsx file"),
              tableOutput('contents')
      )
    )# End of tabItems
    
    
    
  )
)



# check if pkgs are installed already, if not, install automatically:
# (http://stackoverflow.com/a/4090208/1036500)
list.of.packages <- c("shiny",
                      "dplyr",
                      "shinydashboard",
                      "ggplot2",
                      "ggrepel",
                      "readxl",
                      "DT")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# load all packages
lapply(list.of.packages, require, character.only = TRUE)


server <- function(input, output) {
  
  # read in the excel file
  #req(input$file1)
  
  the_data_fn <- reactive({
    
    req(input$file1)
    dat <- read_xlsx(input$file1$datapath,sheet = 1)
    return(dat)
  })# end of reading file
  
  #display a pareto plot
  output$plot1 <- renderPlot({
    dat <- the_data_fn()
    dat <-dat[order(dat$N,decreasing = TRUE),]
    myDf <-data.frame(count = dat$N,failure= dat$failure, stringsAsFactors = FALSE)
    
    
    myDf<- myDf %>% as_tibble() %>% mutate(
      cumulative = cumsum(count),
      freq = round(count / sum(count),3)*100,
      cum_freq = cumsum(freq)
    )
    myDf[dim(myDf)[1],dim(myDf)[2]] <- 100 #force last level
    
    pareto <- ggplot(myDf, aes(x=reorder(failure,-count),y=count)) +
      geom_bar(aes(y=myDf$count), fill='blue', stat="identity") +
      geom_point(aes(y=myDf$cumulative), color = rgb(0, 1, 0), pch=16, size=3) +
      geom_path(aes(y=myDf$cumulative, group=1)) +
      theme(axis.text.x = element_text(size = 12,angle=90, vjust=0.6)) +
      labs(title = "Failure Pareto Plot", 
           subtitle = "Produced by David Arteta", 
           x = 'Failures', y = 'Cumulative Count')
    
    pareto + geom_label_repel(aes(label= myDf$cum_freq, y = myDf$cumulative),
                              box.padding = 0.35,
                              point.padding = 0.5,
                              segment.color = 'grey50')
    
  })# end of renderPlot
  
  # display a table with the cumulative values
  output$summary <-renderPrint({
    dat <- the_data_fn()
    dat <-dat[order(dat$N,decreasing = TRUE),]
    myDf <-data.frame(count = dat$N,failure= dat$failure, stringsAsFactors = FALSE)
    
    myDf<- myDf %>% as_tibble() %>% mutate(
      cumsum = cumsum(count),
      freq = round(count / sum(count),3)*100,
      cum_freq = cumsum(freq)
    )
    myDf[dim(myDf)[1],dim(myDf)[2]] <- 100 #force last level
    return(myDf)
  })# end of renderPrint
  
  # display a table of the file contents
  output$contents <- renderTable({
    
    the_data_fn()
    
  })# End of renderTable
  
}
shinyApp(ui = ui, server = server)