library(lingtypology)
context("Tests for vanuatu.feature function")

test_that("vanuatu.feature", {
  skip_on_cran()
  expect_error(vanuatu.feature(c("aa", "bb")), "None of the parameters are in the vanuatu database.")
})
