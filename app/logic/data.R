# app/logic/data.R
library(rio)

#' @export
fetch_data <- function(){
  data <- rio::import("app/data/online_retail_cleaned.csv")
  return(data)
}
