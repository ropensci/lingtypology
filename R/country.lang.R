#' Get subclassification by language
#'
#' Takes any vector of languages and returns countries where those languages are used as ISO 3166-1 alpha-2 codes.
#' @param x A character vector of the languages (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang.R}}, \code{\link{area.lang.R}}, \code{\link{gltc.lang.R}}, \code{\link{iso.lang.R}}, \code{\link{lat.lang.R}}, \code{\link{long.lang.R}}, \code{\link{subc.lang.R}}, \code{\link{url.lang.R}}
#' @examples
#' country.lang('Korean')
#' subc.lang(c('Korean', 'Lechitic'))
#' @export

country.lang <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y), ]$countries,
      NA_character_
    )
  }, character(1))
}
