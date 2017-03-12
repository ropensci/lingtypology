library(lingtypology)
context("Tests for lang.country function")

df <- data.frame(my_countries = c("North Korea", "Lebanon"))

test_that("lang.country", {
    expect_equal(lang.country(df), c("Korean", "English", "French", "Assyrian Neo-Aramaic",
                                                            "Northern Kurdish", "Armenian", "North Levantine Arabic", "Turoyo", "Chaldean Neo-Aramaic",
                                                            "Standard Arabic", "Pidgin Madam"))
    expect_equal(lang.country(c("North Korea", "Lebanon")), c("Korean", "English", "French", "Assyrian Neo-Aramaic",
        "Northern Kurdish", "Armenian", "North Levantine Arabic", "Turoyo", "Chaldean Neo-Aramaic",
        "Standard Arabic", "Pidgin Madam"))
    expect_equal(lang.country(c("North Korea", "Lebanon"), list = TRUE), list(c("Korean"), c("English",
        "French", "Assyrian Neo-Aramaic", "Northern Kurdish", "Armenian", "North Levantine Arabic",
        "Turoyo", "Chaldean Neo-Aramaic", "Standard Arabic", "Pidgin Madam")))
})
