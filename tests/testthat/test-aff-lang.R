library(lingtypology)
context("Tests for aff.lang function")

df <- data.frame(my_langs = c("Korean", "Polish"), stringsAsFactors = FALSE)

test_that("aff.lang", {
    expect_equal(aff.lang("Korean"), c(Korean = "Koreanic,Korean"))
    expect_equal(aff.lang(c("Korean", "Polish")), c(Korean = "Koreanic,Korean", Polish = "Indo-European,Balto-Slavic,Slavic,West Slavic,Lechitic,Polish"))
    expect_equal(aff.lang(df), c(my_langs1 = "Koreanic,Korean", my_langs2 = "Indo-European,Balto-Slavic,Slavic,West Slavic,Lechitic,Polish"))
})
