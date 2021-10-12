#' Get language by ISO 639--3 code
#'
#' Takes any vector of ISO codes and returns languages.
#' @param x A character vector of the ISO codes.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}
#' @examples
#' lang.iso('ady')
#' lang.iso(c('ady', 'rus'))
#' @export

lang.iso <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
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
