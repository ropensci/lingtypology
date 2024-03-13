library(lingtypology)
context("Tests for iso.lang function")

df <- data.frame(my_langs = c("Kabardian", "Udi"), stringsAsFactors = FALSE)

test_that("iso.lang", {
  skip_on_cran()
    expect_equal(iso.lang("Kabardian"), c(Kabardian = "kbd"))
    expect_equal(iso.lang(c("Kabardian", "Udi")), c(Kabardian = "kbd", Udi = "udi"))
    expect_equal(iso.lang(df), c(my_langs1 = "kbd", my_langs2 = "udi"))
})
