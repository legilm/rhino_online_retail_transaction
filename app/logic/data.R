# app/logic/data.R
library(rio)

fetch_data <- function(){
  data <- rio::import("app/data/online_retail_cleaned.csv")
  return(data)
}

test <- fetch_data()

print(test)