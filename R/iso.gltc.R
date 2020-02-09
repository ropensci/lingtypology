#' Get ISO 639--3 code by Glottocode
#'
#' Takes any vector of Glotocodes and returns ISO code.
#' @param x A character vector of Glottocodes.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' iso.gltc('adyg1241')
#' iso.gltc(c('adyg1241', 'udii1243'))
#' @export

iso.gltc <- function(x) {
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
           glottolog[tolower(glottolog$glottocode) %in% tolower(y), ]$iso,
           NA_character_)
  }}, character(1))
}
