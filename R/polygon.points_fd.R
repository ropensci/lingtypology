#' Get polygons from fixed distance circles around coordinates
#'
#' This function is based on this answer: https://www.r-bloggers.com/merging-spatial-buffers-in-r/
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param width radius for creating poligons around points
#'

polygon.points_fd <- function(latitude, longitude, width) {
  if(requireNamespace("sf", quietly = TRUE)&
     requireNamespace("sp", quietly = TRUE)) {

  if(is.null(width)){stop("Please specify a density.width argument.")}
  sp_fw <- sf::st_as_sf(
    sp::SpatialPoints(
      coords = cbind(longitude, latitude)))

  buffer <- sf::st_buffer(sp_fw, dist = width, endCapStyle = "ROUND")
  intersection <- sf::st_union(buffer)
  return(intersection)
  } else {
    message("your density.estimation argument call needs packages 'sf' and 'sp' to be installed")
  }

}
