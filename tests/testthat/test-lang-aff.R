library(lingtypology)
context("Tests for lang.aff function")

df <- data.frame(my_langs = c("Slavic"))

test_that("aff.lang", {
    expect_equal(lang.aff("Slavic"), c("Lower Sorbian", "Ukrainian", "Kajkavian",
                                       "Croatian", "Silesian", "Serbian", "Czech",
                                       "Rusyn", "Russian", "Slavomolisano",
                                       "Belarusian", "Slovenian", "Slovak",
                                       "Bosnian", "Kashubian", "Macedonian",
                                       "Church Slavic", "Bulgarian", "Upper Sorbian",
                                       "Polish"))
    expect_equal(lang.aff(df), c("Lower Sorbian", "Ukrainian", "Kajkavian",
                                 "Croatian", "Silesian", "Serbian", "Czech",
                                 "Rusyn", "Russian", "Slavomolisano",
                                 "Belarusian", "Slovenian", "Slovak",
                                 "Bosnian", "Kashubian", "Macedonian",
                                 "Church Slavic", "Bulgarian", "Upper Sorbian",
                                 "Polish"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic")), c("Breton", "Cornish", "Welsh",
                                                         "Scottish Gaelic", "Irish",
                                                         "Manx"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic"), list = TRUE),
                 list(c("Breton", "Cornish", "Welsh"),
                      c("Scottish Gaelic", "Irish", "Manx")))
})
