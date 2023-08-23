library(lingtypology)
context("Tests for iso.lang function")

df <- data.frame(my_langs = c("Adyghe", "Udi"), stringsAsFactors = FALSE)

test_that("iso.lang", {
  skip_on_cran()
    expect_equal(iso.lang("Adyghe"), c(Adyghe = "ady"))
    expect_equal(iso.lang(c("Adyghe", "Udi")), c(Adyghe = "ady", Udi = "udi"))
    expect_equal(iso.lang(df), c(my_langs1 = "ady", my_langs2 = "udi"))
})
