test_that("add_module creates module and test files", {
    tmp <- tempfile("tatami_test_")
    create_app(tmp, open = FALSE)

    add_module("chart", path = tmp)

    mod_file <- file.path(tmp, "R", "mod_chart.R")
    test_file <- file.path(tmp, "tests", "testthat", "test-mod_chart.R")

    expect_true(file.exists(mod_file))
    expect_true(file.exists(test_file))

    mod_content <- readLines(mod_file)
    expect_true(any(grepl("chart_input", mod_content)))
    expect_true(any(grepl("chart_output", mod_content)))
    expect_true(any(grepl("chart_server", mod_content)))

    unlink(tmp, recursive = TRUE)
})

test_that("add_module errors if module already exists", {
    tmp <- tempfile("tatami_test_")
    create_app(tmp, open = FALSE)

    add_module("chart", path = tmp)
    expect_error(add_module("chart", path = tmp), "already exists")

    unlink(tmp, recursive = TRUE)
})

test_that("add_module errors if R directory missing", {
    tmp <- tempfile("tatami_test_")
    dir.create(tmp)

    expect_error(add_module("chart", path = tmp), "Is this a tatami app")

    unlink(tmp, recursive = TRUE)
})
