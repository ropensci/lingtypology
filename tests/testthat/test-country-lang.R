library(lingtypology)
context("Tests for country.lang function")

df <- data.frame(my_langs = c("Udi", "Laz"))

test_that("country.lang", {
    expect_equal(country.lang("Udi"), c(Udi = "Russia, Georgia, Azerbaijan, Turkmenistan"))
    expect_equal(country.lang(c("Udi", "Laz")), c(Udi = "Russia, Georgia, Azerbaijan, Turkmenistan",
        Laz = "Turkey, Georgia, France, United States, Germany, Belgium"))
    expect_equal(country.lang(df), c("Russia, Georgia, Azerbaijan, Turkmenistan",
        "Turkey, Georgia, France, United States, Germany, Belgium"))
    expect_equal(country.lang(c("Udi", "Laz"), intersection = TRUE), "Georgia")
})
