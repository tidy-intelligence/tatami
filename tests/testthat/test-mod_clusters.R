test_that("clusters_input generates correct UI components", {
  context_data()
  ui <- clusters_input("test")
  expect_true(inherits(ui, "shiny.tag.list"))
  expect_equal(length(ui), 3)
  expect_true(any(sapply(ui, function(x) inherits(x, "shiny.tag"))))
})

test_that("clusters_output returns correct UI elements", {
  expect_true(inherits(clusters_output("plot"), "shiny.tag"))
  expect_true(inherits(clusters_output("table"), "shiny.tag"))
  expect_true(inherits(clusters_output("text"), "shiny.tag"))
  expect_true(inherits(clusters_output("verbatim"), "shiny.tag"))
  expect_error(clusters_output("invalid"), "Invalid output type specified")
})

# TODO: figure out best way to test server function
