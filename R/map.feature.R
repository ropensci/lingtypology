#' Map a set of linguoids and color them by feature
#'
#' Takes any vector of linguoids and return a map.
#' @param x A character vector of linguoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' map.lang(c("Adyghe", "Russian"))
#' ## Map all Slavic languages
#' map.lang(lang.aff(c("Slavic")))
#' @export
#' @import leaflet

map.feature <- function(languages, features = "none", popup = "",
                    #long = glottolog$longitude,
                    #lat = glottolog$latitude,
                    title = NULL){

  mycolors <- c("dodgerblue2","#E31A1C", "green4", "#6A3D9A", "#FF7F00", "skyblue2","#FB9A99",  "palegreen2", "#CAB2D6",  "#FDBF6F", "gray70", "khaki2", "maroon","orchid1","deeppink1","blue1","steelblue4", "darkturquoise","green1","yellow4","yellow3", "darkorange4","brown")

  mapfeat.df <- data.frame(languages, features,
                           long = long.lang(languages),
                           lat = lat.lang(languages),
                           popup = popup)

  mapfeat.df$link <- makelink(as.character(mapfeat.df$languages), popup = mapfeat.df$popup)
  mapfeat.df <- mapfeat.df[stats::complete.cases(mapfeat.df),]
  pal <- leaflet::colorFactor(mycolors[1:length(unique(mapfeat.df$features))],
                              domain = mapfeat.df$features)
  levels(mapfeat.df$features) <- paste(names(table(mapfeat.df$features)), " (", table(mapfeat.df$features), ")", sep = "")

  if (length(table(mapfeat.df$features)) <= 1){
    m <- leaflet::leaflet(mapfeat.df) %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                lat=mapfeat.df$lat,
                                popup= mapfeat.df$link,
                                stroke = T,
                                radius = 5,
                                fillOpacity = 1,
                                group = mapfeat.df$languages) %>%
      leaflet::addLayersControl(overlayGroups = mapfeat.df$languages,
                                options = layersControlOptions(collapsed = F))
    m
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
    leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                              options = layersControlOptions(collapsed = F)) %>%
    leaflet::addLegend(title = title,
                       position = c("bottomleft"),
                       pal = pal,
                       values = mapfeat.df$features,
                       opacity = 1)
  m
  }
  }
