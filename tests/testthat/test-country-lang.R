df <- data.frame(my_langs = c("Korean", "Polish"), stringsAsFactors = FALSE)

test_that("country.lang", {
    expect_equal(country.lang("Korean"), c(Korean = "China;South Korea;North Korea;Russia"))
    expect_equal(country.lang(c("Korean", "Polish")), c(Korean = "China;South Korea;North Korea;Russia", Polish = "Belarus;Czech;Germany;Lithuania;Poland;Russia"))
    expect_equal(country.lang(df), c(my_langs1 = "China;South Korea;North Korea;Russia", my_langs2 = "Belarus;Czech;Germany;Lithuania;Poland;Russia"))
})
