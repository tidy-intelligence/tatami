#' Context Data Function
#'
#' @export
context_data <- function() {
    # Assign objets via <<- to make them available in global environment
    vars <<- setdiff(names(iris), "Species")
}
