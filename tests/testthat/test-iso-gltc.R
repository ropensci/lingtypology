library(lingtypology)
context("Tests for iso.gltc function")

df <- data.frame(my_langs = c("adyg1241", "udii1243"))

test_that("iso.gltc", {
    expect_equal(iso.gltc("adyg1241"), c(adyg1241 = "ady"))
    expect_equal(iso.gltc(c("adyg1241", "udii1243")), c(adyg1241 = "ady", udii1243 = "udi"))
    expect_equal(iso.gltc(df), c("ady", "udi"))
})
