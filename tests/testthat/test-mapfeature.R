library(lingtypology)
context("Tests for map.feature function")

df <-  data.frame("Abkhaz")
map <- map.feature("Abkhaz")
map2 <- map.feature("Abkhazian", glottolog.source = "o")
map3 <- map.feature(data.frame("Abkhaz"))

test_that("map.feature source", {
  expect_equal(exists("map"), TRUE)
  expect_equal(exists("map"), TRUE)
  expect_equal(exists("map3"), TRUE)
  expect_equal(exists("map2"), TRUE)
  expect_warning(
    map.feature(c("Abkhazian", "Adyghe")),
    "Language Abkhazian is absent in our version of the Glottolog database. Did you mean Akkadian, Abkhaz?"
  )
  expect_warning(
    map.feature(c("Abkhaz", "Adyghe"), glottolog.source = "o"),
    "Language Abkhaz is absent in our version of the Glottolog database. Did you mean Akha?"
  )
})

test_that("map.feature no coordinates", {
  expect_warning(map.feature(c("Yugul", "Adyghe", "Selako")),
                 "There is no coordinates for languages Yugul, Selako")
})

test_that("map.feature no data to map", {
  expect_error(
    expect_warning(
      map.feature("bla-bla-bla"),
      "Languoid bla-bla-bla is absent in our version of the Glottolog database. Did you mean Blablanga?",
      ignore.case = T
    ),
    "There is no data to map"
  )
})

map_coord <- map.feature("Abkhaz", latitude = 43, longitude = 57)

test_that("map.feature coordinates", {
  expect_equal(map$x$limits[[1]][1], unname(lat.lang("Abkhaz")))
  expect_equal(map$x$limits[[2]][1], unname(long.lang("Abkhaz")))
  expect_equal(map_coord$x$limits[[1]][1], 43)
  expect_equal(map_coord$x$limits[[2]][1], 57)
})

density1 <- map.feature(
  circassian$language,
  circassian$language,
  longitude = circassian$longitude,
  latitude = circassian$latitude,
  density.estimation = circassian$language,
  density.width = 0.15
)

density2 <- map.feature(
  circassian$language,
  circassian$language,
  longitude = circassian$longitude,
  latitude = circassian$latitude,
  density.estimation = circassian$language,
  density.points = FALSE,
  density.width = 0.15
)

density3 <- map.feature(
  circassian$language,
  circassian$language,
  longitude = circassian$longitude,
  latitude = circassian$latitude,
  density.estimation = circassian$language,
  density.control = TRUE,
  density.width = 0.15
)

density4 <- map.feature(
  circassian$language,
  circassian$language,
  longitude = circassian$longitude,
  latitude = circassian$latitude,
  density.estimation = circassian$language,
  density.method = "kernal",
  density.control = TRUE,
  density.width = c(1.9, 1.2)
)

test_that("map.feature density estimation", {
  expect_equal(exists("density1"), TRUE)
  expect_equal(exists("density2"), TRUE)
  expect_equal(exists("density3"), TRUE)
})

map_image <-
  map.feature("Tabasaran", image.url = "https://goo.gl/Ycn6tJ")

test_that("map.feature images", {
  expect_equal(map_image$x$calls[[5]]$args[[3]]$iconUrl$data,
               "https://goo.gl/Ycn6tJ")
})

df <-
  data.frame(
    lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
    feature = c("polysynthetic",
                "polysynthetic", "fusion", "fusion", "fusion"),
    popup = c("Circassian", "Circassian", "Slavic",
              "Slavic", "Slavic")
  )
map_stroke <-
  map.feature(df$lang, df$feature, df$popup, stroke.features = df$popup)
map_stroke2 <-
  map.feature(
    df$lang,
    df$feature,
    df$popup,
    stroke.features = df$popup,
    stroke.color = c("blue",
                     "green")
  )

test_that("map.feature stroke feature", {
  expect_equal(length(map_stroke$x$calls), 10)
  expect_equal(
    map_stroke2$x$calls[[4]]$args[[6]]$fillColor,
    c("#0000FF", "#0000FF", "#00FF00",
      "#00FF00", "#00FF00")
  )
})

map_colorless <- map.feature(c("Tabasaran", "Adyghe"))
map_lang_colors <- map.feature(c("Tabasaran", "Adyghe"),
                               color = "navy")
map_colors <- map.feature(
  c("Tabasaran", "Adyghe"),
  features = c("a", "b"),
  color = c("navy", "yellowgreen")
)
map_colors2 <- map.feature(
  c("Tabasaran", "Adyghe"),
  features = c(1, 2),
  color = c("navy", "yellowgreen")
)
map_colorless2 <- map.feature(c("Tabasaran", "Adyghe"),
                              features = c(1, 2))

test_that("map.feature colors", {
  expect_equal(map_colors$x$calls[[4]]$args[6][[1]]$color, c("#000080", "#9ACD32"))
  expect_equal(map_colors2$x$calls[[4]]$args[6][[1]]$color, c("#000080", "#9ACD32"))
  expect_equal(map_colorless$x$calls[[4]]$args[6][[1]]$color,
               c("#1F77B4", "#1F77B4"))
  expect_equal(map_colorless2$x$calls[[4]]$args[6][[1]]$color,
               c("#F7FCFD", "#4D004B"))
  expect_equal(map_lang_colors$x$calls[[4]]$args[6][[1]]$color,
               c("#000080", "#000080"))
  expect_equal(
    map_stroke$x$calls[[4]]$args[6][[1]]$color,
    c("#FFFFFF", "#FFFFFF", "#000000", "#000000", "#000000")
  )
})

map_tiles <-
  map.feature("Adyghe",
              tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"))
map_tiles_control <-
  map.feature(
    "Adyghe",
    tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"),
    control = TRUE
  )

test_that("map.feature tiles", {
  expect_equal(
    c(map_tiles$x$calls[[2]]$args[[1]], map_tiles$x$calls[[3]]$args[[1]]),
    c(
      "OpenStreetMap.BlackAndWhite",
      "Thunderforest.OpenCycleMap"
    )
  )
  expect_equal(
    c(
      map_tiles_control$x$calls[[2]]$args[[1]],
      map_tiles_control$x$calls[[3]]$args[[1]]
    ),
    c(
      "OpenStreetMap.BlackAndWhite",
      "Thunderforest.OpenCycleMap"
    )
  )
  expect_warning(
    map.feature(
      "Adyghe",
      tile = c(
        "OpenStreetMap.BlackAndWhite",
        "Thunderforest.OpenCycleMap"
      ),
      tile.name = c("first")
    ),
    "number of tile names \\(tile.name argument\\) is less than number of tiles \\(tile argument\\)"
  )
  expect_warning(
    map.feature(
      "Adyghe",
      tile = c("OpenStreetMap.BlackAndWhite"),
      tile.name = c("first", "second")
    ),
    'number of tile names \\(tile.name argument\\) is less than number of tiles \\(tile argument\\)'
  )
})

map_control <- map.feature(c("Adyghe", "Russian"), control = TRUE)

test_that("control", {
  expect_equal(map_control$x$calls[[5]]$method, "addLayersControl")
})

map_minimap <- map.feature(c("Adyghe", "Russian"), minimap = TRUE)

test_that("map.feature minimap", {
  expect_equal(map_minimap$x$calls[[6]]$method, "addMiniMap")
})

test_that("map.feature scale bar", {
  expect_equal(map_minimap$x$calls[[5]]$method, "addScaleBar")
})

map_label <-
  map.feature(c("Adyghe", "Russian"), label = c("a", "b"))
test_that("map.feature labels", {
  expect_equal(map_label$x$calls[[4]]$args[11], list(c("a", "b")))
})

map_label_emph <-
  map.feature(
    c("Adyghe", "Russian"),
    label = c("a", "b"),
    label.emphasize = list(1, "red")
  )
test_that("map.feature emphasized labels", {
  expect_equal(map_label_emph$x$calls[[5]]$args[11], list(c("a")))
  expect_equal(map_label_emph$x$calls[[5]]$args[12][[1]]$style$color, "red")
})

map_zoom <-
  map.feature(c("Adyghe", "Russian"), zoom.level = 4)
test_that("map.feature emphasized labels", {
  expect_equal(map_zoom$x$setView[[2]], 4)
})

map_rectangular <-
  map.feature(
    circassian$language,
    circassian$language,
    longitude = circassian$longitude,
    latitude = circassian$latitude,
    rectangle.lng = c(42.7, 45),
    rectangle.lat = c(42.7, 44.3),
    rectangle.color = "blue"
  )

test_that("map.feature rectangular", {
  expect_equal(map_rectangular$x$calls[[3]]$method, "addRectangles")
})

map_minicharts <-
  map.feature(
    languages = ejective_and_n_consonants$language,
    minichart.data = ejective_and_n_consonants[, c("vowels", "consonants")],
    minichart = "pie"
  )

test_that("map.feature minicharts", {
  expect_equal(exists("map_minicharts"), TRUE)
})

line <- map.feature(
  circassian$language,
  circassian$language,
  longitude = circassian$longitude,
  latitude = circassian$latitude,
  line.lng = c(43, 45),
  line.lat = c(43, 44)
)

line.logit <- map.feature(
  circassian$language,
  circassian$language,
  longitude = circassian$longitude,
  latitude = circassian$latitude,
  line.type = "logit"
)

test_that("map.feature lines", {
  expect_equal(line$x$calls[[3]]$method, "addPolylines")
  expect_equal(line.logit$x$calls[[3]]$method, "addPolylines")
  expect_warning(
    map.feature(
      circassian$language,
      circassian$dialect,
      longitude = circassian$longitude,
      latitude = circassian$latitude,
      line.type = "logit"
    ),
    "If you want to plot the decision boundary of the logistic regression, the argument features should contain two levels."
  )
})

graticule <- map.feature(c("Russian", "Adyghe"), graticule = 5)

test_that("map.feature graticule", {
  expect_equal(graticule$x$calls[[3]]$method, "addSimpleGraticule")
})


shape1 <- map.feature(df$lang,
                      df$feature,
                      shape = TRUE)
shape2 <- map.feature(df$lang,
                      df$feature,
                      shape = c("f", "p"))
shape3 <- map.feature(df$lang,
                      df$feature,
                      shape = c("p", "p", "f", "f", "f"))

test_that("map.feature shape", {
  expect_equal(shape1$x$calls[[3]]$args[[11]], c("▴", "▴", "●", "●", "●"))
  expect_equal(shape2$x$calls[[3]]$args[[11]], c("p", "p", "f", "f", "f"))
  expect_equal(shape3$x$calls[[3]]$args[[11]], c("p", "p", "f", "f", "f"))
  expect_warning(map.feature(lang.aff("Slavic")[-3],
                           lang.aff("Slavic")[-3],
                           shape = TRUE),
               'The argument "shape = TRUE" works fine only with 6 or less levels in "features" variable. List your own shapes in "shape" argument')
})


map_none_tile <- map.feature("Adyghe", tile = "none")

test_that("map without a tile", {
  expect_equal(exists("map_none_tile"), TRUE)
})
