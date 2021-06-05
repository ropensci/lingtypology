library(testthat)
context("Tests for eurasianphonology.feature function")

test_that("wcs.feature",  {
  expect_length(wcs.feature("WCS"), 19)})
