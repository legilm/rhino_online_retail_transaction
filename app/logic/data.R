# app/logic/data.R
box::use(
  rio[import]
)

#' @export
fetch_data <- function(){
  data <- rio::import("app/data/online_retail_cleaned.csv")
  return(data)
}
