#' Get latitude by language
#'
#' Takes any vector of languages and return latitude.
#' @param x A character vector of the languages (can be written in lower case)
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{long.lang}}
#' @examples
#' lat.lang('Adyghe')
#' long.lang('Adyghe')
#' lat.lang(c('Adyghe', 'Russian'))
#' long.lang(c('Adyghe', 'Russian'))
#' @export

lat.lang <- function(x, glottolog.source = "modified") {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  ifelse(
    grepl(glottolog.source, "original"),
    glottolog <- lingtypology::glottolog.original,
    glottolog <- lingtypology::glottolog.modified
  )
  vapply(x, function(y) {
    ifelse(
      is.glottolog(y, response = TRUE,
                   glottolog.source = glottolog.source) == TRUE,
      glottolog[tolower(glottolog$language) %in% tolower(y),]$latitude,
      NA_real_
    )
  }, double(1))
}
