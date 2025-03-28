# app/view/sidebar.R

box::use(
  shiny[tagList, NS, div, h3, p]
)

# Define the UI of the sidebar
#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(
      class = "sidebar",
      div(
        class = "sidebar-header",
        h3("Online retail data")
      ),
      div(
        class = "sidebar-content",
        dateRangeInput(ns("dates"), 
                       label = h3("Date range"), 
                       min = min(retail_data$InvoiceDate),
                       max = max(retail_data$InvoiceDate)),
        hr(),
        verbatimTextOutput(ns("date_range_selected")),
        
        selectInput(ns("country_filter"), 
                    "Select Country",
                    choices = c("All", unique(retail_data$Country)),
                    multiple = FALSE,
                    selected = "All"),
        
        loadingButton(
          ns("filter_button"),
          "Filter",
          class = "btn btn-primary",
          style = "width: 150px;",
          loadingLabel = "Loading...",
          loadingSpinner = "spinner"
        ),
        
        p("Choose a country to download the sales file."),
        
        selectInput(ns("country_to_download"), "Country to Download", 
                    c("United Kingdom", "France", "USA", "Belgium", "Australia", "EIRE", "Germany", "Portugal", "Japan", "Denmark", "Netherlands", "Poland", "Spain", "Channel Islands", "Italy", "Cyprus", "Greece", "Norway", "Austria", "Sweden", "United Arab Emirates", "Finland", "Switzerland", "Unspecified", "Nigeria", "Malta", "RSA", "Singapore", "Bahrain", "Thailand", "Israel", "Lithuania", "West Indies", "Korea", "Brazil", "Canada", "Iceland", "Lebanon", "Saudi Arabia", "Czech Republic", "European Community")),
        
        downloadButton(ns("download_btn"), "Download")
      )
    )
  )
}


