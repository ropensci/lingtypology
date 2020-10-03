#' Get kernel density estimation poligon from coordinates
#'
#' This function is based on this answer: https://gis.stackexchange.com/a/203623/
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param latitude.width bandwidths for latitude values. Defaults to normal reference bandwidth (see \link{bandwidth.nrd}).
#' @param longitude.width bandwidths for longitude values. Defaults to normal reference bandwidth (see \link{bandwidth.nrd}).
#'
#' @importFrom stats density
#' @importFrom stats sd

polygon.points_kde <- function(latitude,
                               longitude,
                               latitude.width,
                               longitude.width) {

  if(requireNamespace("MASS", quietly = TRUE)&
     requireNamespace("sp", quietly = TRUE)) {

  ifelse(
    is.null(latitude.width),
    latitude.width <- MASS::bandwidth.nrd(latitude),
    latitude.width <- latitude.width*(length(latitude)*0.002+
                                        stats::sd(latitude)*0.16+
                                        stats::sd(longitude)*0.15)
  )
  ifelse(
    is.null(longitude.width),
    longitude.width <- MASS::bandwidth.nrd(longitude),
    longitude.width <- longitude.width*(length(longitude)*0.003+
                                          stats::sd(latitude)*0.11+
                                          stats::sd(longitude)*0.18)
  )
  kde <- MASS::kde2d(
    longitude,
    latitude,
    n = 100,
    h = c(longitude.width, latitude.width),
    lims = c(
      min(stats::density(longitude)$x) - stats::sd(longitude),
      max(stats::density(longitude)$x) + stats::sd(longitude),
      min(stats::density(latitude)$x) - stats::sd(latitude),
      max(stats::density(latitude)$x) + stats::sd(latitude)
    )
  )
  CL <- grDevices::contourLines(kde$x , kde$y , kde$z)
  level <-
    vapply(seq_along(CL), function(x)
      CL[[x]]$level, FUN.VALUE = 1)
  CL <- CL[which(level %in% min(level))]
  pgons <- lapply(seq_along(CL), function(i) {
    sp::Polygons(list(sp::Polygon(cbind(CL[[i]]$x, CL[[i]]$y))), ID = i)
  })
  sp::SpatialPolygons(pgons)
  } else {
    message("your density.estimation argument call needs packages 'MASS' and 'sp' to be installed")
  }
}
