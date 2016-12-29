#' Create a map
#'
#' Map a set of linguoids and color them by feature
#'
#' Takes any vector of linguoids and return a map.
#' @param languages character vector of linguoids (can be written in lower case)
#' @param features character vector of features
#' @param stroke.features additional independent stroke features
#' @param popup character vector of strings that will appear in pop-up window
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param color vector of colors
#' @param stroke.color vector of stroke colors
#' @param title of a legend
#' @param control logical. If FALSE, function doesn't show layer control buttons.
#' @param legend logical. If FALSE, function doesn't show legend.
#' @param radius a numeric vector of radii for the circles.
#' @param stroke.radius a numeric vector of stroke radii for the circles.
#' @param opacity a numeric vector of marker opacity.
#' @param stroke.opacity a numeric vector of stroke opacity.
#' @param ...	further arguments of leaflet package.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' map.feature(c("Adyghe", "Russian"))
#'
#' ## Map all Slavic languages
#' map.feature(lang.aff(c("Slavic")))
#'
#' ## Color linguoids by feature
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"))
#' map.feature(df$lang, df$feature)
#'
#' ## Adding pop-up
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup)
#'
#' ## Adding title
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup, title = "type of a language")
#'
#' ## Add your own coordinates
#' map.feature("Adyghe", latitude = 43, longitude = 57)
#'
#' ## Add you own colors
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Adyghe", "Adyghe", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup, color = c("green", "navy"))
#'
#' ## Remove control buttons
#' map.feature(lang.aff("Sign"), control = FALSE)
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
                        title = NULL,
                        control = TRUE,
                        legend = TRUE,
                        radius = 5,
                        stroke.radius = 9.5,
                        opacity = 1,
                        stroke.opacity = 1,
                        ...){

  if(sum(is.glottolog(languages, response = T)) == 0){stop("There is no data to map")}
  # 23 color set --------------------------------------------------------------
  mycolors <- c("dodgerblue2","#E31A1C", "green4", "#6A3D9A", "#FF7F00", "skyblue2","#FB9A99",  "palegreen2", "#CAB2D6",  "#FDBF6F", "gray70", "khaki2", "maroon","orchid1","deeppink1","blue1","steelblue4", "darkturquoise","green1","yellow4","yellow3", "darkorange4","brown")

  # creat dataframe ---------------------------------------------------------
  if (is.null(latitude) & is.null(longitude)) {  # if there are no latitude and longitude
    mapfeat.df <- data.frame(languages, features,
                             long = long.lang(languages),
                             lat = lat.lang(languages),
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
  mapfeat.df$link <- makelink(as.character(mapfeat.df$languages), popup = mapfeat.df$popup)

  # create a stroke dataframe -----------------------------------------------
  if(!is.null(stroke.features)){
    mapfeat.stroke <- rowr::cbind.fill(mapfeat.df[,-2], data.frame(stroke.features))
    mapfeat.stroke$long <- as.numeric(levels(mapfeat.stroke$long))[mapfeat.stroke$long]
    mapfeat.stroke$lat <- as.numeric(levels(mapfeat.stroke$lat))[mapfeat.stroke$lat]
    mapfeat.stroke <- mapfeat.stroke[stats::complete.cases(mapfeat.stroke),]}

  # creata a pallet ---------------------------------------------------------
  if (is.null(color)) {
    pal <- leaflet::colorFactor(sample(mycolors, length(unique(mapfeat.df$features)), replace = T),
                                domain = mapfeat.df$features)
  } else {
    pal <- leaflet::colorFactor(color,
                                domain = mapfeat.df$color)
  }

  if(!is.null(stroke.features)){
    if (is.null(stroke.color)) {
      lev <- nlevels(stroke.features[stats::complete.cases(stroke.features)])
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

# map: if there are only one feature -------------------------------------------
  if (length(table(mapfeat.df$features)) <= 1){
    if (is.null(color)) {
      color <- "blue"
    }
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = F,
                                radius = radius,
                                color = color,
                                fillOpacity = opacity,
                                group = mapfeat.df$languages)
    if (control == TRUE) {
    m <- m %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$languages,
                                options = layersControlOptions(collapsed = F))
    }

# map: if there are stroke features ---------------------------------------
  } else if(!is.null(stroke.features)){
    m <- leaflet::leaflet(mapfeat.stroke) %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
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
                               opacity = opacity) %>%
        leaflet::addLegend(title = "",
                           position = c("bottomleft"),
                           pal = stroke.pal,
                           values = mapfeat.stroke$stroke.features,
                           opacity = 1)
      }
    # map: if there are more than one feature -------------------------------------------
  } else{
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = F,
                                radius = radius,
                                fillOpacity = opacity,
                                color = pal(mapfeat.df$features),
                                group = mapfeat.df$features)
    if (control == TRUE) {
    m <- m  %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                                          options = layersControlOptions(collapsed = F))
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
