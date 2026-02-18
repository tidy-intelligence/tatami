#' Get Configuration
#'
#' Reads the application configuration from a YAML file. Uses the
#' `R_CONFIG_ACTIVE` environment variable to determine which configuration
#' profile to load (defaults to `"default"`).
#'
#' @param file Path to the configuration file.
#'
#' @return A list of configuration values for the active profile.
#'
#' @export
get_config <- function(file = "inst/config.yml") {
    config::get(file = file)
}
