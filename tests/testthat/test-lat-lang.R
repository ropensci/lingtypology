library(lingtypology)
context("Tests for lat.lang function")

df <- data.frame(my_langs = c("Kabardian", "Russian"), stringsAsFactors = FALSE)

test_that("lat.lang", {
  skip_on_cran()
    expect_equal(lat.lang("Kabardian"), c(Kabardian = 43.5082))
    expect_equal(lat.lang(df), c(my_langs1 = 43.5082, my_langs2 = 59))
    expect_equal(lat.lang(c("Kabardian", "Russian")), c(Kabardian = 43.5082, Russian = 59))
})
