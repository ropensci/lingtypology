library(lingtypology)
context("Tests for is.glottolog function")

df <- data.frame(my_langs = c("Tabassaran", "Tabasaran"))

test_that("database part", {
    expect_equal(is.glottolog("Adyghe"), TRUE)
    expect_equal(is.glottolog(c("Tabassaran", "Tabasaran")), c(FALSE, TRUE))
    expect_equal(is.glottolog(df), c(FALSE, TRUE))
    expect_equal(is.glottolog(c("Tabassaran", "Tabasaran"), glottolog.source = "original"), c(TRUE,
        FALSE))
})

test_that("is.glottolog spell checker", {
    expect_that(warning(is.glottolog("Adyge")), gives_warning())
    expect_that(warning(is.glottolog("Adyge", response = TRUE)), gives_warning("Languoid Adyge is absent in our database. Did you mean Adyghe, Aduge?"))
    expect_that(warning(is.glottolog("Romagnolo", response = TRUE)), gives_warning("Languoid Romagnolo is absent in our database. Did you mean Romagnol, Emiliano-Romagnolo?"))
    expect_that(warning(is.glottolog(c("Adyge", "Laz"), response = TRUE)), gives_warning("Languoid Adyge is absent in our database. Did you mean Adyghe, Aduge?"))
})
