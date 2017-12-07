# global.R template for Plotly/Shiny apps

library(plotly)
library(shiny)
library(magrittr)
library(dplyr)

py <- plot_ly(username="rAPI", key="yu680v5eii")
tidy_df <- read.csv("data/tidy_df.csv", stringsAsFactors = FALSE)
bubble_radius <- sqrt(tidy_df$pop / pi)

source("plotlyGraphWidget.R")