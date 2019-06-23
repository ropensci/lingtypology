#' Create a map with ggplot2
#'
#' Map a set of languages and color them by feature.
#'
#' @author George Moroz <agricolamz@gmail.com>
#' @param languages character vector of languages (can be written in lower case).
#' @param features character vector of features.
#' @param latitude numeric vector of latitudes.
#' @param longitude numeric vector of longitudes.
#' @param color vector of colors or palette. The color argument can be (1) a character vector of RGM or named colors; (2) the name of an RColorBrewer palette; (3) the full name of a viridis palette; (4) a function that receives a single value between 0 and 1 and returns a color. For more examples see \code{\link{colorNumeric}}.
#' @param title title of a legend.
#' @param legend logical. If TRUE, function show legend. By default is TRUE.
#' @param width a numeric vector of radius for circles or width for barcharts in minicharts.
#' @param opacity a numeric vector of marker opacity.
#' @param map.orientation a character verctor with values "Pacific" and "Atlantic". It distinguishes Pacific-centered and Atlantic-centered maps. By default is "Atlantic".
#' @param glottolog.source A character vector that define which glottolog database is used: "original" or "modified" (by default)
#' @examples
#' ggmap.feature(c("Adyghe", "Russian"))
#'
#' @export
#'

ggmap.feature <- function(languages,
                          features = "",
                          latitude = NA,
                          longitude = NA,
                          color = NULL,
                          title = NULL,
                          legend = TRUE,
                          width = 2,
                          opacity = 1,
                          map.orientation = "Atlantic",
                          glottolog.source = "modified"){
  if(!(requireNamespace("ggplot2", quietly = TRUE) &
       (requireNamespace("rgdal", , quietly = TRUE)))){
    warning('Install packages ggplot2 and rgdal:
  install.packages(c("ggplot2", "rgdal"))')
  }

    glottolog <- ifelse(
      grepl(glottolog.source, "original"),
      lingtypology::glottolog.original,
      lingtypology::glottolog.modified
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
    mapfeat.df <- data.frame(languages = unname(languages), features,
                             long = longitude,
                             lat = latitude)

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
    if (!is.null(color)) {
      my_colors <- color
    }

  places_wintri <- rgdal::project(cbind(mapfeat.df$long, mapfeat.df$lat),
                                  proj="+proj=wintri")
  places_wintri <- as.data.frame(places_wintri)
  mapfeat.df$long <- places_wintri[,1]
  mapfeat.df$lat <- places_wintri[,2]

  if(!is.numeric(mapfeat.df$features)){
    lingtypology::amap+
      ggplot2::geom_point(data = mapfeat.df, ggplot2::aes(mapfeat.df$long, mapfeat.df$lat, group=NULL, fill=NULL, color = features), size = width, alpha = opacity)+
      ggplot2::scale_color_manual(values = my_colors[1:length(unique(mapfeat.df$features))])  ->
      result.map
  } else {
    lingtypology::amap+
      ggplot2::geom_point(data = mapfeat.df, ggplot2::aes(mapfeat.df$long, mapfeat.df$lat, group=NULL, fill=NULL, color = features), size = width, alpha = opacity) ->
      result.map
  }

  if(length(unique(mapfeat.df$features)) < 2 | isFALSE(legend)){
    result.map +
      ggplot2::theme(legend.position = "none") ->
      result.map
    }

  result.map +
    ggplot2::labs(color = title)

}
