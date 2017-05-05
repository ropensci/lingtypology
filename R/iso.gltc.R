#' Get ISO 639--3 code by Glottocode
#'
#' Takes any vector of Glotocodes and returns ISO code.
#' @param x A character vector of Glottocodes.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' iso.gltc('adyg1241')
#' iso.gltc(c('adyg1241', 'udii1243'))
#' @export

iso.gltc <- function(x, glottolog.source = "modified") {
  if(typeof(x) == "list"){x <- unlist(x)}
  ifelse(grepl(glottolog.source, "original"),
         glottolog <- lingtypology::glottolog.original,
         glottolog <- lingtypology::glottolog.modified)
  vapply(x, function(y) {
    ifelse(y %in% glottolog$glottocode,
           glottolog[tolower(glottolog$glottocode) %in% tolower(y),]$iso,
           NA_character_)
  }, character(1))
}
