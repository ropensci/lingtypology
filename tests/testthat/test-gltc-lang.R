library(lingtypology)
context("Tests for gltc.lang function")

df <- data.frame(my_langs = c("Kabardian", "Udi"), stringsAsFactors = FALSE)

test_that("gltc.lang", {
  skip_on_cran()
    expect_equal(gltc.lang("Kabardian"), c(Kabardian = "kaba1278"))
    expect_equal(gltc.lang(c("Kabardian", "Udi")), c(Kabardian = "kaba1278", Udi = "udii1243"))
    expect_equal(gltc.lang(df), c(my_langs1 = "kaba1278", my_langs2 = "udii1243"))
})
