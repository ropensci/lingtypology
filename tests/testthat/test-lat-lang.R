library(lingtypology)
context("Tests for lat.lang function")

test_that("lat.lang", {
  expect_equal(lat.lang("Adyghe"),
               c("Adyghe" = 44))
  expect_equal(lat.lang(c("Adyghe", "Russian")),
               c("Adyghe" = 44,
                 "Russian" = 56))
})
