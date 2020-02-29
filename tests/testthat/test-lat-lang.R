library(lingtypology)
context("Tests for lat.lang function")

df <- data.frame(my_langs = c("Adyghe", "Russian"), stringsAsFactors = FALSE)

test_that("lat.lang", {
    expect_equal(lat.lang("Adyghe"), c(Adyghe = 44))
    expect_equal(lat.lang(df), c(my_langs1 = 44, my_langs2 = 59))
    expect_equal(lat.lang(c("Adyghe", "Russian")), c(Adyghe = 44, Russian = 59))
})
