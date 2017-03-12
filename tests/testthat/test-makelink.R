library(lingtypology)
context("Tests for makelink function")

df <- data.frame(my_langs = c("Adyghe"))

test_that("makelink", {
    expect_equal(makelink("Adyghe"), "<a href='http://glottolog.org/resource/languoid/iso/ady' target='_blank'>Adyghe</a><br>")
    expect_equal(makelink(df), "<a href='http://glottolog.org/resource/languoid/iso/ady' target='_blank'>Adyghe</a><br>")
})
