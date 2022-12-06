#' Get ISO 639-3 code from ISO 639-1
#'
#' Takes any vector of ISO 639-1 codes and returns ISO 639-3 code.
#' @param x A character vector of ISO 639-3 codes.
#' @author Ekaterina Zalivina <zalivina01@mail.ru>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' iso3.iso1('bs')
#' iso3.iso1(c('co', 'it', 'ar'))
#' @export

iso3.iso1 <- function(x) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  iso <- lingtypology::iso_639
  x <- gsub("\\W", "", x)
  vapply(x, function(y) {
    if(is.na(y)){
      NA_character_
    } else{
      ifelse(y %in% iso$ISO_639_1,
             iso[tolower(iso$ISO_639_1) %in% tolower(y), ]$ISO_639_3,
             NA_character_)
    }}, character(1))
}
