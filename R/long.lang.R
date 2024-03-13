#' Get longitude by language
#'
#' Takes any vector of languages and returns longitude.
#' @param x A character vector of the languages (can be written in lower case)
#' @param map.orientation A character verctor with values "Pacific" and "Atlantic". It distinguishes Pacific-centered and Atlantic-centered maps. By default is "Pacific".
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{gltc.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}},  \code{\link{subc.lang}}, \code{\link{url.lang}}
#' @examples
#' lat.lang('Kabardian')
#' long.lang('Kabardian')
#' lat.lang(c('Kabardian', 'Russian'))
#' long.lang(c('Kabardian', 'Russian'))
#' long.lang(c('Kabardian', 'Aleut'), map.orientation = "Pacific")
#' @export

long.lang <- function(x,
                      map.orientation = "Pacific") {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  result <- vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y),]$longitude,
      NA_real_
    )
  }, double(1))
  if (map.orientation == "Atlantic") {
    am <- grep("America", area.lang(x))
    result[am] <- result[am] - 360
  }
  return(result)
}
