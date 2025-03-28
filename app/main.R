# app/main.R

box::use(
  app/view/sidebar,
   app/logic/data
)

box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput],
  bslib[bs_theme],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  bootstrapPage(
    sidebar$ui("sidebar")
  )
}

#' @export
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    sidebar$server("sidebar")
  })
}
