#' Run App
#'
#' Run application
#'
#' @param ... Additional parameters to pass to [quarto::quarto_serve].
#'
#' @export
run_app <- function(production = FALSE, ...) {
	if (production) {
		Sys.setenv("R_CONFIG_ACTIVE" = "production")
	} else {
		Sys.setenv("R_CONFIG_ACTIVE" = "default")
	}
	quarto::quarto_serve("index.qmd", ...)
}
