library(lingtypology)
context("Tests for long.lang function")

test_that("long.lang", {
    expect_equal(long.lang("Adyghe"), c(Adyghe = 39.33))
    expect_equal(long.lang(c("Adyghe", "Russian")), c(Adyghe = 39.33, Russian = 38))
})
