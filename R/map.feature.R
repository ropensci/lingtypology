#' Create a map
#'
#' Map a set of linguoids and color them by feature or two sets of features.
#'
#' @param languages character vector of linguoids (can be written in lower case)
#' @param features character vector of features
#' @param stroke.features additional independent stroke features
#' @param popup character vector of strings that will appear in pop-up window
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param color vector of colors
#' @param stroke.color vector of stroke colors
#' @param image.url character vector of URLs with an images
#' @param image.width numeric vector of image widths
#' @param image.height numeric vector of image heights
#' @param image.X.shift numeric vector of image's X axis shift relative to the latitude-longitude point
#' @param image.Y.shift numeric vector of image's Y axis shift relative to the latitude-longitude point
#' @param title title of a legend
#' @param stroke.title title of a stroke-feature legend
#' @param control logical. If TRUE, function show layer control buttons. By default is TRUE.
#' @param legend logical. If TRUE, function show legend. By default is FALSE.
#' @param legend.opacity a numeric vector of legend opacity.
#' @param stroke.legend logical. If TRUE, function show stroke.legend. By default is FALSE.
#' @param stroke.legend.opacity a numeric vector of stroke.legend opacity.
#' @param radius a numeric vector of radii for the circles.
#' @param stroke.radius a numeric vector of stroke radii for the circles.
#' @param opacity a numeric vector of marker opacity.
#' @param stroke.opacity a numeric vector of stroke opacity.
#' @param tile a character verctor with a map tiles, popularized by Google Maps. See \href{https://leaflet-extras.github.io/leaflet-providers/preview/index.html}{here} for the complete set.
#' @param tile.name a character verctor with a user's map tiles' names
#' @param glottolog.source A character vector that define which glottolog database is used: "original" or "modified" (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' map.feature(c("Adyghe", "Russian"))
#'
#' ## All Sign languages
#' map.feature(lang.aff("Sign"))
#'
#' ## Map all Slavic languages
#' map.feature(lang.aff(c("Slavic")))
#'
#' ## Add control buttons
#' map.feature(c("Adyghe", "Russian"), control = TRUE)
#'
#' ## Color linguoids by feature
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"))
#' map.feature(df$lang, df$feature)
#' ## ... or add a control buttons for features
#' map.feature(df$lang, df$feature, control = TRUE)
#'
#' ## Adding pop-up
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup)
#'
#' ## Adding title
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup, title = "type of a language")
#'
#' ## Add your own coordinates
#' map.feature("Adyghe", latitude = 43, longitude = 57)
#'
#' ## Change map tile
#' map.feature("Adyghe", tile = "Thunderforest.OpenCycleMap")
#' map.feature("Adyghe", tile = c("OpenStreetMap.BlackAndWhite", "Thunderforest.OpenCycleMap"))
#' map.feature("Adyghe", tile = "Thunderforest.OpenCycleMap", tile.name = "colored")
#'
#' ## Add you own colors
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup, color = c("green", "navy"))
#'
#' ## Map two sets of features
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup,
#' stroke.features = df$popup)
#'
#' ## Add a pictures to plot
#' df <- data.frame(lang = c("Russian", "Russian"),
#' lat  = c(55.75, 59.95),
#' long = c(37.616667, 30.3),
#' urls = c("https://goo.gl/5OUv1E", "https://goo.gl/UWmvDw"))
#' map.feature(languages = df$lang,
#' latitude = df$lat,
#' longitude = df$long,
#' image.url = df$urls)
#'
#' @export
#' @import leaflet
#' @import stats
#' @import grDevices
#' @import rowr
#' @import magrittr
#'

map.feature <- function(languages,
                        features = "none",
                        popup = "",
                        stroke.features = NULL,
                        latitude = NULL,
                        longitude = NULL,
                        color = NULL,
                        stroke.color = NULL,
                        image.url = NULL,
                        image.width = 100,
                        image.height = 100,
                        image.X.shift = 0,
                        image.Y.shift = 0,
                        title = NULL,
                        stroke.title = NULL,
                        control = FALSE,
                        legend = TRUE,
                        legend.opacity = 1,
                        stroke.legend = TRUE,
                        stroke.legend.opacity = 1,
                        radius = 5,
                        stroke.radius = 9.5,
                        opacity = 1,
                        stroke.opacity = 1,
                        tile = "OpenStreetMap.Mapnik",
                        tile.name = NULL,
                        glottolog.source = "modified"){

  ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original, glottolog <- lingtypology::glottolog.modified)
  if(sum(is.glottolog(languages, response = T, glottolog.source = glottolog.source)) == 0){stop("There is no data to map")}

  # creat dataframe ---------------------------------------------------------
  if (is.null(latitude) & is.null(longitude)) {  # if there are no latitude and longitude
    mapfeat.df <- data.frame(languages, features,
                             long = long.lang(languages, glottolog.source = glottolog.source),
                             lat = lat.lang(languages, glottolog.source = glottolog.source),
                             popup = popup)
  } else {   # if there are latitude and longitude
    mapfeat.df <- data.frame(languages, features,
                             long = longitude,
                             lat = latitude,
                             popup = popup)
  }

  # remove any rows with NAs ------------------------------------------------
  mapfeat.df <- mapfeat.df[stats::complete.cases(mapfeat.df),]

  # creat link --------------------------------------------------------------
  mapfeat.df$link <- makelink(as.character(mapfeat.df$languages),
                              popup = mapfeat.df$popup,
                              glottolog.source = glottolog.source)


  # add images --------------------------------------------------------------
  if(!is.null(image.url)){
    mapfeat.image <- rowr::cbind.fill(mapfeat.df[,-2], data.frame(image.url))
    mapfeat.image <- mapfeat.image[stats::complete.cases(mapfeat.image),]
  }

  # create a stroke dataframe -----------------------------------------------
  if(!is.null(stroke.features)){
    mapfeat.stroke <- rowr::cbind.fill(mapfeat.df[,-2], data.frame(stroke.features))
    mapfeat.stroke <- mapfeat.stroke[stats::complete.cases(mapfeat.stroke),]
    }

  # creata a pallet ---------------------------------------------------------
  if (is.null(color)) {
    pal <- leaflet::colorFactor(sample(rainbow(length(unique(mapfeat.df$features))), length(unique(mapfeat.df$features))),
                                domain = mapfeat.df$features)
  } else {
    pal <- leaflet::colorFactor(color,
                                domain = mapfeat.df$features)
  }

  if(!is.null(stroke.features)){
    if (is.null(stroke.color)) {
      lev <- nlevels(as.factor(stroke.features[stats::complete.cases(stroke.features)]))
      strokecolors <- grDevices::gray(lev :0 / lev)
      stroke.pal <- leaflet::colorFactor(strokecolors,
                                domain = mapfeat.stroke$stroke.features)
      rev.stroke.pal <- leaflet::colorFactor(rev(strokecolors),
                                         domain = mapfeat.stroke$stroke.features)
      } else {
        stroke.pal <- leaflet::colorFactor(stroke.color,
                                           domain = mapfeat.stroke$stroke.features)
        rev.stroke.pal <- leaflet::colorFactor(rev(stroke.color),
                                           domain = mapfeat.stroke$stroke.features)
        }
    }

# change feature names ----------------------------------------------------
  levels(mapfeat.df$features) <- paste(names(table(mapfeat.df$features)), " (", table(mapfeat.df$features), ")", sep = "")

# change tile names if needed ---------------------------------------------
  ifelse(is.null(tile.name), tile.name <- tile, NA)
  if(length(tile.name) != length(tile)){
    tile.name <- tile
    ifelse(length(tile.name) > length(tile),
           warning("number of tiles (tile argument) is less than number of tile names (tile.name argument)", call. = F),
           warning("number of tile names (tile.name argument) is less than number of tiles (tile argument)", call. = F))
    }

# map: if there are only one feature -------------------------------------------
  if (length(table(mapfeat.df$features)) <= 1){
    if (is.null(color)) {
      color <- "blue"
    }
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles(tile[1]) %>%
      leaflet::addProviderTiles(tile[1], group = tile.name[1])
      if(length(tile) > 1){
        mapply(function(other.tiles, other.tile.names){
          m <<- m %>% leaflet::addProviderTiles(other.tiles, group = other.tile.names)
          }, tile[-1], tile.name[-1])
        }
    m <- m %>% leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                        lat=mapfeat.df$lat,
                                        popup= mapfeat.df$link,
                                        stroke = F,
                                        radius = radius,
                                        color = color,
                                        fillOpacity = opacity,
                                        group = mapfeat.df$languages)

    if(length(tile) > 1){
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          overlayGroups = mapfeat.df$languages,
          options = layersControlOptions(collapsed = FALSE))
      } else {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          options = layersControlOptions(collapsed = FALSE))
      }
    } else {
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$languages,
                                             options = layersControlOptions(collapsed = F))
      }
    }

    if (!is.null(image.url)) {
      m <- m %>% leaflet::addMarkers(lng=mapfeat.image$long,
                                     lat=mapfeat.image$lat,
                                     popup= mapfeat.image$link,
                                     icon = icons(
                                       iconUrl = as.character(mapfeat.image$image.url),
                                       iconWidth = image.width,
                                       iconHeight = image.height,
                                       iconAnchorX = - image.X.shift,
                                       iconAnchorY = image.Y.shift))
    }


# map: if there are stroke features ---------------------------------------
  } else if(!is.null(stroke.features)){
    m <- leaflet::leaflet(mapfeat.stroke) %>%
      leaflet::addTiles(tile[1]) %>%
      leaflet::addProviderTiles(tile[1], group = tile.name[1])
    if(length(tile) > 1){
      mapply(function(other.tiles, other.tile.names){
        m <<- m %>% leaflet::addProviderTiles(other.tiles, group = other.tile.names)
      }, tile[-1], tile.name[-1])
    }
    m <- m %>% leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
                                lat=mapfeat.stroke$lat,
                                popup= mapfeat.stroke$link,
                                stroke = F,
                                radius = stroke.radius*1.15,
                                fillOpacity = stroke.opacity,
                                color = "black") %>%
      leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
                                lat=mapfeat.stroke$lat,
                                popup= mapfeat.stroke$link,
                                stroke = F,
                                radius = stroke.radius,
                                fillOpacity = stroke.opacity,
                                color = stroke.pal(mapfeat.stroke$stroke.features),
                                group = mapfeat.stroke$stroke.features) %>%
      leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
                                lat=mapfeat.stroke$lat,
                                popup= mapfeat.df$link,
                                stroke = F,
                                radius = 1.15*radius,
                                fillOpacity = opacity,
                                color = rev.stroke.pal(mapfeat.stroke$stroke.features),
                                group = mapfeat.stroke$stroke.features) %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = F,
                                radius = radius,
                                fillOpacity = opacity,
                                color = pal(mapfeat.df$features),
                                group = mapfeat.df$features)
    if (legend == TRUE) {
      m <- m %>% leaflet::addLegend(title = title,
                               position = c("topright"),
                               pal = pal,
                               values = mapfeat.df$features,
                               opacity = legend.opacity)
      }
    if (stroke.legend == TRUE) {
      m <- m %>% leaflet::addLegend(title = stroke.title,
                           position = c("bottomleft"),
                           pal = stroke.pal,
                           values = mapfeat.stroke$stroke.features,
                           opacity = stroke.legend.opacity)
      }
    if (!is.null(image.url)) {
        m <- m %>% leaflet::addMarkers(lng=mapfeat.image$long,
                                       lat=mapfeat.image$lat,
                                       popup= mapfeat.image$link,
                                       icon = icons(
                                         iconUrl = as.character(mapfeat.image$image.url),
                                         iconWidth = image.width,
                                         iconHeight = image.height,
                                         iconAnchorX = - image.X.shift,
                                         iconAnchorY = image.Y.shift))
      }

    if(length(tile) > 1){
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          overlayGroups = mapfeat.df$features,
          options = layersControlOptions(collapsed = FALSE))
      } else {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          options = layersControlOptions(collapsed = FALSE))
      }
    } else {
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                                             options = layersControlOptions(collapsed = F))
      }
    }

# map: if there are more than one feature -------------------------------------------
  } else{
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles(tile[1]) %>%
      leaflet::addProviderTiles(tile[1], group = tile.name[1])
    if(length(tile) > 1){
      mapply(function(other.tiles, other.tile.names){
        m <<- m %>% leaflet::addProviderTiles(other.tiles, group = other.tile.names)
      }, tile[-1], tile.name[-1])
    }
    m <- m %>% leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                         lat=mapfeat.df$lat,
                                         popup= mapfeat.df$link,
                                         stroke = F,
                                         radius = radius,
                                         fillOpacity = opacity,
                                         color = pal(mapfeat.df$features),
                                         group = mapfeat.df$features)

    if(length(tile) > 1){
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          overlayGroups = mapfeat.df$features,
          options = layersControlOptions(collapsed = FALSE))
      } else {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          options = layersControlOptions(collapsed = FALSE))
      }
    } else {
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                                             options = layersControlOptions(collapsed = F))
      }
    }

    if (!is.null(image.url)) {
      m <- m %>% leaflet::addMarkers(lng=mapfeat.image$long,
                                     lat=mapfeat.image$lat,
                                     popup= mapfeat.image$link,
                                     icon = icons(
                                       iconUrl = as.character(mapfeat.image$image.url),
                                       iconWidth = image.width,
                                       iconHeight = image.height,
                                       iconAnchorX = - image.X.shift,
                                       iconAnchorY = image.Y.shift))
    }
    if (legend == TRUE) {
      m <- m  %>% leaflet::addLegend(title = title,
                                     position = c("bottomleft"),
                                     pal = pal,
                                     values = mapfeat.df$features,
                                     opacity = opacity)
      }
  }
m
}
