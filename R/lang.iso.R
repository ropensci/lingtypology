#' Get language by ISO 639--3 code
#'
#' Takes any vector of ISO codes and return languages.
#' @param x A character vector of the ISO codes.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}, \code{\link{lang.country}}
#' @examples
#' lang.iso('ady')
#' lang.iso(c('ady', 'rus'))
#' @export

lang.iso <- function(x, glottolog.source = "modified") {
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
    if(is.na(y)){
      NA_character_
    } else{
    ifelse(y %in% glottolog$iso,
           glottolog[tolower(glottolog$iso) %in% tolower(y), ]$language,
           NA_character_)
  }}, character(1))
}
