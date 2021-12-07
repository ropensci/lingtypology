library(testthat)
context("Tests for wcs.feature function")

test_that("wcs.feature",  {
  expect_length(wcs.feature("WCS"), 19)
  expect_length(wcs.feature("Berlin and Kay"), 13)})
