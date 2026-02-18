test_that("get_config reads default configuration", {
    config_path <- file.path(test_path("../.."), "inst", "config.yml")
    cfg <- get_config(config_path)
    expect_type(cfg, "list")
    expect_true("greeting" %in% names(cfg))
})

test_that("get_config respects R_CONFIG_ACTIVE", {
    config_path <- file.path(test_path("../.."), "inst", "config.yml")
    withr::with_envvar(c("R_CONFIG_ACTIVE" = "production"), {
        cfg <- get_config(config_path)
        expect_equal(cfg$greeting, "Hey there!")
    })
})

test_that("get_config errors on missing file", {
    expect_error(get_config("nonexistent.yml"))
})
