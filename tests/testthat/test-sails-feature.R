library(lingtypology)
context("Tests for sails.feature function")

test_that("sails.feature", {
  expect_error(sails.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in SAILS database.")
})
