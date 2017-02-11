library(lingtypology)
context("Tests for iso.lang function")

test_that("iso.lang", {
  expect_equal(iso.lang("Adyghe"),
               c(Adyghe = "ady"))
  expect_equal(iso.lang(c("Adyghe", "Udi")),
               c(Adyghe = "ady",
                 Udi = "udi"))
})
