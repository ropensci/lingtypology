library(lingtypology)
context("Tests for bantu.feature function")

test_that("bantu.feature", {
  expect_error(bantu.feature(c("aa", "bb")), "There is no features 'aa' in bantu database.")
})
