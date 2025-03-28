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
    sidebar$ui(ns("sidebar"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # output$message <- renderUI({
    #   div(
    #     style = "display: flex; justify-content: center; align-items: center; height: 100vh;",
    #     tags$h1(
    #       tags$a("Check out Rhino docs!", href = "https://appsilon.github.io/rhino/")
    #     )
    #   )
    # })
  })
}
