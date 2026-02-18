test_that("get_config reads default configuration", {
    cfg <- get_config("inst/config.yml")
    expect_type(cfg, "list")
    expect_true("greeting" %in% names(cfg))
})

test_that("get_config respects R_CONFIG_ACTIVE", {
    withr::with_envvar(c("R_CONFIG_ACTIVE" = "production"), {
        cfg <- get_config("inst/config.yml")
        expect_equal(cfg$greeting, "Hey there!")
    })
})

test_that("get_config errors on missing file", {
    expect_error(get_config("nonexistent.yml"))
})
