library(lingtypology)
context("Tests for makelink function")

test_that("makelink", {
  expect_equal(makelink("Adyghe"),
               "<a href='http://glottolog.org/resource/languoid/iso/ady' target='_blank'>Adyghe</a><br>"
  )
})
