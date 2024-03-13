library(lingtypology)
context("Tests for level.lang function")

df <- data.frame(my_langs = c("West Circassian", "Russian Sign Language"), stringsAsFactors = FALSE)

test_that("lang.gltc", {
  skip_on_cran()
  expect_equal(level.lang("Kabardian"), c(Kabardian = "language"))
  expect_equal(level.lang(df), c(my_langs1 = "language", my_langs2 = "dialect"))
  expect_equal(level.lang(c("West Circassian", "Russian Sign Language")), c(`West Circassian` = "language", `Russian Sign Language` = "dialect"))
})
