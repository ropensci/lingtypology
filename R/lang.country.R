#' Get languoids by country
#'
#' Takes any vector of countries and return languoids.
#' @param x character vector of the countries (can be written in lower case)
#' @param list logical. If TRUE, returns a list of languoids, if FALSE return a vector.
#' @examples
#' lang.country("Bali")
#' lang.country(c("Bali", "Luxembourg"))
#' lang.country(c("Bali", "Luxembourg"), list = TRUE)
#' ## What languoids are both in North Korea and in South Korea?
#' lang.country("Korea")
#' @author George Moroz <agricolamz@gmail.com>
#' @export

lang.country <- function(x, list = FALSE){
  ret <- lapply(x, function(y){
    cntr <- countries$common[(tolower(countries$common) %in% tolower(y) |
                                tolower(countries$official) %in% tolower(y) |
                                tolower(countries$abbreviation) %in% tolower(y))]
    if(length(cntr) > 0){
      glottolog[grep(cntr, glottolog$country),]$languoid}
    else{NA}})
  if(list == TRUE){
    return(ret)} else {
      return(unlist(ret))}}
