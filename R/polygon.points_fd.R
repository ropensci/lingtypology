#' Get poligons from fixed distance circles around coordinates
#'
#' This function is based on this answer: https://www.r-bloggers.com/merging-spatial-buffers-in-r/
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param width radius for creating poligons around points
#'
#' @importFrom sp SpatialPointsDataFrame
#' @importFrom rgeos gBuffer
#' @importFrom rgeos gIntersects
#' @importFrom rgeos gUnaryUnion

polygon.points_fd <- function(latitude, longitude, width) {
  if(is.null(width)){stop("Please specify a density.width argument.")}
  sp_fw <- sp::SpatialPointsDataFrame(
    coords = cbind(longitude, latitude),
    data = data.frame(longitude, latitude))

  buff <- rgeos::gBuffer(sp_fw, byid = TRUE, width = width, capStyle = "ROUND")
  gt <- rgeos::gIntersects(buff, byid = TRUE, returnDense = FALSE)
  ut <- unique(gt)
  while (sum(duplicated(unlist(unique(ut)))) > 0) {
    ut <- unique(sapply(ut, function(x)
      unique(unlist(ut[sapply(ut, function(y)
        any(x %in% y))]))))
    if (is.matrix(ut)) {
      ut <- list(`1` = ut[, 1])
    }
  }
  nth <- 1:length(ut)
  buff$n <- 1:nrow(buff)
  buff$nth <- NA
  sapply(seq_along(nth), function(i) {
    buff$nth[ut[[i]]] <<- i
  })
  buff <- rgeos::gUnaryUnion(buff, buff$nth)
  return(buff)
}
