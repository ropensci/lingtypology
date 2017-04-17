library(lingtypology)
context("Tests for iso.gltc function")

df <- data.frame(my_langs = c("ady", "udi"))

test_that("iso.gltc", {
  expect_equal(gltc.iso("ady"), c(ady = "adyg1241"))
  expect_equal(gltc.iso(c("ady", "udi")), c(ady = "adyg1241", udi = "udii1243"))
  expect_equal(gltc.iso(df), c("adyg1241", "udii1243"))
})
