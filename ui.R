library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Delta Method"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("samples",
                  "Number of Samples:",
                  min=200,
                  max=1500,
                  value=1000),
      
      sliderInput("Prob",
                  "Probability:",
                  min=0.1,
                  max=0.9,
                  value=0.5)
    ),
    
      sliderInput("bins",
                "Binwidth:",
                min=0.1,
                max=0.9,
                value=0.5)
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))