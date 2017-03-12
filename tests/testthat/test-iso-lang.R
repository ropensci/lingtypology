library(lingtypology)
context("Tests for iso.lang function")

df <- data.frame(my_langs = c("Adyghe", "Udi"))

test_that("iso.lang", {
    expect_equal(iso.lang("Adyghe"), c(Adyghe = "ady"))
    expect_equal(iso.lang(c("Adyghe", "Udi")), c(Adyghe = "ady", Udi = "udi"))
    expect_equal(iso.lang(df), c("ady", "udi"))
})
