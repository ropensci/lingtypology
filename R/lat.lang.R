#' Get latitude by language
#'
#' Takes any vector of languages and returns latitude.
#' @param x A character vector of the languages (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{gltc.lang}}, \code{\link{iso.lang}}, \code{\link{long.lang}}, \code{\link{subc.lang}}, \code{\link{url.lang}}
#' @examples
#' lat.lang('Kabardian')
#' long.lang('Kabardian')
#' lat.lang(c('Kabardian', 'Russian'))
#' long.lang(c('Kabardian', 'Russian'))
#' @export

lat.lang <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y),]$latitude,
      NA_real_
    )
  }, double(1))
}
