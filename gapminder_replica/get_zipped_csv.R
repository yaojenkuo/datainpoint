library(RSelenium)

# Define function
get_zipped_csv <- function(x) {
  for (indicator in x) {
    remDr$navigate("https://data.worldbank.org/")
    query_box <- remDr$findElement(using = 'css', "#selector")
    # Keyboard input
    query_box$sendKeysToElement(list(indicator))
    Sys.sleep(5)
    # Keyboard press enter
    query_box$sendKeysToElement(list("\uE007"))
    download_csv <- remDr$findElement(using = 'xpath', "//div[@class='btn-item download']/p/a[1]")
    # Mouse click
    download_csv$clickElement()
  }
}

# Initiate the connection
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444L
                      , browserName = "chrome"
)
remDr$open()
search_indicators <- c("gdp per capita", "life expectancy", "population")
# Call function
get_zipped_csv(search_indicators)
remDr$close()