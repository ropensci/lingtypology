library(testthat)
context("Tests for eurasianphonology.feature function")

test_that("eurasianphonology.feature",  {
  skip_on_cran()
  expect_length(eurasianphonology.feature(), 19)})
