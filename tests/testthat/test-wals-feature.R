library(lingtypology)
context("Tests for wals.feature function")

test_that("wals.feature", {
  expect_error(wals.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in WALS database.")
})
