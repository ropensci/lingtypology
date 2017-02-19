library(lingtypology)
context("Tests for lang.country function")

test_that("lang.country", {
    expect_equal(lang.iso("ady"), c(ady = "Adyghe"))
    expect_equal(lang.country(c("North Korea", "Lebanon")), c("Korean", "English", "French", "Assyrian Neo-Aramaic", 
        "Northern Kurdish", "Armenian", "North Levantine Arabic", "Turoyo", "Chaldean Neo-Aramaic", 
        "Standard Arabic", "Pidgin Madam"))
    expect_equal(lang.country(c("North Korea", "Lebanon"), list = TRUE), list(c("Korean"), c("English", 
        "French", "Assyrian Neo-Aramaic", "Northern Kurdish", "Armenian", "North Levantine Arabic", 
        "Turoyo", "Chaldean Neo-Aramaic", "Standard Arabic", "Pidgin Madam")))
})
