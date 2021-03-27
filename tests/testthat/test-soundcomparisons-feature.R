library(lingtypology)
context("Tests for soundcomparisons.feature function")

test_that("soundcomparisons.feature", {
  expect_error(soundcomparisons.feature(c("aa", "bb")), "There is no features 'aa' in soundcomparisons database.")
})
