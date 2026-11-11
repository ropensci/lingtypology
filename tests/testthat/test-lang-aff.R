library(lingtypology)

df <- data.frame(my_langs = c("Eastern Baltic"), stringsAsFactors = FALSE)

test_that("lang.aff", {
  skip_on_cran()
    expect_equal(lang.aff("Eastern Baltic"), c("Latvian", "Lithuanian"))
    expect_equal(lang.aff(df), c(my_langs1 = "Latvian",
                                 my_langs2 = "Lithuanian"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic")), c("Old South-West British",
                                                         "Welsh",
                                                         "Old-Middle Welsh",
                                                         "Cornish",
                                                         "Breton",
                                                         "Vannetais",
                                                         "Early Irish",
                                                         "Irish",
                                                         "Scottish Gaelic",
                                                         "Manx"))
    expect_equal(lang.aff(c("Brythonic", "Goidelic"), list = TRUE),
                 list(c("Old South-West British",
                        "Welsh",
                        "Old-Middle Welsh",
                        "Cornish",
                        "Breton",
                        "Vannetais"),
                      c("Early Irish",
                        "Irish",
                        "Scottish Gaelic",
                        "Manx")))
})
