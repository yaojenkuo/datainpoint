# rankall()
rankall <- function(outcome, num = "best") {
  library(dplyr)
  library(magrittr)
  
  file_path <- "~/hospital_data/outcome-of-care-measures.csv"
  outcome_of_care_measures <- read.csv(file_path, stringsAsFactors = FALSE)
  outcome_col_idx <- c(11, 17, 23)
  for (i in outcome_col_idx) {
    outcome_of_care_measures[, i] <- suppressWarnings(as.numeric(outcome_of_care_measures[, i]))
  }
  outcome_inputs <- c("heart attack", "heart failure", "pneumonia")
  names(outcome_of_care_measures)[outcome_col_idx] <- outcome_inputs
  unique_state_names <- outcome_of_care_measures$State %>% 
    unique() %>%
    sort() # 州名排序
  hospital <- vector()
  for (state in unique_state_names) {
    state_df <- outcome_of_care_measures %>%
      filter(State == state)
    nrow_state_df <- nrow(state_df) # 該州的醫院個數
    if (num == "best") {
      df <- state_df %>%
        arrange(get(outcome), Hospital.Name)
      ans <- df[, "Hospital.Name"][1] # 最好的醫院，回傳字母排序前面的醫院
      hospital <- c(hospital, ans) # 加入向量中
    } else if (num == "worst") {
      df <- state_df %>%
        arrange(desc(get(outcome)), Hospital.Name)
      ans <- df[, "Hospital.Name"][1] # 最差的醫院，回傳字母排序前面的醫院
      hospital <- c(hospital, ans) # 加入向量中
    } else if (num > nrow_state_df) {
      hospital <- c(hospital, NA) # 有的州醫院個數不足 num 參數的輸入，就要回傳 NA
    } else {
      df <- state_df %>%
        arrange(get(outcome), Hospital.Name)
      ans <- df[, "Hospital.Name"][num] # 排名第 num 的醫院，回傳字母排序前面的醫院
      hospital <- c(hospital, ans) # 加入向量中
    }
  }
  return_df <- data.frame(hospital, state = unique_state_names, row.names = unique_state_names)
  return(return_df)
}