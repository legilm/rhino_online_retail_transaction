# app/view/sidebar.R

box::use(
  app/logic/data[fetch_data]
)

box::use(
  shiny[tagList, NS, div, h3, p, dateRangeInput,hr,verbatimTextOutput, selectInput, downloadButton],
  shinyFeedback[loadingButton, ]
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
                       min = min(fetch_data()$InvoiceDate),
                       max = max(fetch_data()$InvoiceDate)),
        hr(),
        verbatimTextOutput(ns("date_range_selected")),
        
        selectInput(ns("country_filter"), 
                    "Select Country",
                    choices = c("All", unique(fetch_data()$Country)),
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

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session){
    ns <- NS(id)

weather <- eventReactive(input$filter_button, {
  if (input$country_filter == "All") {
    return(fetch_data())
  } else {
    return(fetch_data() |> 
             filter(Country == input$country_filter))
  }
})



# Filter data based on selected country
filtered_data <- eventReactive(input$filter_button, {
  if (input$country_filter == "All") {
    return(fetch_data())
  } else {
    return(fetch_data() |> 
             filter(Country == input$country_filter))
  }
})

# You can access the values of the widget (as a vector of Dates)
# with input$dates, e.g.
output$date_range_selected <- renderPrint({ input$dates })

observeEvent(input$filter_button, {
  
  #  data <- filtered_data()
  
  resetLoadingButton("filter_button")
})

output$download_btn <- downloadHandler(
  filename = function() {
    paste0(input$country_to_download, " - ", Sys.Date(), " - Sales data", ".csv")  # File name based on selection
  },
  content = function(file) {
    
    # Filter data based on user selection
    data_to_download <- fetch_data() |> 
      filter(Country == input$country_to_download)
    
    # Save the filtered data in the output file
    rio::export(data_to_download, file, "csv")
  })
  })
}