library(lingtypology)
context("Tests for makelink function")

df <- data.frame(my_langs = c("Adyghe"), stringsAsFactors = FALSE)

test_that("makelink", {
  skip_on_cran()
    expect_equal(url.lang("Adyghe"), "<a href='https://glottolog.org/resource/languoid/id/adyg1241' target='_blank'>Adyghe</a><br>")
    expect_equal(url.lang(df), "<a href='https://glottolog.org/resource/languoid/id/adyg1241' target='_blank'>Adyghe</a><br>")
    expect_equal(url.lang("Hachijo"), "<a href='https://glottolog.org/resource/languoid/id/hach1239' target='_blank'>Hachijo</a><br>")
})
