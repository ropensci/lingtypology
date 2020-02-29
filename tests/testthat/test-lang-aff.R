library(lingtypology)
context("Tests for lang.aff function")

df <- data.frame(my_langs = c("Baltic"), stringsAsFactors = FALSE)

test_that("lang.aff", {
    expect_equal(lang.aff("Baltic"), c("Latvian",
                                       "Lithuanian"))
    expect_equal(lang.aff(df), c(my_langs1 = "Latvian",
                                 my_langs2 = "Lithuanian"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic")), c("Old-Middle Welsh",
                                                         "Welsh",
                                                         "Breton",
                                                         "Cornish",
                                                         "Early Irish",
                                                         "Manx",
                                                         "Scottish Gaelic",
                                                         "Irish"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic"), list = TRUE),
                 list(c("Old-Middle Welsh",
                        "Welsh",
                        "Breton",
                        "Cornish"),
                      c("Early Irish",
                        "Manx",
                        "Scottish Gaelic",
                        "Irish")))
})
