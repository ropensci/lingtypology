#' Get Glottocode by language
#'
#' Takes any vector of languages and returns Glottocode.
#' @param x A character vector of the languages (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
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
