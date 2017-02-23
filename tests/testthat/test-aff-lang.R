library(lingtypology)
context("Tests for aff.lang function")

test_that("aff.lang", {
    expect_equal(aff.lang("Korean"), c(Korean = "Koreanic"))
    expect_equal(aff.lang(c("Korean", "Polish")), c(Korean = "Koreanic", Polish = "Indo-European, Balto-Slavic, Slavic, West Slavic, Lechitic"))
})
