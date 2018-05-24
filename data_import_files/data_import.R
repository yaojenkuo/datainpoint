# read.csv() 使用預設參數
csv_url <- "https://storage.googleapis.com/ds_data_import/chicago_bulls_1995_1996.csv"
csv_df <- read.csv(csv_url)
View(csv_df)

# read.csv() 自行指定變數的名稱
csv_url <- "https://storage.googleapis.com/ds_data_import/chicago_bulls_1995_1996.csv"
csv_df <- read.csv(csv_url, skip = 1, header = FALSE, col.names = c('number', 'player', 'pos', 'ht', 'wt', 'birth_date', 'college'))
View(csv_df)

# read.table() 指定 sep = ";"
txt_url <- "https://storage.googleapis.com/ds_data_import/chicago_bulls_1995_1996.txt"
txt_df <- read.table(txt_url, sep = ";", header = TRUE)
View(txt_df)

# readxl::read_excel() 函數使用預設參數
if (!require(readxl)) {
  install.packages("readxl")
  library(readxl)
}

xlsx_url <- "https://storage.googleapis.com/ds_data_import/fav_nba_teams.xlsx"
dest_file <- "~/Desktop/fav_nab_teams.xlsx"
download.file(xlsx_url, destfile = dest_file)
chicago_bulls <- read_excel(dest_file)
View(chicago_bulls)


# readxl::read_excel() 函數指定工作表與讀取範圍
if (!require(readxl)) {
  install.packages("readxl")
  library(readxl)
}

xlsx_url <- "https://storage.googleapis.com/ds_data_import/fav_nba_teams.xlsx"
dest_file <- "~/Desktop/fav_nab_teams.xlsx"
download.file(xlsx_url, destfile = dest_file)
boston_celtics <- read_excel(dest_file, sheet = "boston_celtics_2007_2008", range = "A7:C16", col_names = c("number", "player", "pos"))
View(boston_celtics)

# jsonlite::fromJSON() 函數載入 JSON 檔案
if (!require(jsonlite)) {
  install.packages("jsonlite")
  library(jsonlite)
}

json_url <- "https://storage.googleapis.com/ds_data_import/chicago_bulls_1995_1996.json"
chicago_bulls_list <- fromJSON(json_url)
chicago_bulls_list

# 計算勝率或者從先發陣容中選出最喜歡的球員
winning_rate <- chicago_bulls_list$records$wins / (chicago_bulls_list$records$wins + chicago_bulls_list$records$losses)
fav_player <- chicago_bulls_list$starting_lineups$SG
sprintf("勝率為 %.2f", winning_rate)
sprintf("最喜歡的球員是 %s", fav_player)