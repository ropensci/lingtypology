#' Get language by Glottocode
#'
#' Takes any vector of Glottocodes and return languages.
#' @param x A character vector of the Glottocodes.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}, \code{\link{lang.country}}
#' @examples
#' lang.gltc('adyg1241')
#' lang.gltc(c('adyg1241', 'udii1243'))
#' @export

lang.gltc <- function(x, glottolog.source = "modified") {
  if(typeof(x) == "list"){x <- unlist(x)}
  ifelse(grepl(glottolog.source, "original"),
         glottolog <- lingtypology::glottolog.original,
         glottolog <- lingtypology::glottolog.modified)
  x <- gsub("\\W", "", x)
  vapply(x, function(y) {
    ifelse(y %in% glottolog$glottocode,
           glottolog[tolower(glottolog$glottocode) %in% tolower(y),]$language,
           NA_character_)
  }, character(1))
}
