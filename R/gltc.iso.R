#' Get Glottocode by ISO 639--3 code
#'
#' Takes any vector of ISO 639--3 codes and returns Glottocodes.
#' @param x A character vector of the Glottocodes.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' gltc.iso('ady')
#' gltc.iso(c('ady', 'rus'))
#' @export

gltc.iso <- function(x, glottolog.source = "modified") {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  ifelse(
    grepl(glottolog.source, "original"),
    glottolog <- lingtypology::glottolog.original,
    glottolog <- lingtypology::glottolog.modified
  )
  x <- gsub("\\W", "", x)
  vapply(x, function(y) {
    ifelse(y %in% glottolog$iso,
           glottolog[tolower(glottolog$iso) %in% tolower(y), ]$glottocode,
           NA_character_)
  }, character(1))
}
