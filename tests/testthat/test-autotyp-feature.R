library(lingtypology)
context("Tests for autotyp.feature function")

test_that("autotyp.feature", {
  expect_error(autotyp.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in AUTOTYP database.")
})
