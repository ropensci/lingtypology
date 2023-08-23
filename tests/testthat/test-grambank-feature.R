library(lingtypology)
context("Tests for grambank.feature function")

test_that("grambank.feature", {
  skip_on_cran()
  expect_error(grambank.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in Grambank database.")
})

