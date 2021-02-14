library(lingtypology)
context("Tests for vanuatu.feature function")

test_that("vanuatu.feature", {
  expect_error(vanuatu.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in WALS database.")
})
