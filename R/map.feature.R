#' Create a map
#'
#' Map a set of languages and color them by feature or two sets of features.
#'
#' @param languages character vector of languages (can be written in lower case)
#' @param features character vector of features
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param stroke.features additional independent stroke features
#' @param density.estimation additional independent features, used for density estimation
#' @param popup character vector of strings that will appear in pop-up window
#' @param label character vector of strings that will appear near points
#' @param minimap logical. If TRUE, function shows mini map. By default is FALSE.
#' @param tile a character verctor with a map tiles, popularized by Google Maps. See \href{https://leaflet-extras.github.io/leaflet-providers/preview/index.html}{here} for the complete set.
#' @param glottolog.source A character vector that define which glottolog database is used: "original" or "modified" (by default)
#' @param color vector of colors or palette. The color argument can be (1) a character vector of RGM or named colors; (2) the name of an RColorBrewer palette; (3) the full name of a viridis palette; (4) a function that receives a single value between 0 and 1 and returns a color. For more examples see \code{\link{colorNumeric}}
#' @param control logical. If TRUE, function show layer control buttons. By default is FALSE
#' @param density.method string with one of the two methods: "kernal density estimation" or "fixed distance" (default)
#' @param density.estimation.color vector of density polygons' colors
#' @param density.estimation.opacity a numeric vector of density polygons opacity.
#' @param density.legend logical. If TRUE, function show legend for density features. By default is FALSE.
#' @param density.legend.opacity a numeric vector of density-legend opacity.
#' @param density.legend.position the position of the legend: "topright", "bottomright", "bottomleft","topleft"
#' @param density.width for density.method = "fixed distance" it is a numeric measure (1 is 1km). For density.method = "kernal density estimation" it is a vector with two meausures (first is latitude, secong is longitude). Defaults are normal reference bandwidth (see \link{bandwidth.nrd}).
#' @param density.points logical. If FALSE, it doesn't show points in polygones.
#' @param density.title title of a density-feature legend
#' @param density.control logical. If TRUE, function show layer control buttons for density plot. By default is FALSE
#' @param isogloss dataframe with corresponding features
#' @param isogloss.color vector of isoglosses' colors
#' @param isogloss.opacity a numeric vector of density polygons opacity.
#' @param isogloss.line.width a numeric value for line width
#' @param isogloss.width for density.method = "fixed distance" it is a numeric measure (1 is 1km). For density.method = "kernal density estimation" it is a vector with two meausures (first is latitude, secong is longitude). Defaults are normal reference bandwidth (see \link{bandwidth.nrd}).
#' @param image.height numeric vector of image heights
#' @param image.url character vector of URLs with an images
#' @param image.width numeric vector of image widths
#' @param image.X.shift numeric vector of image's X axis shift relative to the latitude-longitude point
#' @param image.Y.shift numeric vector of image's Y axis shift relative to the latitude-longitude point
#' @param label.fsize numeric value of the label font size. By default is 14.
#' @param label.hide logical. If FALSE, labels are displayed allways. If TRUE, labels are displayed on mouse over. By default is TRUE.
#' @param label.font string with values of generic family: "serif", "sans-serif", "monospace", or font name e. g. "Times New Roman"
#' @param label.position the position of labels: "left", "right", "top", "bottom"
#' @param label.emphasize is the list. First argument is a vector of points in datframe that should be emphasized. Second argument is a string with a color for emphasis.
#' @param legend logical. If TRUE, function show legend. By default is TRUE.
#' @param legend.opacity a numeric vector of legend opacity.
#' @param legend.position the position of the legend: "topright", "bottomright", "bottomleft","topleft"
#' @param shape \enumerate{ \item if TRUE, creates icons (up to five categories) for values in the \code{features} variable; \item it also could be a vector of any strings that represents the levels of the  \code{features} variable; \item it also could be a string vector that represents the number of observations in dataset.}
#' @param shape.size size of the \code{shape} icons
#' @param shape.color color of the \code{shape} icons
#' @param facet character vector that provide a grouping variable. If it is no \code{NULL}, then as a result a list of leaflets for \code{sync} or \code{latticeView} functions from \code{mapview} package is returned.
#' @param pipe.data this variable is important, when you use map.feature with dplyr pipes. Expected usage: pipe.data = .
#' @param map.orientation a character verctor with values "Pacific" and "Atlantic". It distinguishes Pacific-centered and Atlantic-centered maps. By default is "Pacific".
#' @param minimap.height The height of the minimap in pixels.
#' @param minimap.position the position of the minimap: "topright", "bottomright", "bottomleft","topleft"
#' @param minimap.width The width of the minimap in pixels.
#' @param minichart citation from leaflet.minicharts package: "Possible values are "bar" for bar charts, "pie" for pie charts, "polar-area" and "polar-radius"."
#' @param minichart.data citation from leaflet.minicharts package: "A numeric matrix with number of rows equal to the number of elements in lng or lat and number of column equal to the number of variables to represent. If parameter time is set, the number of rows must be equal to the length of lng times the number of unique time steps in the data."
#' @param minichart.time citation from leaflet.minicharts package: "A vector with length equal to the number of rows in chartdata and containing either numbers representing time indices or dates or datetimes. Each unique value must appear as many times as the others. This parameter can be used when one wants to represent the evolution of some variables on a map."
#' @param minichart.labels citation from leaflet.minicharts package: "Should values be displayed above chart elements."
#' @param opacity a numeric vector of marker opacity.
#' @param width a numeric vector of radius for circles or width for barcharts in minicharts.
#' @param scale.bar logical. If TRUE, function shows scale-bar. By default is TRUE.
#' @param scale.bar.position the position of the scale-bar: "topright", "bottomright", "bottomleft","topleft"
#' @param stroke.color vector of stroke colors
#' @param stroke.legend logical. If TRUE, function show stroke.legend. By default is FALSE.
#' @param stroke.legend.opacity a numeric vector of stroke.legend opacity.
#' @param stroke.legend.position the position of the stroke.legend: "topright", "bottomright", "bottomleft","topleft"
#' @param stroke.opacity a numeric vector of stroke opacity.
#' @param stroke.radius a numeric vector of stroke radii for the circles.
#' @param stroke.title title of a stroke-feature legend.
#' @param tile.name a character verctor with a user's map tiles' names.
#' @param title title of a legend.
#' @param rectangle.lng vector of two longitude values for rectangle.
#' @param rectangle.lat vector of two latitude values for rectangle.
#' @param rectangle.color vector of rectangle border color.
#' @param line.lng vector of two (or more) longitude values for line.
#' @param line.lat vector of two (or more) latitude values for line.
#' @param line.type a character string indicating which type of line is to be computed. One of "standard" (default), or "logit". The first one should be combined with the arguments line.lat and line.lng and provide simple lines. Other variant "logit" is the decision boundary of the logistic regression made using longitude and latitude coordinates (works only if feature argument have two levels).
#' @param line.color vector of line color.
#' @param line.label character vector that will appear near the line.
#' @param line.opacity a numeric vector of line opacity.
#' @param line.width a numeric vector of line width.
#' @param graticule a numeric vector for graticule spacing in map units between horizontal and vertical lines.
#' @param zoom.control logical. If TRUE, function shows zoom controls. By default is FALSE.
#' @param zoom.level a numeric value of the zoom level.
#' @param radius deprecated argument
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' map.feature(c("Adyghe", "Russian"))
#'
#' ## Map all Slavic languages
#' map.feature(lang.aff(c("Slavic")))
#'
#' ## Color languages by feature
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"))
#' map.feature(df$lang, df$feature)
#'
#' ## Add your own coordinates
#' map.feature("Adyghe", latitude = 43, longitude = 57)
#'
#' ## Change map tile
#' map.feature("Adyghe", tile = "Thunderforest.OpenCycleMap")
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
#' ## Add a minimap to plot
#' map.feature(c("Adyghe", "Russian"), minimap = TRUE)
#'
#' ## Remove scale bar
#' map.feature(c("Adyghe", "Russian"), scale.bar = FALSE)
#'
#' @export
#' @importFrom leaflet colorNumeric
#' @importFrom leaflet colorFactor
#' @importFrom leaflet leaflet
#' @importFrom leaflet addTiles
#' @importFrom leaflet addProviderTiles
#' @importFrom leaflet addPolygons
#' @importFrom leaflet addSimpleGraticule
#' @importFrom leaflet addPolylines
#' @importFrom leaflet addCircleMarkers
#' @importFrom leaflet addMarkers
#' @importFrom leaflet addLabelOnlyMarkers
#' @importFrom leaflet addControl
#' @importFrom leaflet addLayersControl
#' @importFrom leaflet addScaleBar
#' @importFrom leaflet addLegend
#' @importFrom leaflet addMiniMap
#' @importFrom leaflet leafletOptions
#' @importFrom leaflet labelOptions
#' @importFrom leaflet layersControlOptions
#' @importFrom leaflet icons
#' @importFrom stats complete.cases
#' @importFrom stats sd
#' @importFrom stats glm
#' @importFrom stats binomial
#' @importFrom stats coef
#' @importFrom grDevices gray
#' @importFrom grDevices topo.colors
#' @importFrom rowr cbind.fill
#' @importFrom magrittr %>%
#' @importFrom leaflet.minicharts addMinicharts
#' @importFrom leaflet.minicharts popupArgs
#' @export %>%

map.feature <- function(languages,
                        features = "",
                        label = "",
                        popup = "",
                        latitude = NA,
                        longitude = NA,
                        label.hide = TRUE,
                        label.fsize = 15,
                        label.font = "sans-serif",
                        label.position = "right",
                        label.emphasize = list(NULL, "black"),
                        shape = NULL,
                        shape.size = 20,
                        pipe.data = NULL,
                        shape.color = "black",
                        stroke.features = NULL,
                        density.estimation = NULL,
                        density.method = "fixed distance",
                        density.estimation.color = NULL,
                        density.estimation.opacity = 0.6,
                        density.points = TRUE,
                        density.width = NULL,
                        density.legend = TRUE,
                        density.legend.opacity = 1,
                        density.legend.position = "bottomleft",
                        density.title = "",
                        density.control = FALSE,
                        isogloss = NULL,
                        isogloss.color = "black",
                        isogloss.opacity = 0.2,
                        isogloss.line.width = 3,
                        isogloss.width = NULL,
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
                        legend.position = "topright",
                        stroke.legend = TRUE,
                        stroke.legend.opacity = 1,
                        stroke.legend.position = "bottomleft",
                        width = 5,
                        stroke.radius = 9.5,
                        opacity = 1,
                        stroke.opacity = 1,
                        scale.bar = TRUE,
                        scale.bar.position = "bottomleft",
                        minimap = FALSE,
                        minimap.position = "bottomright",
                        minimap.width = 150,
                        minimap.height = 150,
                        facet = NULL,
                        tile = "OpenStreetMap.Mapnik",
                        tile.name = NULL,
                        zoom.control = FALSE,
                        zoom.level = NULL,
                        rectangle.lng = NULL,
                        rectangle.lat = NULL,
                        rectangle.color = "black",
                        line.lng = NULL,
                        line.lat = NULL,
                        line.type = "standard",
                        line.color = "black",
                        line.opacity = 0.8,
                        line.label = NULL,
                        line.width = 3,
                        graticule = NULL,
                        minichart = NULL,
                        minichart.data = NULL,
                        minichart.time = NULL,
                        minichart.labels = FALSE,
                        map.orientation = "Pacific",
                        glottolog.source = "modified",
                        radius = NULL) {
  if(!is.null(radius)){
    warning("The radius argument is deprecated. Use width argument instead.")
  }
  ifelse(
    grepl(glottolog.source, "original"),
    glottolog <- lingtypology::glottolog.original,
    glottolog <- lingtypology::glottolog.modified
  )
  if (typeof(languages) == "list") {
    languages <- unlist(languages)
  }
  if(!("fake" %in% tolower(languages))){
  if (sum(is.glottolog(
    languages,
    response = TRUE,
    glottolog.source = glottolog.source
  )) == 0) {
    stop("There is no data to map")
  }}

  # create dataframe ---------------------------------------------------------
  mapfeat.df <- data.frame(languages, features,
                           popup = popup,
                           long = longitude,
                           lat = latitude)
  if (sum(label == "") != length(label)) {
    mapfeat.df$label <- as.character(label)
    if (!is.null(label.emphasize[[1]])) {
      mapfeat.df$emph <- "emph"
      mapfeat.df$emph[-label.emphasize[[1]]] <- "no"
    }
  }

  if (!is.null(density.estimation)) {
    mapfeat.df$density.estimation <- density.estimation
  }

  if (!is.null(isogloss)) {
    mapfeat.df <- cbind(mapfeat.df, isogloss)
  }

  # if there are no latitude and longitude

  if (sum(is.na(latitude) &
          is.na(longitude)) == length(latitude & longitude)) {
    mapfeat.df$long <- long.lang(languages,
                                 map.orientation = map.orientation,
                                 glottolog.source = glottolog.source)
    mapfeat.df$lat <-
      lat.lang(languages, glottolog.source = glottolog.source)
  } else {
    # if there are latitude and longitude
    mapfeat.df$long <- longitude
    mapfeat.df$lat <- latitude
  }

  if (!is.null(facet)) {
    mapfeat.df <- cbind(mapfeat.df, facet)
  }

  # if there are no coordinates... ------------------------------------------
  if (sum(is.na(mapfeat.df$long & mapfeat.df$lat)) > 0) {
    warning(paste(
      "There is no coordinates for languages",
      paste(mapfeat.df$languages[is.na(mapfeat.df$long &
                                         mapfeat.df$lat)],
            collapse = ", ")
    ),
    call. = FALSE)
  }

  # remove any rows with NAs ------------------------------------------------
  mapfeat.df <- mapfeat.df[stats::complete.cases(mapfeat.df), ]

  # create link --------------------------------------------------------------
  mapfeat.df$link <- url.lang(
    as.character(mapfeat.df$languages),
    popup = mapfeat.df$popup,
    glottolog.source = glottolog.source
  )

  # add images --------------------------------------------------------------
  if (!is.null(image.url)) {
    mapfeat.image <-
      rowr::cbind.fill(mapfeat.df[, -2], data.frame(image.url))
    mapfeat.image <-
      mapfeat.image[stats::complete.cases(mapfeat.image), ]
  }

  # create a stroke dataframe -----------------------------------------------
  if (!is.null(stroke.features)) {
    mapfeat.stroke <- rowr::cbind.fill(mapfeat.df[, -2],
                                       data.frame(stroke.features))
    mapfeat.stroke <-
      mapfeat.stroke[stats::complete.cases(mapfeat.stroke), ]
  }

  # create a palette ---------------------------------------------------------
  set.seed(45)
  my_colors <-
    c(
      "#1f77b4",
      "#ff7f0e",
      "#2ca02c",
      "#d62728",
      "#9467bd",
      "#8c564b",
      "#e377c2",
      "#7f7f7f",
      "#17becf",
      sample(grDevices::colors()[!grepl("ivory|azure|white|gray|grey|black|pink|1",
                                        grDevices::colors())])
    )
  if (is.null(color)) {
    if (is.numeric(mapfeat.df$features)) {
      pal <-
        leaflet::colorNumeric(palette = "BuPu", domain = mapfeat.df$features)
    } else {
      pal <-
        leaflet::colorFactor(my_colors[1:length(unique(mapfeat.df$features))],
                             domain = mapfeat.df$features)
    }
  } else {
    if (is.numeric(mapfeat.df$features)) {
      pal <-
        leaflet::colorNumeric(palette = color, domain = mapfeat.df$features)
    } else {
      if (length(mapfeat.df$features) == length(color)) {
        df <- unique(data.frame(feature = mapfeat.df$features, color))
        color <- as.character(df[order(df$feature), ]$color)
      }
      pal <-
        leaflet::colorFactor(color, domain = mapfeat.df$features)
    }
  }

  if (is.null(density.estimation.color)) {
    if (is.numeric(mapfeat.df$density.estimation)) {
      density.estimation.pal <-
        leaflet::colorNumeric(palette = "BuPu",
                              domain = mapfeat.df$density.estimation)
    } else {
      set.seed(45)
      density.estimation.pal <-
        leaflet::colorFactor(c(rev(my_colors[1:9]), my_colors[10:329])[1:length(unique(mapfeat.df$density.estimation))],
                             domain = mapfeat.df$density.estimation)
    }
  } else {
    if (length(mapfeat.df$density.estimation) == length(density.estimation.color)) {
      df <-
        unique(
          data.frame(
            feature = mapfeat.df$density.estimation,
            color = density.estimation.color
          )
        )
      density.estimation.color <-
        as.character(df[order(df$feature), ]$color)
    }
    density.estimation.pal <-
      leaflet::colorFactor(unique(density.estimation.color),
                           domain = mapfeat.df$density.estimation)
  }

  if (!is.null(stroke.features)) {
    if (is.null(stroke.color)) {
      lev <-
        nlevels(as.factor(stroke.features[stats::complete.cases(stroke.features)]))
      strokecolors <- grDevices::gray(lev:0 / lev)
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

  # change tile names if needed ---------------------------------------------
  ifelse(is.null(tile.name), tile.name <- tile, NA)
  if (length(tile.name) != length(tile)) {
    tile.name <- tile
    ifelse(length(tile.name) > length(tile),
           warning(
             'number of tiles (tile argument) is less than number of tile names (tile.name argument)',
             call. = FALSE
           ),
           warning(
             'number of tile names (tile.name argument) is less than number of tiles (tile argument)',
             call. = FALSE
           ))
  }

  # create a density polygones --------------------------------------------
  if (!is.null(density.estimation)) {
    my_poly_names <-
      names(which(table(mapfeat.df$density.estimation) > 1))
    if(density.method != "fixed distance"){
    my_poly <- lapply(my_poly_names, function(feature) {
      polygon.points_kde(
        mapfeat.df[mapfeat.df$density.estimation == feature, 'lat'],
        mapfeat.df[mapfeat.df$density.estimation == feature, 'long'],
        latitude_width = density.width[1],
        longitude_width = density.width[2]
      )
    })
    } else{
      my_poly <- lapply(my_poly_names, function(feature) {
        polygon.points_fd(
          mapfeat.df[mapfeat.df$density.estimation == feature, 'lat'],
          mapfeat.df[mapfeat.df$density.estimation == feature, 'long'],
          width = density.width)
      })
    }
    }


# create isogloss -------------------------------------------------------

  if (!is.null(isogloss)) {
    if (length(isogloss) > 1) {
      isogloss.list <- apply(isogloss, 2, unique)
      isogloss.df <- data.frame(value = NA, variable = NA)

      sapply(seq_along(isogloss.list), function(i) {
        sapply(seq_along(isogloss.list[[i]]), function(j) {
          if (sum(isogloss[, names(isogloss.list[i])] %in%
                  isogloss.list[[i]][j]) > 1) {
            isogloss.df <<-
              rbind(
                isogloss.df,
                data.frame(
                  value = isogloss.list[[i]][j],
                  variable = names(isogloss.list[i]),
                  stringsAsFactors = FALSE
                )
              )
          }
        })
      })
      isogloss.df <- isogloss.df[-1,]
    } else {
      if(!is.data.frame(isogloss)){
        isogloss <- as.data.frame(isogloss,
                                  stringsAsFactors = FALSE,
                                  col.names = "feature")
      }
      isogloss.vector <- unlist(isogloss)
      isogloss.list <- unique(isogloss.vector)
      isogloss.df <- data.frame(value = NA, variable = NA)
      sapply(seq_along(isogloss.list), function(i) {
        if (sum(isogloss.vector %in% isogloss.list[i]) > 1) {
          isogloss.df <<- rbind(
            isogloss.df,
            data.frame(
              value = isogloss.list[i],
              variable = names(isogloss),
              stringsAsFactors = FALSE
            )
          )
        }
      })
      isogloss.df <- isogloss.df[-1,]
    }
  my_isogloss <- lapply(1:nrow(isogloss.df), function(i) {
    if(density.method != "fixed distance"){
        polygon.points_kde(
          mapfeat.df[mapfeat.df[, isogloss.df[i,2]] == isogloss.df[i,1], 'lat'],
          mapfeat.df[mapfeat.df[, isogloss.df[i,2]] == isogloss.df[i,1], 'long'],
          latitude_width = isogloss.width[1],
          longitude_width = isogloss.width[2])
    } else{
        polygon.points_fd(
          mapfeat.df[mapfeat.df[, isogloss.df[i,2]] == isogloss.df[i,1], 'lat'],
          mapfeat.df[mapfeat.df[, isogloss.df[i,2]] == isogloss.df[i,1], 'long'],
          width = isogloss.width)
    }
    })

  }


# create labels -----------------------------------------------------------

  offset <- ifelse(label.position == "right",
                   1,
                   ifelse(label.position == "left",-1,
                          0))

  ### create a map ------------------------------------------------------------
  if (!is.null(pipe.data)) {
    m <- pipe.data
  } else {
    m <- leaflet::leaflet(
      mapfeat.df,
      option = leaflet::leafletOptions(zoomControl = zoom.control))
  }
  if (!("none" %in% tile)) {
    m <- m %>%
      leaflet::addTiles(tile[1]) %>%
      leaflet::addProviderTiles(tile[1], group = tile.name[1])
    if (length(tile) > 1) {
      mapply(function(other.tiles, other.tile.names) {
        m <<- m %>% leaflet::addProviderTiles(other.tiles,
                                              group = other.tile.names)
      }, tile[-1], tile.name[-1])
    }
  }

  # map: add rectangle ------------------------------------------------------
  if (!is.null(rectangle.lng) & !is.null(rectangle.lat)) {
    m <- m %>% leaflet::addRectangles(
      lng1 = rectangle.lng[1],
      lat1 = rectangle.lat[1],
      lng2 = rectangle.lng[2],
      lat2 = rectangle.lat[2],
      color = rectangle.color,
      opacity = 1,
      weight = 3,
      fillColor = "transparent"
    )
  }

  # map: add line ----------------------------------------------------------------
  if (line.type == "standard") {
    if (!is.null(line.lng) & !is.null(line.lat)) {
      m <- m %>% leaflet::addPolylines(
        lat = line.lat,
        lng = line.lng,
        color = line.color,
        opacity = line.opacity,
        label = line.label,
        labelOptions = leaflet::labelOptions(
          noHide = !(label.hide),
          direction = label.position,
          offset = c(label.fsize*offset/2, 0),
          textOnly = TRUE,
          style = list(
            "font-size" = paste0(label.fsize, "px"),
            "font-family" = label.font,
            "color" = label.emphasize[[2]]
          )
        ),
        weight = line.width
      )
    }
  } else if (line.type == "logit") {
    if (length(table(mapfeat.df$features)) == 2) {
      logit <-
        stats::glm(mapfeat.df$features ~ mapfeat.df$long + mapfeat.df$lat,
                   family = stats::binomial)
      slope <- stats::coef(logit)[2] / (-stats::coef(logit)[3])
      intercept <- stats::coef(logit)[1] / (-stats::coef(logit)[3])
      line.lat <- range(mapfeat.df$lat) +
        c(-stats::sd(mapfeat.df$lat), stats::sd(mapfeat.df$lat))
      line.lng <-  (line.lat - intercept) / slope
      m <- m %>% leaflet::addPolylines(
        lat = line.lat,
        lng = line.lng,
        color = line.color,
        opacity = line.opacity,
        label = line.label,
        labelOptions = leaflet::labelOptions(
          noHide = !(label.hide),
          direction = label.position,
          offset = c(label.fsize*offset/2, 0),
          textOnly = TRUE,
          style = list(
            "font-size" = paste0(label.fsize, "px"),
            "font-family" = label.font,
            "color" = label.emphasize[[2]]
          )
        ),
        weight = line.width
      )
    } else{
      warning(
        "If you want to plot the decision boundary of the logistic regression, the argument features should contain two levels."
      )
    }
  }



  # if there is density estimation ------------------------------------------
  if (!is.null(density.estimation)) {
    lapply(seq_along(my_poly), function(x) {
      m <<- m %>% leaflet::addPolygons(
        data = my_poly[[x]],
        color = density.estimation.pal(my_poly_names[x]),
        opacity = 0.2,
        fillOpacity = density.estimation.opacity,
        group = my_poly_names[x]
      )
    })
  }

  # map: add isogloss ------------------------------------------
  if (!is.null(isogloss)) {
    lapply(seq_along(my_isogloss), function(x) {
      m <<- m %>% leaflet::addPolylines(
        data = my_isogloss[[x]],
        color = isogloss.color,
        opacity = isogloss.opacity,
        weight = isogloss.line.width,
        label = paste0(isogloss.df$variable, ": ", isogloss.df$value),
        labelOptions = leaflet::labelOptions(textOnly = TRUE)
      )
    })
  }
  # map: add graticule ------------------------------------------------------
  if (!is.null(graticule)) {
    m <- m %>% leaflet::addSimpleGraticule(interval = graticule)
  }

  # map: if there are stroke features ---------------------------------------
  if (!is.null(stroke.features)) {
    m <- m %>% leaflet::addCircleMarkers(
      lng = mapfeat.stroke$long,
      lat = mapfeat.stroke$lat,
      popup = mapfeat.stroke$link,
      stroke = FALSE,
      radius = stroke.radius * 1.15,
      fillOpacity = stroke.opacity,
      color = "black"
    ) %>%
      leaflet::addCircleMarkers(
        lng = mapfeat.stroke$long,
        lat = mapfeat.stroke$lat,
        popup = mapfeat.stroke$link,
        stroke = FALSE,
        radius = stroke.radius,
        fillOpacity = stroke.opacity,
        color = stroke.pal(mapfeat.stroke$stroke.features),
        group = mapfeat.stroke$stroke.features
      ) %>%
      leaflet::addCircleMarkers(
        lng = mapfeat.stroke$long,
        lat = mapfeat.stroke$lat,
        popup = mapfeat.df$link,
        labelOptions = leaflet::labelOptions(
          noHide = !(label.hide),
          direction = label.position,
          offset = c(label.fsize*offset/2, 0),
          textOnly = TRUE,
          style = list("font-size" = paste0(label.fsize, "px"),
                       "font-family" = label.font)
        ),
        stroke = FALSE,
        radius = 1.15 * width,
        fillOpacity = opacity,
        color = rev.stroke.pal(mapfeat.stroke$stroke.features),
        group = mapfeat.stroke$stroke.features
      )
  }

  # map: add points ----------------------------------------
  if (density.points != FALSE &
      is.null(minichart) &
      is.null(shape)) {
    m <- m %>% leaflet::addCircleMarkers(
      lng = mapfeat.df$long,
      lat = mapfeat.df$lat,
      popup = mapfeat.df$link,
      stroke = FALSE,
      radius = width * 1.1,
      fillOpacity = opacity,
      color = "black",
      group = mapfeat.df$features
    ) %>%
      leaflet::addCircleMarkers(
        lng = mapfeat.df$long,
        lat = mapfeat.df$lat,
        popup = mapfeat.df$link,
        stroke = FALSE,
        radius = width,
        fillOpacity = opacity,
        color = pal(mapfeat.df$features),
        group = mapfeat.df$features,
        label = mapfeat.df$label,
        labelOptions = leaflet::labelOptions(
          noHide = !(label.hide),
          direction = label.position,
          offset = c(label.fsize*offset/2, 0),
          textOnly = TRUE,
          style = list("font-size" = paste0(label.fsize, "px"),
                       "font-family" = label.font)
        )
      )
  }

  # map: add minicharts -----------------------------------------------------

  if (!is.null(minichart) & is.null(shape)) {
    if (is.null(color)) {
      color = my_colors
    }

    # create tables for each popup
    tables <- ""
    if (length(colnames(minichart.data)) > 1) {
      new <-
        as.data.frame(matrix(paste0(
          rep(colnames(minichart.data), each = nrow(minichart.data)),
          ": ",
          as.matrix(minichart.data),
          "<br> "
        ), ncol = length(colnames(
          minichart.data
        ))))
      df_args <- c(new, sep = "")
      tables <- do.call(paste, df_args)
    }

    mapfeat.df$link <- paste0(mapfeat.df$link, tables)

    m <- m %>% leaflet.minicharts::addMinicharts(
      lng = mapfeat.df$long,
      lat = mapfeat.df$lat,
      chartdata = minichart.data,
      type = minichart,
      legend = legend,
      width = 7 * width,
      showLabels = minichart.labels,
      popup = leaflet.minicharts::popupArgs(html = mapfeat.df$link),
      time = minichart.time,
      legendPosition = legend.position,
      opacity = opacity,
      colorPalette = color,
      fillColor = color[1]
    )
  }

  # map: add shapes ---------------------------------------------------------
  if (!is.null(shape)) {
    if(isTRUE(shape)){
      icons <- c("\u25cf", "\u25b4", "\u25a0", "\u2b29", "\u25be", "\u25b0")[as.factor(mapfeat.df$features)]
      if(length(unique(mapfeat.df$features)) > 6){
        warning(
          'The argument "shape = TRUE" works fine only with 6 or less levels in "features" variable. List your own shapes in "shape" argument',
          call. = FALSE)
        }
    } else if(length(shape) == length(as.factor(mapfeat.df$features))){
      icons <- as.character(shape)
    } else{
      icons <- as.character(shape[as.factor(mapfeat.df$features)])
    }

    m <- m %>% leaflet::addCircleMarkers(
      lng = mapfeat.df$long,
      lat = mapfeat.df$lat,
      label = icons,
      opacity = 0,
      fillOpacity = 0,
      labelOptions = leaflet::labelOptions(
        noHide = TRUE,
        textOnly = TRUE,
        textsize = paste0(shape.size, "px"),
        direction = "center",
        style = list("color" = shape.color,
                     "font-family" = label.font)
      )
    ) %>%
      leaflet::addCircleMarkers(
        lng = mapfeat.df$long,
        lat = mapfeat.df$lat,
        popup = mapfeat.df$link,
        stroke = FALSE,
        radius = width,
        fillOpacity = 0,
        color = pal(mapfeat.df$features),
        group = mapfeat.df$features,
        label = mapfeat.df$label,
        labelOptions = leaflet::labelOptions(
          noHide = !(label.hide),
          direction = label.position,
          offset = c(label.fsize*offset/2, 0),
          textOnly = TRUE,
          style = list("font-size" = paste0(label.fsize, "px"),
                       "font-family" = label.font)
        )
      )
    if (legend == TRUE) {
      m <- m %>%
        leaflet::addControl(html = paste(
          collapse = "",
          ifelse(!is.null(title),
                 paste('<b>', title, "</b> <br>", collapse = ""),
                 ""
                 ),
          paste(
            '<b><font size="4">',
            unique(icons),
            '</font></b>',
            unique(as.factor(mapfeat.df$features)),
            "<br>",
            collapse = ""
          )
        ),
        position = legend.position)%>%
        leaflet::addCircleMarkers(
          lng = mapfeat.df$long,
          lat = mapfeat.df$lat,
          popup = mapfeat.df$link,
          stroke = FALSE,
          radius = width,
          fillOpacity = 0,
          color = pal(mapfeat.df$features),
          group = mapfeat.df$features,
          label = mapfeat.df$label,
          labelOptions = leaflet::labelOptions(
            noHide = !(label.hide),
            direction = label.position,
            offset = c(label.fsize*offset/2, 0),
            textOnly = TRUE,
            style = list("font-size" = paste0(label.fsize, "px"),
                         "font-family" = label.font)
          )
        )
    }}


    # add label emphasize -----------------------------------------------------

      if ("emph" %in% colnames(mapfeat.df)) {
        m <- m %>% leaflet::addCircleMarkers(
            lng = mapfeat.df[mapfeat.df$emph == "emph", ]$long,
            lat = mapfeat.df[mapfeat.df$emph == "emph", ]$lat,
            popup = mapfeat.df[mapfeat.df$emph == "emph", ]$link,
            label = mapfeat.df[mapfeat.df$emph == "emph", ]$label,
            stroke = FALSE,
            radius = width,
            fillOpacity = 0,
            labelOptions = leaflet::labelOptions(
              noHide = !(label.hide),
              direction = label.position,
              offset = c(label.fsize*offset/2, 0),
              textOnly = TRUE,
              style = list("font-size" = paste0(label.fsize, "px"),
                           "font-family" = label.font,
                           "color" = label.emphasize[[2]])),
            group = mapfeat.df$features
          )
      }

    # map: images -------------------------------------------------------------
    if (!is.null(image.url)) {
      m <- m %>% leaflet::addMarkers(
        lng = mapfeat.image$long,
        lat = mapfeat.image$lat,
        popup = mapfeat.image$link,
        icon = leaflet::icons(
          iconUrl = as.character(mapfeat.image$image.url),
          iconWidth = image.width,
          iconHeight = image.height,
          iconAnchorX = -image.X.shift,
          iconAnchorY = image.Y.shift
        )
      )
    }


    # map: tile and control interaction --------------------------------------
    if (length(tile) > 1) {
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          overlayGroups = mapfeat.df$features,
          options = leaflet::layersControlOptions(collapsed = FALSE)
        )
      } else if (density.control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          overlayGroups = my_poly_names,
          options = leaflet::layersControlOptions(collapsed = FALSE)
        )
      } else {
        m <- m %>% leaflet::addLayersControl(
          baseGroups = tile.name,
          options = leaflet::layersControlOptions(collapsed = FALSE)
        )
      }
    } else {
      if (control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          overlayGroups = mapfeat.df$features,
          options = leaflet::layersControlOptions(collapsed = FALSE)
        )
      } else if (density.control == TRUE) {
        m <- m %>% leaflet::addLayersControl(
          overlayGroups = my_poly_names,
          options = leaflet::layersControlOptions(collapsed = FALSE)
        )
      }
    }

    # map: ScaleBar -----------------------------------------------------------
    if (scale.bar == TRUE) {
      m <- m %>% leaflet::addScaleBar(position = scale.bar.position)
    }


    # map: legend -------------------------------------------------------------
    if (sum(mapfeat.df$features == "") < length(mapfeat.df$features) &
        legend == TRUE &
        is.null(minichart) &
        is.null(shape)) {
      m <- m %>% leaflet::addLegend(
        title = title,
        position = legend.position,
        pal = pal,
        values = mapfeat.df$features,
        opacity = legend.opacity
      )
    } else if(sum(mapfeat.df$features == "") == length(mapfeat.df$features) &
              !is.null(title)){
      m <- m %>% leaflet::addControl(
        html = paste('<b>', title, "</b>"),
        position = legend.position)
    }

    # map: stroke.legend ------------------------------------------------------
    if (!is.null(stroke.features) & stroke.legend == TRUE) {
      m <- m %>% leaflet::addLegend(
        title = stroke.title,
        position = stroke.legend.position,
        pal = stroke.pal,
        values = mapfeat.stroke$stroke.features,
        opacity = stroke.legend.opacity
      )
    }

    # map: density.legend ------------------------------------------------------
    if (!is.null(density.estimation) & density.legend == TRUE) {
      m <- m %>% leaflet::addLegend(
        title = density.title,
        position = density.legend.position,
        pal = density.estimation.pal,
        values = mapfeat.df$density.estimation,
        opacity = density.legend.opacity
      )
    }

    # map: MiniMap ------------------------------------------------------------
    if (minimap == TRUE) {
      m <- m %>% leaflet::addMiniMap(
        tiles = tile[1],
        position = minimap.position,
        width = minimap.width,
        height = minimap.height,
        toggleDisplay = TRUE
      )
    }

    # zoom.level argument -----------------------------------------------------
    if (!is.null(zoom.level)) {
      m <- m %>% leaflet::setView(
        lng = mean(mapfeat.df$long),
        lat = mean(mapfeat.df$lat),
        zoom = zoom.level
      )
    }

# facetisation ------------------------------------------------------------
  if(!is.null(facet)){
    facet_levels <- unique(mapfeat.df$facet)
    list <- lapply(facet_levels, function(i){
      df <- mapfeat.df[mapfeat.df$facet == i,]
      map.feature <- map.feature(df$languages,
                                 features = df$features,
                                 label = df$label,
                                 popup = df$popup,
                                 latitude = df$lat,
                                 longitude = df$long,
                                 density.estimation = df$density.estimation,
                                 stroke.features = stroke.features[mapfeat.df$facet == i],
                                 isogloss = isogloss[mapfeat.df$facet == i,],
                                 title = paste(i, ifelse(title == "", "", paste("<br>", title))),
                                 minichart.data = minichart.data[mapfeat.df$facet == i,],
                                 minichart.time = minichart.time[mapfeat.df$facet == i,],
                                 minichart.labels = minichart.labels,
                                 shape = shape,
                                 label.hide = label.hide,
                                 label.fsize = label.fsize,
                                 label.font = label.font,
                                 label.position = label.position,
                                 label.emphasize = label.emphasize,
                                 shape.size = shape.size,
                                 pipe.data = pipe.data,
                                 shape.color = shape.color,
                                 density.method = density.method,
                                 density.estimation.color = density.estimation.color,
                                 density.estimation.opacity = density.estimation.opacity,
                                 density.points = density.points,
                                 density.width = density.width,
                                 density.legend = density.legend,
                                 density.legend.opacity = density.legend.opacity,
                                 density.legend.position = density.legend.position,
                                 density.title = density.title,
                                 density.control = density.control,
                                 isogloss.color = isogloss.color,
                                 isogloss.opacity = isogloss.opacity,
                                 isogloss.line.width = isogloss.line.width,
                                 isogloss.width = isogloss.width,
                                 color = color,
                                 stroke.color = stroke.color,
                                 image.url = image.url,
                                 image.width = image.width,
                                 image.height = image.height ,
                                 image.X.shift = image.X.shift,
                                 image.Y.shift = image.Y.shift,
                                 stroke.title = stroke.title,
                                 control = control,
                                 legend = legend,
                                 legend.opacity = legend.opacity,
                                 legend.position = legend.position,
                                 stroke.legend = stroke.legend,
                                 stroke.legend.opacity = stroke.legend.opacity,
                                 stroke.legend.position = stroke.legend.position,
                                 width = width,
                                 stroke.radius = stroke.radius,
                                 opacity = opacity,
                                 stroke.opacity = stroke.opacity,
                                 scale.bar = scale.bar,
                                 scale.bar.position = scale.bar.position,
                                 minimap = minimap,
                                 minimap.position = minimap.position,
                                 minimap.width = minimap.width,
                                 minimap.height = minimap.height,
                                 facet = NULL,
                                 tile = tile,
                                 tile.name = tile.name,
                                 zoom.control = zoom.control,
                                 zoom.level = zoom.level,
                                 rectangle.lng = rectangle.lng,
                                 rectangle.lat = rectangle.lat,
                                 rectangle.color = rectangle.color,
                                 line.lng = line.lng,
                                 line.lat = line.lat,
                                 line.type = line.type,
                                 line.color = line.color,
                                 line.opacity = line.opacity,
                                 line.label = line.label,
                                 line.width = line.width,
                                 graticule = graticule,
                                 minichart = minichart,
                                 map.orientation = map.orientation,
                                 glottolog.source = glottolog.source,
                                 radius = radius)
    })
    return(list)
  } else{
    return(m)
  }
  }
