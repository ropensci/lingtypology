library(lingtypology)
context("Tests for soundcomparisons.feature function")

test_that("soundcomparisons.feature", {
  skip_on_cran()
  expect_error(soundcomparisons.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in our version of the soundcomparisons database.")
})
