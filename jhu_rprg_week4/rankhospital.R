# rankhospital()
rankhospital <- function(state, outcome, num = "best") {
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
  unique_state_names <- unique(outcome_of_care_measures$State)
  if (!(state %in% unique_state_names)) {
    stop("invalid state") # 錯誤州名
  } else if (!(outcome %in% outcome_inputs)) {
    stop("invalid outcome") # 錯誤 outcome
  } else {
    state_df <- outcome_of_care_measures %>%
      filter(State == state)
    nrow_state_df <- nrow(state_df) # 該州的醫院個數
    if (num == "best") {
      df <- state_df %>%
        arrange(get(outcome), Hospital.Name)
      ans <- df[, "Hospital.Name"][1] # 最好的醫院，回傳字母排序前面的醫院
      return(ans)
    } else if (num == "worst") {
      df <- state_df %>%
        arrange(desc(get(outcome)), Hospital.Name)
      ans <- df[, "Hospital.Name"][1] # 最差的醫院，回傳字母排序前面的醫院
      return(ans)
    } else if (num > nrow_state_df) {
      return(NA)
    } else {
      df <- state_df %>%
        arrange(get(outcome), Hospital.Name)
      ans <- df[, "Hospital.Name"][num] # 排名第 num 的醫院，回傳字母排序前面的醫院
      return(ans)
    }
  }
}