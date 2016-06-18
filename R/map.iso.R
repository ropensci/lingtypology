#' Map a set of linguoids
#'
#' Takes any vector of ISO codes and return a map.
#' @param x A character vector of ISO codes
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' map.iso(c("ady", "rus"))
#' @export
#' @import leaflet

map.iso <- function(x){
  input <- tolower(x)
  link <- NA
  lat <- NA
  long <- NA
  lang <- NA
  for (i in 1:length(x)) {
    link[i] <- paste(c("<a href='",
                       "http://glottolog.org/resource/languoid/iso/",
                       glottolog[tolower(glottolog$iso) == input[i],]$iso,
                       "' target='_blank'>",
                       glottolog[tolower(glottolog$iso) == input[i],]$languoid,
                       "</a>"), sep = "", collapse = "")
    lat[i] <- glottolog[tolower(glottolog$iso) == input[i],]$latitude
    long[i] <- glottolog[tolower(glottolog$iso) == input[i],]$longitude
    lang[i] <- glottolog[tolower(glottolog$iso) == input[i],]$languoid
  }
  map.df <- data.frame(lang, link, lat, long)
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
