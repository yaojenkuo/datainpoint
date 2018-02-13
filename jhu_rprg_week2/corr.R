# corr()
corr <- function(directory, threshold = 0) {
  nobs <- complete(directory)[, "nobs"] # 使用上一題已經定義好的 complete() 函數
  if (threshold > max(nobs)) { # 如果使用者輸入的門檻值超過所有測站的最大完整觀測值
    return(NULL)
  } else {
    df_to_read <- nobs > threshold
    csv_files <- list.files(directory) # 使用內建函數 list.files() 建立出 CSV 檔案路徑
    csv_file_paths <- paste0(directory, csv_files)
    csv_file_paths <- csv_file_paths[df_to_read] # 利用邏輯值選出大於等於門檻的測站
    df_list <- list()
    cr <- vector()
    for (i in 1:length(csv_file_paths)) {
      df_list[[i]] <- read.csv(csv_file_paths[i])
      cr[i] <- cor(df_list[[i]]$nitrate, df_list[[i]]$sulfate, use = "pairwise.complete.obs") # 直接引用 cor() 函數計算相關係數，use 參數設定為 pairwise.complete.obs
    }
    is_na <- is.na(cr)
    cr <- cr[!is_na] # 有九個測站完全都是遺漏值，要將它們的計算結果排除
    return(cr)
  }
}