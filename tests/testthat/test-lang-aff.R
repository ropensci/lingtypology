library(lingtypology)

df <- data.frame(my_langs = c("Baltic"), stringsAsFactors = FALSE)

test_that("lang.aff", {
  skip_on_cran()
    expect_equal(lang.aff("Baltic"), c("Lithuanian", "Latvian"))
    expect_equal(lang.aff(df), c(my_langs1 = "Lithuanian",
                                 my_langs2 = "Latvian"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic")), c("Welsh",
                                                         "Old-Middle Welsh",
                                                         "Breton",
                                                         "Cornish",
                                                         "Early Irish",
                                                         "Irish",
                                                         "Scottish Gaelic",
                                                         "Manx"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic"), list = TRUE),
                 list(c("Welsh",
                        "Old-Middle Welsh",
                        "Breton",
                        "Cornish"),
                      c("Early Irish",
                        "Irish",
                        "Scottish Gaelic",
                        "Manx")))
})
