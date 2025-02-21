library(fresh)

create_theme(
  
  adminlte_color(
    light_blue = "darkblue"
  ),
  
  adminlte_global(
    content_bg = "lightpink"
  ),
  
  adminlte_sidebar(
    dark_bg = "lightblue",
    dark_hover_bg = "magenta",
    dark_color = "red",
    width = "400px"
  ),
  
  output_file = "shinydashboard/www/dashboard-fresh-theme.css"
  
  
)