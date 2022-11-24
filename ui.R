# loeading required libraries
library(plotly)
library(shiny)
library(shinydashboard)
library(shinyjs)

# creating the UI logic
ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = "Appsilon Biodiversity"),
                    
                    # creating a dashboard side bar to insert menu itens
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("All Species Observed", tabName = "map",
                                 icon = icon("map-location-dot", lib = "font-awesome")
                        ),
                        menuItem("Species Search", tabName = "speciessearch",
                                 icon = icon("magnifying-glass", lib = "font-awesome")
                        )
                      ),
                      collapsed = FALSE # the sidebar will not collapse when the app initialize
                    ),
                    
                    # dashboard body start
                    dashboardBody(
                      tabItems(
                        
                        # adding a tab to the primary animated map plot and informations box
                        tabItem(tabName = "map",
                                fluidPage(
                                  fluidRow(
                                    
                                    # creating the informations dropdown box
                                    box(title = "Info", status = "primary", solidHeader = TRUE, width = 12,
                                        collapsible = TRUE, collapsed = TRUE,
                                        tabBox(
                                          width = 12,
                                          tabPanel("About this App",
                                                   p("This shiny app aims to provide anyone,
                                              anywhere with an overview of all type of life observed in poland."),
                                                   p("Wih this app you can:"),
                                                   tags$ul(
                                                     tags$li("Visualize on the map species observed over the years"),
                                                     tags$li("Manually search for speacies by vernacular or scientific name on 'Species Search' tab"),
                                                     tags$li("Visualize searched species observed over the years")
                                                   )
                                          ),
                                          tabPanel("How to use the 'Search Species' tab",
                                                   p("The 'Search Species' tab allows you too search for specific species
                                                     and analyse them on the map or see the searched species individual count
                                                     observations over the years."),
                                                   
                                                   tags$ul(
                                                     tags$li("By defaut some speacies are already selected"),
                                                     tags$li("You can reset the selected species clicking the the 'Reset' bottom"),
                                                     tags$li("You can search for a specie using vernacular or scientific name"),
                                                   ),
                                                   
                                                   p("Some important things about the 'Search Species' tab:"),
                                                   tags$ul(
                                                     tags$li("When you click the 'Reset' bottom the charts disapear but
                                                             you just need the search a species on the search box that they will
                                                             show up again"),
                                                     tags$li("You can search between 1 and 10 species at a time")
                                                   )
                                          )
                                        )
                                    )
                                  ),
                                  fluidRow(
                                    # craeting a box to plot the animated map plot
                                    box(status = "primary",
                                        solidHeader = F,
                                        width = 12,
                                        plotlyOutput(outputId = "mapplot_animated")
                                    )
                                  )
                                )
                        ),
                        
                        # creating a tap for species search plots
                        tabItem(tabName = "speciessearch",
                                fluidPage(
                                  fluidPage(
                                    fluidRow(
                                      
                                      # splitting the layout
                                      splitLayout(cellWidths = c("30%", "70%"),
                                                  fluidPage(
                                                    fluidRow(
                                                      useShinyjs(),
                                                      div(id = "form",
                                                          fluidPage(
                                                            selectizeInput(
                                                              inputId = 'search',
                                                              label = paste("Search Species"),
                                                              choices = NULL,
                                                              selected = NULL,
                                                              multiple = TRUE,
                                                              options = list(create = FALSE,
                                                                             placeholder = "Search Species",
                                                                             maxItems = 10
                                                              )
                                                            )
                                                          )
                                                      )
                                                    ),
                                                    fluidRow(
                                                      column(
                                                        12,
                                                        actionButton("reset_input", "Reset Search"),
                                                        align = "left",
                                                        style = "margin-bottom: 10px;",
                                                        style = "margin-top: -10px;"
                                                      )
                                                    )
                                                  ),
                                                  # creating a box to plot map
                                                  fluidPage(
                                                    box(status = "primary",
                                                        solidHeader = F,
                                                        width = 12,
                                                        height = 430,
                                                        plotlyOutput(outputId = "mapplot")
                                                    ),
                                                    # craeting a box to plot scatter plot
                                                    box(status = "primary",
                                                        solidHeader = F,
                                                        width = 12,
                                                        height = 430,
                                                        plotlyOutput(outputId = "scatter")
                                                    )
                                                  )
                                      )
                                    )
                                  )
                                )
                        )
                      )
                    )
)

ui <- ui