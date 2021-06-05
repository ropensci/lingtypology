library(lingtypology)
context("Tests for bantu.feature function")

test_that("bantu.feature", {
  expect_error(bantu.feature("aa"), "There is no features 'aa' in bantu database.")
})
