library(lingtypology)
context("Tests for is.glottolog function")

test_that("database part", {
  skip_on_cran()
  expect_equal(is.glottolog("Kabardian"), TRUE)
})

test_that("is.glottolog spell checker", {
  skip_on_cran()
  expect_that(warning(is.glottolog("Kabardia")), gives_warning())
  expect_that(warning(is.glottolog("Kabardia", response = TRUE)), gives_warning("Language Kabardia is absent in our version of the Glottolog database. Did you mean Kabardian, Greater Kabardian?"))
  expect_that(warning(is.glottolog("Romagnolo", response = TRUE)), gives_warning("Language Romagnolo is absent in our version of the Glottolog database. Did you mean Romagnol, Northern Romagnolo, Southern Romagnolo, Emiliano-Romagnolo?"))
  expect_that(warning(is.glottolog(c("Kabardia", "Laz"), response = TRUE)), gives_warning("Language Kabardia is absent in our version of the Glottolog database. Did you mean Kabardian, Greater Kabardian?"))
})
