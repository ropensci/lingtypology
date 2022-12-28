library(lingtypology)
context("Tests for is.glottolog function")

test_that("database part", {
    expect_equal(is.glottolog("Adyghe"), TRUE)
})

test_that("is.glottolog spell checker", {
    expect_that(warning(is.glottolog("Adyge")), gives_warning())
    expect_that(warning(is.glottolog("Adyge", response = TRUE)), gives_warning("Language Adyge is absent in our version of the Glottolog database. Did you mean Aduge, Adyghe, Abkhaz-Adyge?"))
    expect_that(warning(is.glottolog("Romagnolo", response = TRUE)), gives_warning("Language Romagnolo is absent in our version of the Glottolog database. Did you mean Romagnol?"))
    expect_that(warning(is.glottolog(c("Adyge", "Laz"), response = TRUE)), gives_warning("Language Adyge is absent in our version of the Glottolog database. Did you mean Aduge, Adyghe, Abkhaz-Adyge?"))
})
