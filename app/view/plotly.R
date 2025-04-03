# app/view/plotly.R

box::use(
  app/logic/data[fetch_data],
  app/view/sidebar[dates]
)

box::use(
  shiny[NS, moduleServer, observeEvent],
  bslib[card_header, card],
  dplyr[arrange, group_by, summarize, filter],
  plotly[renderPlotly, plot_ly, layout, plotlyOutput]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  card(
  card_header("Plotly"),
  plotlyOutput(ns(("plotly"))
  ))
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session){
    
    # Plotly - Sales Trends
    observeEvent(input$dates, {
      data <- fetch_data() |>
        arrange(InvoiceDate) |>
        group_by(InvoiceDate) |>
        summarize(Revenue = sum(Revenue)) #|> 
        filter(InvoiceDate >= input$dates[1] & InvoiceDate <= input$dates[2])
      output$plotly <- renderPlotly({
      plot_ly(data,
              x = ~InvoiceDate,
              y = ~Revenue,
              type = "scatter",
              mode = "lines",
              hovertemplate = "Date: %{x}<br>Revenue: %{y:.2f}") |>
        layout(
          title = list(text = "Revenue over Time"),
          xaxis = list(title = "Invoice Date", type = "date", rangeslider = list(visible = FALSE)),
          yaxis = list(title = "Revenue"),
          hovermode = "x unified"
        )
      })
    })
  })
}