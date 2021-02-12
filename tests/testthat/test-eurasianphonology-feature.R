library(testthat)
context("Tests for eurasianphonology.feature function")

test_that("eurasianphonology.feature",  {
  expect_length(eurasianphonolgy.feature(), 19)})
