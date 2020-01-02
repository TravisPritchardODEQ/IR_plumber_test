# plumber.R

#' Echo the parameter that was sent in
#' @param msg The message to echo back.
#' @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @get /plot
#' @html
function(spec){
  myData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }
  
  
   htmlTable::htmlTable(myData, rnames = FALSE)
}

#' @get /iris_csv
function(res) {
  con <- textConnection("val","w")
  write.csv(iris, con)
  close(con)
  
  res$body <- paste(val, collapse="\n")
  res
}


# create a GET request for MLB shareprices (in CSV format)
#' @get /iris_test
csvSPs <- function(spec, res){
  myData <- subset(iris, Species == spec)
  tmp <- tempfile(fileext=".rds")
  saveRDS(myData, tmp)
  
  # This header is a convention that instructs browsers to present the response
  # as a download named "mydata.Rds" rather than trying to render it inline.
  res$setHeader("Content-Disposition", "attachment; filename=mydata.Rds")
  
  # Read in the raw contents of the binary file
  bin <- readBin(tmp, "raw", n=file.info(tmp)$size)
  
  # Delete the temp file
  file.remove(tmp)
  
  # Return the binary contents
  bin
  
  
}


#* Download a binary file.
#* @serializer contentType list(type="application/octet-stream")
#' @get /download-binary
function(res){
  # TODO: Stream the data into the response rather than loading it all in memory
  # first.
  
  # Create a temporary example RDS file
  x <- list(a=123, b="hi!")
  tmp <- tempfile(fileext=".rds")
  saveRDS(x, tmp)
  
  # This header is a convention that instructs browsers to present the response
  # as a download named "mydata.Rds" rather than trying to render it inline.
  res$setHeader("Content-Disposition", "attachment; filename=mydata.Rds")
  
  # Read in the raw contents of the binary file
  bin <- readBin(tmp, "raw", n=file.info(tmp)$size)
  
  # Delete the temp file
  file.remove(tmp)
  
  # Return the binary contents
  bin
}
