library(lingtypology)
context("Tests for is.glottolog function")

df <- data.frame(my_langs = c("Abkhazian", "Abkhaz"))

test_that("database part", {
    expect_equal(is.glottolog("Adyghe"), TRUE)
    expect_equal(is.glottolog(c("Abkhazian", "Abkhaz")), c(FALSE, TRUE))
    expect_equal(is.glottolog(df), c(FALSE, TRUE))
    expect_equal(is.glottolog(c("Abkhazian", "Abkhaz"), glottolog.source = "original"), c(TRUE, FALSE))
})

test_that("is.glottolog spell checker", {
    expect_that(warning(is.glottolog("Adyge")), gives_warning())
    expect_that(warning(is.glottolog("Adyge", response = TRUE)), gives_warning("Language Adyge is absent in our version of the Glottolog database. Did you mean Adyghe, Aduge?"))
    expect_that(warning(is.glottolog("Romagnolo", response = TRUE)), gives_warning("Language Romagnolo is absent in our version of the Glottolog database. Did you mean Romagnol?"))
    expect_that(warning(is.glottolog(c("Adyge", "Laz"), response = TRUE)), gives_warning("Language Adyge is absent in our version of the Glottolog database. Did you mean Adyghe, Aduge?"))
})
