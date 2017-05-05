#' Get kernel density estimation poligon from coordinates
#'
#' This function is based on this answer: https://gis.stackexchange.com/a/203623
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param latitude_width bandwidths for latitude values. Defaults to normal reference bandwidth (see \link{bandwidth.nrd}).
#' @param longitude_width bandwidths for longitude values. Defaults to normal reference bandwidth (see \link{bandwidth.nrd}).
#'
#' @importFrom MASS kde2d
#' @importFrom MASS bandwidth.nrd
#' @importFrom stats density
#' @importFrom stats sd
#' @importFrom sp Polygons
#' @importFrom sp SpatialPolygons

polygon.points <- function(latitude,
                           longitude,
                           latitude_width, longitude_width){
  ifelse(is.null(latitude_width),
         latitude_width <- MASS::bandwidth.nrd(latitude),
         latitude_width)
  ifelse(is.null(longitude_width),
         longitude_width <- MASS::bandwidth.nrd(longitude),
         longitude_width)
  kde <- MASS::kde2d(longitude,
                 latitude,
                 n = 100,
                 h = c(longitude_width, latitude_width),
                 lims = c(min(stats::density(longitude)$x)-stats::sd(longitude),
                          max(stats::density(longitude)$x)+stats::sd(longitude),
                          min(stats::density(latitude)$x)-stats::sd(latitude),
                          max(stats::density(latitude)$x)+stats::sd(latitude)))
  CL <- grDevices::contourLines(kde$x , kde$y , kde$z)
  level <- vapply(seq_along(CL), function(x) CL[[x]]$level, FUN.VALUE = 1)
  CL <- CL[which(level %in% min(level))]
  pgons <- lapply(seq_along(CL), function(i){
    sp::Polygons(list(sp::Polygon(cbind(CL[[i]]$x, CL[[i]]$y))), ID=i)})
  sp::SpatialPolygons(pgons)
}
