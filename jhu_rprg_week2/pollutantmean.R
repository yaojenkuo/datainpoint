# pollutantmean()
pollutantmean <- function(directory, pollutant, id = 1:332) {
  csv_files <- list.files(directory) # 使用內建函數 list.files() 建立出 CSV 檔案路徑
  csv_file_paths <- paste0(directory, csv_files)
  csv_file_paths <- csv_file_paths[id] # 依照輸入的 id 參數選擇性讀入
  df_list <- list()
  pollutant_vector <- vector()
  for (i in 1:length(csv_file_paths)) {
    df_list[[i]] <- read.csv(csv_file_paths[i])
    pollutant_vector <- c(pollutant_vector, df_list[[i]][, pollutant]) # 將讀入測站的污染物資料合併起來
  }
  pollutant_mean <- mean(pollutant_vector, na.rm = TRUE) # 記得將 na.rm 參數設為 TRUE
  return(pollutant_mean)
}