library(lingtypology)
context("Tests for grambank.feature function")

test_that("wals.feature", {
  expect_error(grambank.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in Grambank database.")
})

