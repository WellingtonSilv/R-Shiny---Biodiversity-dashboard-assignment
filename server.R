library(plotly)
library(data.table)
library(dplyr)
library(shiny)
library(cli)

source("mapplot.R")
source('mapplot_animated.R')
source("scatter.R")

species_df <- fread("species_df.csv")

# creating the server logic
server <- function(input, output,session){
  
  # updating the search
  updateSelectizeInput(session, 'search',
                       choices = c(species_df$vernacularName,species_df$scientificName),
                       selected = c("Eurasian Badger","Large Redeye","Eurasian Jay",
                                    "Eurasian Wren","Eurasian Otter"),
                       server = TRUE)
  
  # reseting the selected species on 'search species' box
  observeEvent(input$reset_input, {
    shinyjs::reset("form")
  })

  # eventReactive object to react with species selected on search box
  # and plot the selected species on a map
  mapplot_reactive <- eventReactive(input$search
                                  ,{
                                    mapplot(data = species_df, inputs = input$search)
                                  })
  # eventReactive object to react with species selected on search box
  # and plot the scatter plot visualizing the species observations over the years
  scatter_reactive <- eventReactive(input$search
                                    ,{
                                      scatter(data = species_df, inputs = input$search)
                                    })
  
  # Plotting animated map with all species observed over the years
  output$mapplot_animated <- renderPlotly({
    mapplot_animated(data = species_df)
  })
  
  # Plotting static map plot on search species tab
  output$mapplot <- renderPlotly({
    mapplot_reactive()
  })
  
  # Plotting scatter plot on search species tab
  output$scatter <- renderPlotly({
    scatter_reactive()
  })
  
}