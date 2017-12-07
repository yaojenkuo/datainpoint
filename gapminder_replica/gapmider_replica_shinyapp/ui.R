region_list <- tidy_df$Region %>%
  unique()

# Define UI for application that mimics a Gapminder visualization
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Gapminder Replica"),
  
  # Sidebar with a slider input for year 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("regions",
                         label = "Region:",
                         choices = region_list,
                         selected = region_list
      )
    ),
    
    mainPanel(
      plotlyOutput("bubble")
    )
  )
))