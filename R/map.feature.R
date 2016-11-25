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
#' ## Use strokes for aditional features
#' map.feature(df$language, features = df$languoid, stroke.features = df$language, latitude = df$latitude, longitude = df$longitude, control = F)
#' @export
#' @import leaflet
#' @import stats
#' @import grDevices

map.feature <- function(languages,
                        features = "none",
                        stroke.features = NULL,
                        popup = "",
                        latitude = NULL,
                        longitude = NULL,
                        color = NULL,
                        stroke.color = NULL,
                        title = NULL,
                        control = TRUE,
                        ...){

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

  ifelse(is.null(stroke.features),
         mapfeat.df,
         mapfeat.df$stroke.features <- stroke.features)


  # creat link --------------------------------------------------------------
  mapfeat.df$link <- makelink(as.character(mapfeat.df$languages), popup = mapfeat.df$popup)

  # remove any rows with NAs ------------------------------------------------
  mapfeat.df <- mapfeat.df[stats::complete.cases(mapfeat.df),]

  # creata a pallet ---------------------------------------------------------
  if (is.null(color)) {
    pal <- leaflet::colorFactor(sample(mycolors, length(unique(mapfeat.df$features))),
                                domain = mapfeat.df$features)
  } else {
    pal <- leaflet::colorFactor(color,
                                domain = mapfeat.df$features)
  }

  if(!is.null(stroke.features)){
    mystrokecolors <- grDevices::gray(length(stroke.features):0 / length(stroke.features))
    if (is.null(stroke.color)) {
      stroke.pal <- leaflet::colorFactor(mystrokecolors,
                                domain = mapfeat.df$stroke.features)
      } else {
        stroke.pal <- leaflet::colorFactor(stroke.color,
                                           domain = mapfeat.df$stroke.features)
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
                                stroke = T,
                                radius = 5,
                                color = color,
                                fillOpacity = 1,
                                group = mapfeat.df$languages)
    if (control == TRUE) {
    m <- m %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$languages,
                                options = layersControlOptions(collapsed = F))
    }

# map: if there are stroke features ---------------------------------------
  } else if(!is.null(stroke.features)){
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = F,
                                radius = 9.5,
                                fillOpacity = 1,
                                color = stroke.pal(mapfeat.df$stroke.features),
                                group = mapfeat.df$stroke.features) %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = F,
                                radius = 5,
                                fillOpacity = 0.6,
                                color = pal(mapfeat.df$features),
                                group = mapfeat.df$features) %>%
      leaflet::addLegend(title = title,
                         position = c("bottomleft"),
                         pal = pal,
                         values = mapfeat.df$features,
                         opacity = 1) %>%
      leaflet::addLegend(title = "",
                         position = c("bottomleft"),
                         pal = stroke.pal,
                         values = mapfeat.df$stroke.features,
                         opacity = 1)
    if (control == TRUE) {
      m <- m  %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                                            options = layersControlOptions(collapsed = F))
    }
    # map: if there are more than one feature -------------------------------------------
  } else{
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = T,
                                radius = 5,
                                fillOpacity = 1,
                                color = pal(mapfeat.df$features),
                                group = mapfeat.df$features) %>%
      leaflet::addLegend(title = title,
                         position = c("bottomleft"),
                         pal = pal,
                         values = mapfeat.df$features,
                         opacity = 1)
    if (control == TRUE) {
    m <- m  %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                                          options = layersControlOptions(collapsed = F))
    }
  }
m
}
