library(lingtypology)
context("Tests for long.lang function")

df <- data.frame(my_langs = c("West Circassian", "Russian"), stringsAsFactors = FALSE)

test_that("long.lang", {
  skip_on_cran()
    expect_equal(long.lang("Kabardian"), c(Kabardian = 43.3918))
    expect_equal(long.lang(c("Kabardian", "Russian")), c(Kabardian = 43.3918, Russian = 50))
    expect_equal(long.lang(df), c(my_langs1 = 39.33, my_langs2 = 50))
    expect_equal(round(long.lang("Aleut"), 4), c(Aleut = 185.71))
    expect_equal(round(long.lang("Aleut", map.orientation = "Atlantic"), 2), c(Aleut = -174.29))
})
