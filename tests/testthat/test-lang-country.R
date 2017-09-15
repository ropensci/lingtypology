library(lingtypology)
context("Tests for lang.country function")

df <- data.frame(my_countries = c("North Korea", "Lebanon"))

test_that("lang.country", {
    expect_equal(lang.country(df), c("Korean", "French", "Turoyo", "Assyrian Neo-Aramaic", "Pidgin Madam", "Northern Kurdish", "Armenian", "English", "Chaldean Neo-Aramaic", "Standard Arabic", "North Levantine Arabic"))
    expect_equal(lang.country(c("North Korea", "Lebanon")), c("Korean", "French", "Turoyo", "Assyrian Neo-Aramaic", "Pidgin Madam", "Northern Kurdish", "Armenian", "English", "Chaldean Neo-Aramaic", "Standard Arabic", "North Levantine Arabic"))
    expect_equal(lang.country(c("North Korea", "Lebanon"), list = TRUE), list(c("Korean"), c("French", "Turoyo", "Assyrian Neo-Aramaic", "Pidgin Madam", "Northern Kurdish", "Armenian", "English", "Chaldean Neo-Aramaic", "Standard Arabic", "North Levantine Arabic")))
})

df <- data.frame(my_countries = c("Germany", "Luxembourg"))

test_that("lang.country official", {
  expect_equal(lang.country(df, official = TRUE), c("German", "French", "German", "Luxembourgish"))
  expect_equal(lang.country(c("Germany", "Luxembourg"), official = TRUE), c("German", "French", "German", "Luxembourgish"))
  expect_equal(lang.country(c("Germany", "Luxembourg"), official = TRUE, list = TRUE), list(c("German"), c("French", "German", "Luxembourgish")))
})
