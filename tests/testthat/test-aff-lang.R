df <- data.frame(my_langs = c("Korean", "Polish"), stringsAsFactors = FALSE)

test_that("aff.lang", {
    expect_equal(aff.lang("Korean"), c(Korean = "Koreanic"))
    expect_equal(aff.lang(c("Korean", "Polish")), c(Korean = "Koreanic", Polish = "Indo-European, Classical Indo-European, Balto-Slavic, Slavic, West Slavic, Lechitic"))
    expect_equal(aff.lang(df), c(my_langs1 = "Koreanic", my_langs2 = "Indo-European, Classical Indo-European, Balto-Slavic, Slavic, West Slavic, Lechitic"))
})
