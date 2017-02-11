library(lingtypology)
context("Tests for area.lang function")

test_that("area.lang", {
  expect_equal(area.lang("Adyghe"),
               c(Adyghe = "Eurasia"))
  expect_equal(area.lang(c("Adyghe", "Aduge")),
               c(Adyghe = "Eurasia",
                 Aduge = "Africa"))
})
