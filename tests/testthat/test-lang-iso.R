library(lingtypology)
context("Tests for lang.iso function")

df <- data.frame(my_langs = c("ady", "rus"), stringsAsFactors = FALSE)

test_that("lang.iso", {
  skip_on_cran()
    expect_equal(lang.iso("ady"), c(ady = "West Circassian"))
    expect_equal(lang.iso(df), c(my_langs1 = "West Circassian", my_langs2 = "Russian"))
    expect_equal(lang.iso(c("ady", "rus")), c(ady = "West Circassian", rus = "Russian"))
})
