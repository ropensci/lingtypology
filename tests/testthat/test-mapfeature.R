library(lingtypology)
library(magrittr)
library(leaflet)
context("Tests for map.feature function")

map <- map.feature("Tabasaran")
map2 <- map.feature("Tabassaran", glottolog.source = "o")

test_that("map.feature source", {
    expect_equal(exists("map"), TRUE)
    expect_equal(exists("map2"), TRUE)
    expect_warning(map.feature(c("Tabassaran", "Adyghe")), "Languoid Tabassaran is absent in our database. Did you mean Tabasaran?")
    expect_warning(map.feature(c("Tabasaran", "Adyghe"), glottolog.source = "o"), "Languoid Tabasaran is absent in our database. Did you mean Tabassaran?")
})

test_that("map.feature no data to map", {
    expect_error(expect_warning(map.feature("bla-bla-bla"), "Languoid bla-bla-bla is absent in our database. Did you mean Blablanga?",
        ignore.case = T), "There is no data to map")
})

map_coord <- map.feature("Tabasaran", latitude = 43, longitude = 57)

test_that("map.feature coordinates", {
    expect_equal(map$x$limits[[1]][1], unname(lat.lang("Tabasaran")))
    expect_equal(map$x$limits[[2]][1], unname(long.lang("Tabasaran")))
    expect_equal(map_coord$x$limits[[1]][1], 43)
    expect_equal(map_coord$x$limits[[2]][1], 57)
})

map_image <- map.feature("Tabasaran", image.url = "https://goo.gl/Ycn6tJ")

test_that("map.feature images", {
    expect_equal(map_image$x$calls[[4]]$args[[3]]$iconUrl$data, "https://goo.gl/Ycn6tJ")
})

df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"), feature = c("polysynthetic",
    "polysynthetic", "fusion", "fusion", "fusion"), popup = c("Circassian", "Circassian", "Slavic",
    "Slavic", "Slavic"))
map_stroke <- map.feature(df$lang, df$feature, df$popup, stroke.features = df$popup)
map_stroke2 <- map.feature(df$lang, df$feature, df$popup, stroke.features = df$popup, stroke.color = c("blue",
    "green"))

test_that("map.feature stroke feature", {
    expect_equal(length(map_stroke$x$calls), 9)
    expect_equal(map_stroke2$x$calls[[4]]$args[[6]]$fillColor, c("#0000FF", "#0000FF", "#00FF00",
        "#00FF00", "#00FF00"))
})

map_colorless <- map.feature(c("Tabasaran", "Adyghe"))
map_lang_colors <- map.feature(c("Tabasaran", "Adyghe"),
                          color = "navy")
map_colors <- map.feature(c("Tabasaran", "Adyghe"),
                          features = c("a", "b"),
                          color = c("navy", "yellowgreen"))

test_that("map.feature colors", {
    expect_equal(map_colors$x$calls[[3]]$args[6][[1]]$color, c("#000080", "#9ACD32"))
    expect_equal(map_colorless$x$calls[[3]]$args[6][[1]]$color, "blue")
    expect_equal(map_lang_colors$x$calls[[3]]$args[6][[1]]$color, "navy")
    expect_equal(map_stroke$x$calls[[3]]$args[6][[1]]$color, "black")
})

map_tiles <- map.feature("Adyghe", tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"))
map_tiles_control <- map.feature("Adyghe", tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"), control = TRUE)
test_that("map.feature tiles", {
    expect_equal(c(map_tiles$x$calls[[2]]$args[[1]], map_tiles$x$calls[[3]]$args[[1]]), c("OpenStreetMap.BlackAndWhite",
        "Thunderforest.OpenCycleMap"))
    expect_equal(c(map_tiles_control$x$calls[[2]]$args[[1]], map_tiles_control$x$calls[[3]]$args[[1]]), c("OpenStreetMap.BlackAndWhite",
                                                                                        "Thunderforest.OpenCycleMap"))
})

map_control <- map.feature(c("Adyghe", "Russian"), control = TRUE)

test_that("map.feature tiles", {
    expect_equal(map_control$x$calls[[4]]$method, "addLayersControl")
})

map_minimap <- map.feature(c("Adyghe", "Russian"), minimap = TRUE)

test_that("map.feature minimap", {
  expect_equal(map_minimap$x$calls[[5]]$method, "addMiniMap")
})

test_that("map.feature scale bar", {
  expect_equal(map_minimap$x$calls[[4]]$method, "addScaleBar")
})

map_label <- map.feature(c("Adyghe", "Russian"), label = c("a", "b"))
test_that("map.feature labels", {
  expect_equal(map_label$x$calls[[3]]$args[11], list(c("a", "b")))
})
