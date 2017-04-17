library(lingtypology)
context("Tests for aff.lang function")

df <- data.frame(my_langs = c("Korean", "Polish"))

test_that("aff.lang", {
    expect_equal(aff.lang("Korean"), c(Korean = "Language isolate"))
    expect_equal(aff.lang(c("Korean", "Polish")), c(Korean = "Language isolate", Polish = "Indo-European, Slavic, West, Lechitic"))
    expect_equal(aff.lang(df), c("Language isolate", "Indo-European, Slavic, West, Lechitic"))
})
