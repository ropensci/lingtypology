library(lingtypology)
context("Tests for lang.gltc function")

df <- data.frame(my_langs = c("adyg1241", "russ1263"), stringsAsFactors = FALSE)

test_that("lang.gltc", {
  skip_on_cran()
    expect_equal(lang.gltc("adyg1241"), c(adyg1241 = "West Circassian"))
    expect_equal(lang.gltc(df), c(my_langs1 = "West Circassian", my_langs2 = "Russian"))
    expect_equal(lang.gltc(c("adyg1241", "russ1263")), c(adyg1241 = "West Circassian", russ1263 = "Russian"))
})
