library(lingtypology)
context("Tests for lat.lang function")

df <- data.frame(my_langs = c("Adyghe", "Russian"))

test_that("lat.lang", {
    expect_equal(lat.lang("Adyghe"), c(Adyghe = 44))
    expect_equal(lat.lang(df), c(44, 59))
    expect_equal(lat.lang(c("Adyghe", "Russian")), c(Adyghe = 44, Russian = 59))
})
