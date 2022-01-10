#' Get a level of language by language
#'
#' Takes any vector of languages and returns a level of language.
#' @param x character vector of the languages (can be written in lower case)
#' @author Sasha Shakhnova
#' @seealso \code{\link{aff.lang}}, \code{\link{country.lang}}, \code{\link{gltc.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}, \code{\link{subc.lang}}, \code{\link{url.lang}}
#' @examples
#' level.lang('Russian Sign Language')
#' level.lang(c('Archi', 'Chechen'))
#' @export

level.lang <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y),]$level,
      NA_character_
    )
  }, character(1))
}
