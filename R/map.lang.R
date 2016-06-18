#' Map a set of linguoids
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

map.lang <- function(x){
  input <- tolower(x)
  link <- NA
  lat <- NA
  long <- NA
  for (i in 1:length(x)) {
    link[i] <- paste(c("<a href='",
                     "http://glottolog.org/resource/languoid/iso/",
                     glottolog[tolower(glottolog$languoid) == input[i],]$iso,
                     "' target='_blank'>",
                     x[i],
                     "</a>"), sep = "", collapse = "")
    lat[i] <- glottolog[tolower(glottolog$languoid) == input[i],]$latitude
    long[i] <- glottolog[tolower(glottolog$languoid) == input[i],]$longitude
  }
  map.df <- data.frame(x, link, lat, long)
  map.df <- map.df[stats::complete.cases(map.df),]
  m <- leaflet::leaflet(map.df) %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(lng=map.df$long,
                              lat=map.df$lat,
                              popup= map.df$link,
                              stroke = T,
                              radius = 5,
                              fillOpacity = 1,
                              group = map.df$x) %>%
    leaflet::addLayersControl(overlayGroups = map.df$x,
                              options = layersControlOptions(collapsed = F))
  m}
