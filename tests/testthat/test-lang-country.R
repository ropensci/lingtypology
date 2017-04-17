library(lingtypology)
context("Tests for lang.country function")

df <- data.frame(my_countries = c("North Korea", "Lebanon"))

test_that("lang.country", {
    expect_equal(lang.country(df), c("Korean", "French", "Turoyo", "Assyrian Neo-Aramaic", "Pidgin Madam", "Northern Kurdish", "Armenian", "English", "Chaldean Neo-Aramaic", "Standard Arabic"))
    expect_equal(lang.country(c("North Korea", "Lebanon")), c("Korean", "French", "Turoyo", "Assyrian Neo-Aramaic", "Pidgin Madam", "Northern Kurdish", "Armenian", "English", "Chaldean Neo-Aramaic", "Standard Arabic"))
    expect_equal(lang.country(c("North Korea", "Lebanon"), list = TRUE), list(c("Korean"), c("French", "Turoyo", "Assyrian Neo-Aramaic", "Pidgin Madam", "Northern Kurdish", "Armenian", "English", "Chaldean Neo-Aramaic", "Standard Arabic")))
})
