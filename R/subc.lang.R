#' Get subclassification by language
#'
#' Takes any vector of languoids and returns subclassification in the Newick tree format.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang.R}}, \code{\link{area.lang.R}}, \code{\link{country.lang.R}}, \code{\link{gltc.lang.R}}, \code{\link{iso.lang.R}}, \code{\link{lat.lang.R}}, \code{\link{long.lang.R}}, \code{\link{url.lang.R}}
#' @examples
#' subc.lang('Korean')
#' subc.lang(c('Korean', 'Lechitic'))
#' @export

subc.lang <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y), ]$subclassification,
      NA_character_
    )
  }, character(1))
}
