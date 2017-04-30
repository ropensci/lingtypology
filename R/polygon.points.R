#' Get kernel density estimation poligon from coordinates
#'
#' This function is based on this answer: https://gis.stackexchange.com/a/203623
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#'
#' @importFrom MASS kde2d
#' @importFrom stats density
#' @importFrom sp Polygons
#' @importFrom sp SpatialPolygons

polygon.points <- function(latitude, longitude){
  kde <- MASS::kde2d(longitude,
                     latitude,
                     n = 100,
                     lims = c(min(stats::density(longitude)$x),
                              max(stats::density(longitude)$x),
                              min(stats::density(latitude)$x),
                              max(stats::density(latitude)$x)))
  CL <- grDevices::contourLines(kde$x , kde$y , kde$z)
  pgons <- lapply(1:length(CL), function(i){
    sp::Polygons(list(sp::Polygon(cbind(CL[[i]]$x, CL[[i]]$y))), ID=i)})
  sp::SpatialPolygons(pgons)
}
