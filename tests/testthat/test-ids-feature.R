library(lingtypology)
context("Tests for ids.feature function")

test_that("ids.feature", {
  skip_on_cran()
  expect_error(ids.feature(),
               "None of the parameters are in the ids database.")
})

test_that("ids.feature", {
  skip_on_cran()
  expect_error(
    ids.feature(features = c('aa', 'bb')),
    "None of the parameters are in the ids database."
  )
})
