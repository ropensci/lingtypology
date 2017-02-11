library(lingtypology)
context("Tests for lang.iso function")

test_that("lang.iso", {
  expect_equal(lang.iso("ady"),
               c(ady = "Adyghe"))
  expect_equal(lang.iso(c("ady", "rus")),
               c(ady = "Adyghe",
                 rus = "Russian"))
})
