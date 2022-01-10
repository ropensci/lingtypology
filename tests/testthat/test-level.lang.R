library(lingtypology)
context("Tests for level.lang function")

df <- data.frame(my_langs = c("Adyghe", "Russian Sign Language"), stringsAsFactors = FALSE)

test_that("lang.gltc", {
  expect_equal(level.lang("Adyghe"), c(Adyghe = "language"))
  expect_equal(level.lang(df), c(my_langs1 = "language", my_langs2 = "dialect"))
  expect_equal(level.lang(c("Adyghe", "Russian Sign Language")), c(Adyghe = "language", `Russian Sign Language` = "dialect"))
})
