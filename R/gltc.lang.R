#' Get Glottocode by language
#'
#' Takes any vector of languages and returns Glottocode.
#' @param x A character vector of the languages (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang.R}}, \code{\link{area.lang.R}}, \code{\link{country.lang.R}}, \code{\link{iso.lang.R}}, \code{\link{lat.lang.R}}, \code{\link{long.lang.R}}, \code{\link{subc.lang.R}}, \code{\link{url.lang.R}}
#' @examples
#' gltc.lang('Adyghe')
#' gltc.lang(c('Adyghe', 'Udi'))
#' @export

gltc.lang <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y),]$glottocode,
      NA_character_
    )
  }, character(1))
}
