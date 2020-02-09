#' Get Glottocode by ISO 639--3 code
#'
#' Takes any vector of ISO 639--3 codes and returns Glottocodes.
#' @param x A character vector of the Glottocodes.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' gltc.iso('ady')
#' gltc.iso(c('ady', 'rus'))
#' @export

gltc.iso <- function(x) {
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
           glottolog[tolower(glottolog$iso) %in% tolower(y), ]$glottocode,
           NA_character_)
  }}, character(1))
}
