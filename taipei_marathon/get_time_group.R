get_time_group <- function(x) {
  sub_2_half <- 2.5 * 3600
  sub_3_hour <- 3 * 3600
  sub_3_half <- 3.5 * 3600
  sub_4_hour <- 4 * 3600
  if (x < sub_2_half) {
    return("sub 2:30")
  } else if (x < sub_3_hour) {
    return("sub 3:00")
  } else if (x < sub_3_half) {
    return("sub 3:30")
  } else if (x < sub_4_hour) {
    return("sub 4:00")
  } else {
    return("其他")
  }
}

file_path <- "~/datainpoint/taipei_marathon/taipei_marathon.csv"
df <- read.csv(file_path, stringsAsFactors = FALSE)
df$gender <- substr(df$cate, start = 1, stop = 1)
net_time_split <- lapply(strsplit(df$net_time, split = ":"), FUN = as.integer)
net_time_sec <- rep(NA, times = length(net_time_split))
for (i in 1:length(net_time_split)) {
  ttl_sec <- net_time_split[[i]][1] * 3600 + net_time_split[[i]][2] * 60 + net_time_split[[i]][3]
  net_time_sec[i] <- ttl_sec
}

net_time_group <- rep(NA, times = length(net_time_sec))
for (i in 1:length(net_time_sec)) {
  net_time_group[i] <- get_time_group(net_time_sec[i])
}

df$net_time_group <- net_time_group