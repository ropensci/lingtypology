library(lingtypology)
context("Tests for area.lang function")

df <- data.frame(my_langs = c("Korean", "Polish"), stringsAsFactors = FALSE)

test_that("area.lang", {
  skip_on_cran()
    expect_equal(area.lang("Kabardian"), c(Kabardian = "Eurasia"))
    expect_equal(area.lang(c("Kabardian", "Aduge")), c(Kabardian = "Eurasia", Aduge = "Africa"))
    expect_equal(area.lang(df), c(my_langs1 = "Eurasia", my_langs2 = "Eurasia"))
})
