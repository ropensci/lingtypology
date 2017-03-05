library(lingtypology)
context("Tests for lang.iso function")

df <- data.frame(my_langs = c("ady", "rus"))

test_that("lang.iso", {
    expect_equal(lang.iso("ady"), c(ady = "Adyghe"))
    expect_equal(lang.iso(df), c("Adyghe", "Russian"))
    expect_equal(lang.iso(c("ady", "rus")), c(ady = "Adyghe", rus = "Russian"))
})
