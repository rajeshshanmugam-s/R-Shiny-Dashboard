options(repos = c(CRAN = "https://cran.rstudio.com/")) 

# Load libraries ---------------------------------------------------------------
library(shiny)
library(shinythemes)

# Plot libraries for outputs
library(rCharts)
library(leaflet)
library(DT)
library(plotly)

# Adjustments
h3.align <- 'center'

# Shiny UI ---------------------------------------------------------------------
shinyUI(navbarPage(
        title = "",
        # Pick a bootstrap theme from https://rstudio.github.io/shinythemes/
        theme = shinytheme("flatly"),
        
        # Analytics tab panel --------------------------------------------------        
        tabPanel(
                title = "",
                
                # 
                sidebarPanel(width=3,
                        h3("Reactive Inputs", align = h3.align),
                        h6("Make selections and watch the graphs and data update", align="center"),
                        uiOutput("yearSlider"),
                        uiOutput("unitPriceSlider"),
                        uiOutput("cat1Controls"),
                        uiOutput("cat2Controls"),
                        p(actionButton(inputId = "reset", 
                                     label = "Reset Fields", 
                                     icon = icon("refresh")
                        ), align = "center")
                        ),
                            
                mainPanel(
                        tabsetPanel(
                                    
                        # Analysis Tab -----------------------------------------
                        tabPanel(
                                p(icon("area-chart"), "Analysis"),
                                
                                # Sales Over Time By Category
                                fluidRow(h3("Categorical Bicycle Sales Over Time", align=h3.align)),
                                fluidRow(
                                        column(6, h4("rCharts: View Sales By Primary Bike Category", align="center"), 
                                               p(showOutput("primaryBikeCatOut", "nvd3"), align="center"))
                                        ,
                                        column(8, h4("rCharts: View Sales By Secondary Bike Category", align="center"),
                                               p(showOutput("secondaryBikeCatOut", "nvd3"), align = "center"))
                                        ),
                                
                                # Sales By Geography
                                fluidRow(h3("Geographical Bicycle Sales", align=h3.align)),
                                fluidRow(
                                        column(5, h4("Leaflet: Visualize Customers By Location", align="center"),
                                               h6("Each customer is represented by a point. Click to view sales information.", align="center"),
                                               leafletOutput("salesByLocOut"))
                                        ),
                                
                                # Detailed Information
                                fluidRow(h3("Detailed Information", align=h3.align)),
                                fluidRow(
                                        column(6,
                                               h4("ggPlotly: Visualize How Unit Price Relates to Sales", align="center"),
                                               h6("Select measure of sales total or quantity sold. Hover over points to see details.", align="center"),
                                               uiOutput("salesVsQtySelector"),
                                               plotlyOutput("salesByUnitPriceOut", height=675))
                                )),  # End Analysis Tab
                        
                        # Data Tab ---------------------------------------------
                        tabPanel(
                                p(icon("table"), "Data"),
                                
                                fluidRow(
                                        column(6, h3("Search, Filter & Download Data", align='left')),
                                        column(6, downloadButton('downloadData', 'Download', class="pull-right"))
                                         
                                ),
                                hr(),
                                fluidRow(
                                        dataTableOutput(outputId="table")
                                         
                                )) # End Data Tab
                        ),
                        
                        tags$style(type = 'text/css', '.navbar { display:none }', '.tab-content { margin-top: 30px; } '),
                )
        ) # End Analytics Tab Panel
        
        # About Tab Panel ------------------------------------------------------           
        #tabPanel("Supporting Docs",
        #        mainPanel(column(8, offset = 2, includeMarkdown("about.md"))
        #        )
        #) # End About Tab Panel
        
        ) # End navbarPage
        ) # End shinyUI