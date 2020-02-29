library(lingtypology)
context("Tests for lang.iso function")

df <- data.frame(my_langs = c("ady", "rus"), stringsAsFactors = FALSE)

test_that("lang.iso", {
    expect_equal(lang.iso("ady"), c(ady = "Adyghe"))
    expect_equal(lang.iso(df), c(my_langs1 = "Adyghe", my_langs2 = "Russian"))
    expect_equal(lang.iso(c("ady", "rus")), c(ady = "Adyghe", rus = "Russian"))
})
