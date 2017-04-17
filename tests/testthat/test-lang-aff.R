library(lingtypology)
context("Tests for lang.aff function")

df <- data.frame(my_langs = c("Slavic"))

test_that("aff.lang", {
    expect_equal(lang.aff("Slavic"), c("Lower Sorbian", "Ukrainian", "Kajkavian", "Latvian",
                                       "Croatian", "Silesian", "Serbian", "Czech", "Rusyn", "Russian", "Slavomolisano",
                                       "Slovak", "Bosnian", "Old Russian", "Kashubian", "Macedonian", "Bulgarian",
                                       "Upper Sorbian", "Polabian", "Polish"))
    expect_equal(lang.aff(df), c("Lower Sorbian", "Ukrainian", "Kajkavian", "Latvian",
                                 "Croatian", "Silesian", "Serbian", "Czech", "Rusyn", "Russian", "Slavomolisano",
                                 "Slovak", "Bosnian", "Old Russian", "Kashubian", "Macedonian", "Bulgarian",
                                 "Upper Sorbian", "Polabian", "Polish"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic")), c("Breton", "Cornish", "Welsh", "Old Welsh",
                                                         "Old Irish (to 900)", "Scottish Gaelic", "Hiberno-Scottish Gaelic",
                                                         "Irish", "Manx"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic"), list = TRUE),
                 list(c("Breton", "Cornish", "Welsh", "Old Welsh"),
                      c("Old Irish (to 900)", "Scottish Gaelic", "Hiberno-Scottish Gaelic", "Irish", "Manx")))
})
