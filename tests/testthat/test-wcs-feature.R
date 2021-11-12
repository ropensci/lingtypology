library(testthat)

test_that("wcs.feature",  {
  expect_length(wcs.feature("WCS"), 19)})
