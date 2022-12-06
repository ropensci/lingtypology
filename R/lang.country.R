#' Get language by country
#'
#' Takes any vector of countries and returns languages.
#' @param x character vector of the countries (in alpha-2 ISO codes)
#' @param list logical. If TRUE, it returns a list of languages, if FALSE it returns a named vector.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{country.lang}}, \code{\link{gltc.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}, \code{\link{subc.lang}}, \code{\link{url.lang}}
#' @examples
#' lang.country('AD')
#' lang.country(c('AD', 'AE'))
#' @export
#' @importFrom stats na.omit
#'

lang.country <- function(x, list = TRUE) {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  countries <- lingtypology::countries
  result <- lapply(x, function(y) {
    if(!is.na(y)){
      if(nchar(y) > 2){
        y <- unique(countries[countries$country_name %in% y, "alpha2"],
                    countries[countries$additional_names %in% y, "alpha2"])
      }}

    if(toupper(y) %in% stats::na.omit(countries$alpha2) == TRUE){
      glottolog[grepl(toupper(y), glottolog$countries),]$language
    } else{
      NA_character_
    }})
  if(isFALSE(list)) {
    unlist(result)
  } else {
    names(result) <- x
    result
  }
}
