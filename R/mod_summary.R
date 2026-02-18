#' Summary Output Function
#'
#' Creates output placeholders for the summary module.
#'
#' @param id Output element ID. One of `"summary_stats"` or `"summary_table"`.
#' @param output Shiny output object.
#'
#' @export
summary_output <- function(id, output) {
    switch(
        id,
        "summary_stats" = verbatimTextOutput(id),
        "summary_table" = tableOutput(id),
        stop("Invalid output type specified: ", id)
    )
}

#' Summary Server Function
#'
#' Server logic for the summary module. Computes descriptive statistics for the
#' selected variables.
#'
#' @param input Shiny input object.
#' @param output Shiny output object.
#'
#' @export
summary_server <- function(input, output) {
    selected_data <- reactive({
        iris[, c(input$xcol, input$ycol)]
    })

    output$summary_stats <- renderPrint({
        summary(selected_data())
    })

    output$summary_table <- renderTable({
        data <- selected_data()
        data.frame(
            Variable = names(data),
            Mean = round(sapply(data, mean), 2),
            SD = round(sapply(data, sd), 2),
            Min = sapply(data, min),
            Max = sapply(data, max)
        )
    }, striped = TRUE)
}
