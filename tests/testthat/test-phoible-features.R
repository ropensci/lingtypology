library(lingtypology)
context("Tests for phoible.feature function")

test_that("phoible.feature", {
  expect_error(phoible.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in PHOIBLE database.")
})
