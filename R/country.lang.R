#' Get country by language
#'
#' Takes any vector of languages and returns countries where those languages are used as ISO 3166-1 alpha-2 codes.
#' @param x A character vector of the languages (can be written in lower case)
#' @param full_name A logical value, whether return ISO 3166-2 codes or full names.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{gltc.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}, \code{\link{subc.lang}}, \code{\link{url.lang}}
#' @examples
#' country.lang('Korean')
#' country.lang(c('Korean', 'Polish'))
#' @export
#'
#'


country.lang <- function(x, full_name = TRUE) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  countries <- lingtypology::countries

  result <- vapply(x, function(y) {
    ifelse(
      isTRUE(is.glottolog(y, response = TRUE)),
      glottolog[tolower(glottolog$language) %in% tolower(y), ]$countries,
      NA_character_
    )
  }, character(1))

  if(full_name){
    vapply(result, function(y) {
      ifelse(
        !is.na(y),
        paste0(unique(countries[countries$alpha2 %in% unlist(strsplit(y, ";")),"country_name"]),
               collapse = ";"),
        NA_character_
      )
    }, character(1))
  }
}
