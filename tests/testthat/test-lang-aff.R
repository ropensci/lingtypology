library(lingtypology)
context("Tests for lang.aff function")

df <- data.frame(my_langs = c("Balto-Slavic"))

test_that("aff.lang", {
    expect_equal(lang.aff("Balto-Slavic"), c("Silesian", "Russian", "Lower Sorbian", "Polabian", "Upper Sorbian",
        "Slavomolisano", "Old Prussian", "Slovenian", "Czech", "Croatian", "Bosnian", "Kashubian",
        "Polish", "Slovak", "Macedonian", "Serbian", "Church Slavic", "Rusyn", "Lithuanian", "Latvian",
        "Ukrainian", "Bulgarian", "Belarusian", "Old Russian", "Kajkavian"))
    expect_equal(lang.aff(df), c("Silesian", "Russian", "Lower Sorbian", "Polabian", "Upper Sorbian",
                                           "Slavomolisano", "Old Prussian", "Slovenian", "Czech", "Croatian", "Bosnian", "Kashubian",
                                           "Polish", "Slovak", "Macedonian", "Serbian", "Church Slavic", "Rusyn", "Lithuanian", "Latvian",
                                           "Ukrainian", "Bulgarian", "Belarusian", "Old Russian", "Kajkavian"))
    expect_equal(lang.aff(c("East Slavic", "West Slavic")), c(`East Slavic1` = "Russian", `East Slavic2` = "Rusyn",
        `East Slavic3` = "Ukrainian", `East Slavic4` = "Belarusian", `East Slavic5` = "Old Russian",
        `West Slavic1` = "Silesian", `West Slavic2` = "Lower Sorbian", `West Slavic3` = "Polabian",
        `West Slavic4` = "Upper Sorbian", `West Slavic5` = "Czech", `West Slavic6` = "Kashubian",
        `West Slavic7` = "Polish", `West Slavic8` = "Slovak"))
    expect_equal(lang.aff(c("East Slavic", "West Slavic"), list = TRUE), list(c("Russian", "Rusyn",
        "Ukrainian", "Belarusian", "Old Russian"), c("Silesian", "Lower Sorbian", "Polabian", "Upper Sorbian",
        "Czech", "Kashubian", "Polish", "Slovak")))
})
