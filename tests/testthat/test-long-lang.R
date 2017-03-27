library(lingtypology)
context("Tests for long.lang function")

df <- data.frame(my_langs = c("Adyghe", "Russian"))

test_that("long.lang", {
    expect_equal(long.lang("Adyghe"), c(Adyghe = 39.33))
    expect_equal(long.lang(c("Adyghe", "Russian")), c(Adyghe = 39.33, Russian = 50))
    expect_equal(long.lang(df), c(39.33, 50))
})
