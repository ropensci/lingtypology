#' Get language by Glottocode
#'
#' Takes any vector of Glottocodes and returns languages.
#' @param x A character vector of the Glottocodes.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}
#' @examples
#' lang.gltc('adyg1241')
#' lang.gltc(c('adyg1241', 'udii1243'))
#' @export

lang.gltc <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  x <- gsub("\\W", "", x)
  vapply(x, function(y) {
    if(is.na(y)){
      NA_character_
      } else{
    ifelse(y %in% glottolog$glottocode,
           glottolog[tolower(glottolog$glottocode) %in% tolower(y), ]$language,
           NA_character_)
  }}, character(1))
}
