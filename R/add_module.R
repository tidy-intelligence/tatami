#' Add a Module
#'
#' Generates template files for a new tatami module, including the module R file
#' with input, output, and server functions, and a corresponding test file.
#'
#' @param name Name of the module (e.g., `"chart"`). Used to name the file and
#'   the generated functions (`chart_input`, `chart_output`, `chart_server`).
#' @param path Path to the tatami app root directory.
#'
#' @return The module name (invisibly).
#'
#' @export
add_module <- function(name, path = ".") {
    path <- normalizePath(path, mustWork = FALSE)
    r_dir <- file.path(path, "R")
    test_dir <- file.path(path, "tests", "testthat")

    if (!dir.exists(r_dir)) {
        stop("Directory does not exist: ", r_dir, ". Is this a tatami app?",
             call. = FALSE)
    }

    mod_file <- file.path(r_dir, paste0("mod_", name, ".R"))
    if (file.exists(mod_file)) {
        stop("Module file already exists: ", mod_file, call. = FALSE)
    }

    writeLines(module_r_template(name), mod_file)
    message("Module file created: ", mod_file)

    if (dir.exists(test_dir)) {
        test_file <- file.path(test_dir, paste0("test-mod_", name, ".R"))
        writeLines(module_test_template(name), test_file)
        message("Test file created: ", test_file)
    }

    invisible(name)
}

module_r_template <- function(name) {
    c(
        paste0("#' ", tools::toTitleCase(name), " Input Function"),
        "#'",
        "#' @param input Shiny input object.",
        "#'",
        "#' @export",
        paste0(name, "_input <- function(input) {"),
        "    tagList(",
        "        # Add input elements here",
        "    )",
        "}",
        "",
        paste0("#' ", tools::toTitleCase(name), " Output Function"),
        "#'",
        "#' @param id Output element ID.",
        "#' @param output Shiny output object.",
        "#'",
        "#' @export",
        paste0(name, "_output <- function(id, output) {"),
        "    switch(",
        "        id,",
        paste0("        \"plot\" = plotOutput(id),"),
        paste0("        \"table\" = tableOutput(id),"),
        "        stop(\"Invalid output type specified: \", id)",
        "    )",
        "}",
        "",
        paste0("#' ", tools::toTitleCase(name), " Server Function"),
        "#'",
        "#' @param input Shiny input object.",
        "#' @param output Shiny output object.",
        "#'",
        "#' @export",
        paste0(name, "_server <- function(input, output) {"),
        "    # Add server logic here",
        "}"
    )
}

module_test_template <- function(name) {
    c(
        paste0("test_that(\"", name, "_input generates correct UI components\", {"),
        paste0("    ui <- ", name, "_input(\"test\")"),
        "    expect_true(inherits(ui, \"shiny.tag.list\"))",
        "})",
        "",
        paste0("test_that(\"", name, "_output returns correct UI elements\", {"),
        paste0("    expect_true(inherits(", name, "_output(\"plot\"), \"shiny.tag\"))"),
        paste0("    expect_true(inherits(", name, "_output(\"table\"), \"shiny.tag\"))"),
        paste0("    expect_error(", name, "_output(\"invalid\"))"),
        "})"
    )
}
