library(tidyr)
library(magrittr)
library(dplyr)

get_tidy_df <- function(x) {
  setwd(x)
  ex_dir <- paste0(x, "/world_bank_csv")
  zipfiles <- c("API_NY.GDP.PCAP.CD_DS2_en_csv_v2.zip", "API_SP.DYN.LE00.IN_DS2_en_csv_v2.zip", "API_SP.POP.TOTL_DS2_en_csv_v2.zip")
  for (zipfile in zipfiles) {
    unzip(zipfile, exdir = ex_dir)
  }
  
  setwd(ex_dir)
  csv_list <- list()
  csv_files <- c("API_NY.GDP.PCAP.CD_DS2_en_csv_v2.csv", "API_SP.DYN.LE00.IN_DS2_en_csv_v2.csv", "API_SP.POP.TOTL_DS2_en_csv_v2.csv")
  year_cols <- paste0("X", 1960:2015)
  for (i in 1:length(csv_files)) {
    df <- read.csv(csv_files[i], skip = 4L, stringsAsFactors = FALSE)
    csv_list[[i]] <- df[, c("Country.Name", "Country.Code", year_cols)]
  }
  region_csv <- read.csv("Metadata_Country_API_SP.POP.TOTL_DS2_en_csv_v2.csv", stringsAsFactors = FALSE)
  csv_list[[4]] <- region_csv[, c("Country.Code", "Region", "TableName")]
  
  indicators <- c("gdpPercap", "lifeExp", "pop")
  for (i in 1:3) {
    csv_list[[i]] <- gather(csv_list[[i]], key = "year", value = "indicator", X1960:X2015)
    names(csv_list[[i]])[4] <- indicators[i]
    csv_list[[i]]$year <- csv_list[[i]]$year %>%
      gsub(pattern = "X", , replacement = "") %>%
      as.integer
  }
  
  merge_on_cols <- names(csv_list[[1]])[1:3]
  tidy_df <- csv_list[[1]] %>%
    merge(csv_list[[2]], by = merge_on_cols) %>%
    merge(csv_list[[3]], by = merge_on_cols) %>%
    merge(csv_list[[4]], by.x = c("Country.Name", "Country.Code"), by.y = c("TableName", "Country.Code")) %>%
    arrange(Country.Name, year) %>%
    filter(Region != "")
  
  return(tidy_df)
}