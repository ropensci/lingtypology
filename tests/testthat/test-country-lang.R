df <- data.frame(my_langs = c("Korean", "Polish"), stringsAsFactors = FALSE)

test_that("country.lang", {
    expect_equal(country.lang("Korean"), c(Korean = "CN;KP;KR;RU"))
    expect_equal(country.lang(c("Korean", "Polish")), c(Korean = "CN;KP;KR;RU", Polish = "BY;CZ;DE;LT;PL;RU;SK;UA"))
    expect_equal(country.lang(df), c(my_langs1 = "CN;KP;KR;RU", my_langs2 = "BY;CZ;DE;LT;PL;RU;SK;UA"))
})
