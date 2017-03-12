library(lingtypology)
context("Tests for aff.lang function")

df <- data.frame(my_langs = c("Korean", "Polish"))

test_that("aff.lang", {
    expect_equal(aff.lang("Korean"), c(Korean = "Koreanic"))
    expect_equal(aff.lang(c("Korean", "Polish")), c(Korean = "Koreanic", Polish = "Indo-European, Balto-Slavic, Slavic, West Slavic, Lechitic"))
    expect_equal(aff.lang(df), c("Koreanic", "Indo-European, Balto-Slavic, Slavic, West Slavic, Lechitic"))
})
