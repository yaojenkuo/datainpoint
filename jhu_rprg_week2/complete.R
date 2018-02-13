# complete()
complete <- function(directory, id = 1:332) {
  csv_files <- list.files(directory) # 使用內建函數 list.files() 建立出 CSV 檔案路徑
  csv_file_paths <- paste0(directory, csv_files)
  csv_file_paths <- csv_file_paths[id] # 依照輸入的 id 參數選擇性讀入
  df_list <- list()
  nobs <- vector()
  for (i in 1:length(csv_file_paths)) {
    df_list[[i]] <- read.csv(csv_file_paths[i])
    is_complete <- complete.cases(df_list[[i]]) # 直接引用 complete.cases() 函數
    nobs <- c(nobs, sum(is_complete)) # 將邏輯值向量加總就能得知有幾個完整觀測值
  }
  nobs_df <- data.frame(id, nobs)
  return(nobs_df)
}