# serializer_IR_csv <- function(){
#   function(val, req, res, errorHandler){
#     tryCatch({
#       res$setHeader("Content-Type", "text/plain")
#       res$setHeader("Content-Disposition", 'attachment; filename="IR_data.csv"')
#       res$body <- paste0(val, collapse="\n")
#       return(res$toResponse())
#     }, error=function(e){
#       errorHandler(req, res, e)
#     })
#   }
# }
# plumber::addSerializer("csv_IR", serializer_IR_csv)
plumber::plumber$new("plumber-csv.R")$run(port = 8833)

#example web address http://127.0.0.1:8833/IR?AU=OR_SR_1710030602_02_104622&file=bacteria_fresh_contact