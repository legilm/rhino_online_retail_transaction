# app/main.R

box::use(
  app/view/sidebar,
  app/view/plotly,
  app/logic/data,
)

box::use(
  shiny[p, mainPanel, sidebarLayout, div, moduleServer, NS, renderUI, tags, uiOutput],
  bslib[bs_theme, page_sidebar, card],
  shinyFeedback[useShinyFeedback],
  plotly[renderPlotly, plot_ly, layout, plotlyOutput],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  page_sidebar(
    useShinyFeedback(),
    title = "Online retail data",
    sidebar = sidebar$ui(ns("sidebar")),
    card(plotly$ui(ns("plotly")))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    sidebar$server("sidebar")
    plotly$server("plotly")
  })
}

