test_that("create_app creates correct directory structure", {
    tmp <- tempfile("tatami_test_")

    create_app(tmp, open = FALSE)

    expect_true(dir.exists(tmp))
    expect_true(dir.exists(file.path(tmp, "R")))
    expect_true(dir.exists(file.path(tmp, "man")))
    expect_true(dir.exists(file.path(tmp, "inst")))
    expect_true(dir.exists(file.path(tmp, "inst", "assets", "css")))
    expect_true(dir.exists(file.path(tmp, "inst", "assets", "img")))
    expect_true(dir.exists(file.path(tmp, "tests", "testthat")))

    expect_true(file.exists(file.path(tmp, "DESCRIPTION")))
    expect_true(file.exists(file.path(tmp, "NAMESPACE")))
    expect_true(file.exists(file.path(tmp, "index.qmd")))
    expect_true(file.exists(file.path(tmp, "inst", "config.yml")))
    expect_true(file.exists(file.path(tmp, "inst", "_brand.yml")))
    expect_true(file.exists(file.path(tmp, "R", "run.R")))
    expect_true(file.exists(file.path(tmp, "R", "context_data.R")))
    expect_true(file.exists(file.path(tmp, "R", "config.R")))
    expect_true(file.exists(file.path(tmp, ".gitignore")))
    expect_true(file.exists(file.path(tmp, ".Rbuildignore")))
    expect_true(file.exists(file.path(tmp, "tests", "testthat.R")))

    unlink(tmp, recursive = TRUE)
})

test_that("create_app uses app name from path", {
    tmp <- file.path(tempdir(), "myapp")

    create_app(tmp, open = FALSE)

    desc <- readLines(file.path(tmp, "DESCRIPTION"))
    expect_true(any(grepl("Package: myapp", desc)))

    unlink(tmp, recursive = TRUE)
})

test_that("create_app errors if directory exists", {
    tmp <- tempfile("tatami_test_")
    dir.create(tmp)

    expect_error(create_app(tmp, open = FALSE), "already exists")

    unlink(tmp, recursive = TRUE)
})
