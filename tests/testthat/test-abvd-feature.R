library(lingtypology)

test_that("abvd.feature", {
  skip_on_cran()
  expect_error(abvd.feature(c("aa", "bb")), "You need to provide a numeric vector with language id from ABVD.")
})
