library(lingtypology)
context("Tests for gltc.lang function")

df <- data.frame(my_langs = c("Adyghe", "Udi"))

test_that("gltc.lang", {
    expect_equal(gltc.lang("Adyghe"), c(Adyghe = "adyg1241"))
    expect_equal(gltc.lang(c("Adyghe", "Udi")), c(Adyghe = "adyg1241", Udi = "udii1243"))
    expect_equal(gltc.lang(df), c("adyg1241", "udii1243"))
})
