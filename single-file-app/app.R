# Load packages ----
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(bslib)

# User interface ----
ui <- fluidPage(
  
#  theme = bs_theme(bootswatch = "solar"),
  
  theme = bs_theme(
    bg = "#A36F6F",
    fg = "#FDF7F7",
    primary = "#483132",
    base_font = font_google("Pacifico")
  ),
  
  # App title ----
  tags$h1("My App Title"),
  
  # App subtitle ----
  tags$h4(tags$strong("Exploring Antartic Penguin Data")),
  h4(strong("Exploring Antartic Penguin Data")),
  
  # Body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700,
              max = 6300,
              value = c(3000, 4000)),
  
  # Body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # Year check box input ----
  checkboxGroupInput(inputId = "year_input",
                    label = "Select year(s):",
                    choices = c(2007, 2008, 2009), # unique(penguins$year)
                    selected = c(2007, 2008)
                    ),
  
  # DT output ----
  DT::dataTableOutput(outputId = "penguin_DT_output")
  
)

# Server ----
server <- function(input, output){
  
  # Render penguin scatter plot ----
  output$body_mass_scatterplot_output <- renderPlot({
    
    # Filter body masses ----
    body_mass_df <- reactive({
      
      penguins %>%
        filter(body_mass_g %in% c(input$body_mass_input[1]: input$body_mass_input[2]))
      
    })
    
    # Code to generate our plot
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
  })
  
  # render the DT::datatable ----
  output$penguin_DT_output <- renderDataTable({
    
    # Filter to selected years ----
    years_df <- reactive({
      penguins %>% 
        filter(year %in% c(input$year_input))
    })
    
    # Code to generate table
    DT::datatable(years_df()) 
    
  })
}

# Combine our UI and server into an app ----
shinyApp(ui = ui, server = server)


