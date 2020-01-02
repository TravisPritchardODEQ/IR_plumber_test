#Load data
load("E:/Documents/IR_2018_data/data/IR_data.Rdata")


#' @serializer csv
#' @get /csv
function(spec) {
  df <- data.frame(CHAR = letters, NUM = rnorm(length(letters)), stringsAsFactors = F)
  myData <- subset(df, CHAR == spec)
  csv_file <- tempfile(fileext = ".csv")
  on.exit(unlink(csv_file), add = TRUE)
  write.csv(myData, file = csv_file, row.names = FALSE)
  readLines(csv_file)
}



#' @serializer csv_IR
#' @get /IR
function(AU, file) {
  
  frames <- lapply(file, get)
  df <- do.call(rbind.data.frame, frames)
    #df <- data.frame(CHAR = letters, NUM = rnorm(length(letters)), stringsAsFactors = F)
  myData <- subset(df, AU_ID == AU)
  csv_file <- tempfile(fileext = ".csv")
  on.exit(unlink(csv_file), add = TRUE)
  write.csv(myData, file = csv_file, row.names = FALSE)
  readLines(csv_file)
}



