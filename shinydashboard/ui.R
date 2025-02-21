# dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
)

# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
  ) # END sidebarMenu
  
) # END dashboardSidebar

# dashboard body ----
body <- dashboardBody(
  
  # set theme ----
  use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabitem ----
    tabItem(tabName = "welcome",
            
            # left-hand column ----
            column(width = 6,
                   
                   # background info box ----
                   box(width = NULL,
                       
                       title = tagList(icon("clock-rotate-left"), strong("Background Information")),
                       
                       includeMarkdown("text/intro.md"),
                       
                       tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                                alt = "A map of Northern Alaska, showing Fish Creek Watershed located within the National Petroleum Reserve.",
                                style = "max-width: 100%;"),
                       tags$h6("Map Source:", tags$a(href = "http://www.fishcreekwatershed.org/",
                                                     "FCWO"),
                               style = "text-align: center;")
                       
                   ) # END background info box
                   
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 6,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # citation box ----
                     box(width = NULL,
                         
                         title = tagList(icon("table"), strong("Data Source")),
                         
                         includeMarkdown("text/citation.md")
                         
                     ) # END citation box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         title = tagList(icon("triangle-exclamation"),
                                         tags$strong("Disclaimer")),
                         
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ) # END right-hand column
            
    ), # END tabItem
    
    # dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4, # we have 12 columns worth of width to work with on a page
                  
                 title = tags$strong("Adjust lake parameter ranges:"),
                 
                 # Elevation sliderInput ----
                 sliderInput(inputId = "elevation_silder_input",
                             label = "Elevation (meters above sea level)",
                             min = min(lake_data$Elevation),
                             max = max(lake_data$Elevation),
                             value = c(min(lake_data$Elevation),
                                       max(lake_data$Elevation))),
                 
                 # AvgDepth sliderInput ----
                 sliderInput(inputId = "depth_slider_input",
                             label = "Average Depth (meters)",
                             min = min(lake_data$AvgDepth),
                             max = max(lake_data$AvgDepth),
                             value = c(min(lake_data$AvgDepth),
                                       max(lake_data$AvgDepth))),
                 
                 # AvgTemp sliderInput ----
                 sliderInput(inputId = "temp_slider_input",
                             label = "Average Temperature (°C)",
                             min = min(lake_data$AvgTemp),
                             max = max(lake_data$AvgTemp),
                             value = c(min(lake_data$AvgTemp),
                                       max(lake_data$AvgTemp)))
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                  
                  # Leaflet output ----
                  leafletOutput(outputId = "lake_map_output") %>% 
                    withSpinner(type = 1, color = "blue")
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ) # END tabItem
    
  ) # END tabItems
  
) # END dashboard body

# Combine all into dashboardPage ----
dashboardPage(header, sidebar, body)