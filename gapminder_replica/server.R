# Define server logic required to draw a Gapminder visualization
shinyServer(function(input, output) {
  
  tidy_data <- reactive(
    tidy_df %>%
      filter(Region %in% input$regions)
  )
  output$bubble <- renderPlotly({
    
    # draw the bubble chart with the specified continents or year
    tidy_data() %>%
      plot_ly(x = ~gdpPercap, y = ~lifeExp, size = ~pop, type = "scatter", mode = "markers", frame = ~year, color = ~Region, text = ~Country.Name, hoverinfo = "text", sizes = c(min(bubble_radius, na.rm = TRUE), max(bubble_radius, na.rm = TRUE))) %>%
      layout(xaxis = list(title = "GDP Per Capita", 
                          type = "log"),
             yaxis = list(title = "Life Expectancy"))
  })
})