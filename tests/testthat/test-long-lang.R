library(lingtypology)
context("Tests for long.lang function")

df <- data.frame(my_langs = c("Adyghe", "Russian"))

test_that("long.lang", {
    expect_equal(long.lang("Adyghe"), c(Adyghe = 39.33))
    expect_equal(long.lang(c("Adyghe", "Russian")), c(Adyghe = 39.33, Russian = 50))
    expect_equal(long.lang(df), c(39.33, 50))
    expect_equal(round(long.lang("Aleut"), 4), c(Aleut = 185.71))
    expect_equal(round(long.lang("Aleut", map.orientation = "Atlantic"), 2), c(Aleut = -174.29))
})
