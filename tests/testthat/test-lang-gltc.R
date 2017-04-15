library(lingtypology)
context("Tests for lang.gltc function")

df <- data.frame(my_langs = c("adyg1241", "russ1263"))

test_that("lang.gltc", {
    expect_equal(lang.gltc("adyg1241"), c(adyg1241 = "Adyghe"))
    expect_equal(lang.gltc(df), c("Adyghe", "Russian"))
    expect_equal(lang.gltc(c("adyg1241", "russ1263")), c(adyg1241 = "Adyghe", russ1263 = "Russian"))
})
