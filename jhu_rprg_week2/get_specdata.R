# get_specdata()
get_specdata <- function(dest_file, ex_dir) {
  specdata_url <- "https://storage.googleapis.com/jhu_rprg/specdata.zip"
  download.file(specdata_url, destfile = dest_file)
  unzip(dest_file, exdir = ex_dir)
}