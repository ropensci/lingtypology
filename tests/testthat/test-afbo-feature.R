library(lingtypology)
context("Tests for afbo.feature function")

test_that("afbo.feature", {
  skip_on_cran()
  expect_error(afbo.feature(c("aa", "bb")), "There is no features 'aa', 'bb' in AfBo database.")
})

