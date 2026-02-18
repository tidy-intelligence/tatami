test_that("summary_output returns correct UI elements", {
    expect_true(inherits(summary_output("summary_stats"), "shiny.tag"))
    expect_true(inherits(summary_output("summary_table"), "shiny.tag"))
    expect_error(summary_output("invalid"), "Invalid output type specified")
})
