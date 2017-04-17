library(lingtypology)
context("Tests for makelink function")

df <- data.frame(my_langs = c("Adyghe"))

test_that("makelink", {
    expect_equal(url.lang("Adyghe"), "<a href='http://glottolog.org/resource/languoid/iso/ady' target='_blank'>Adyghe</a><br>")
    expect_equal(url.lang(df), "<a href='http://glottolog.org/resource/languoid/iso/ady' target='_blank'>Adyghe</a><br>")
    expect_equal(url.lang("Hachijo"), "<a href='http://glottolog.org/resource/languoid/id/hach1239' target='_blank'>Hachijo</a><br>")
})
