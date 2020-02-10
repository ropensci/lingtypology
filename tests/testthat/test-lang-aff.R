library(lingtypology)
context("Tests for lang.aff function")

df <- data.frame(my_langs = c("Baltic"))

test_that("lang.aff", {
    expect_equal(lang.aff("Baltic"), c("Latvian",
                                       "Lithuanian",
                                       "Baltic Romani"))
    expect_equal(lang.aff(df), c("Latvian",
                                 "Lithuanian",
                                 "Baltic Romani"))
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
