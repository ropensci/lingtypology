#' Get languoids by country
#'
#' Takes any vector of countries and return languoids.
#' @param x character vector of the countries (can be written in lower case)
#' @param list logical. If TRUE, returns a list of languoids, if FALSE return a vector.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}, \code{\link{lang.iso}}
#' @examples
#' lang.country("Bali")
#' lang.country(c("Bali", "Luxembourg"))
#' lang.country(c("Bali", "Luxembourg"), list = TRUE)
#' ## What languoids are both in North Korea and in South Korea?
#' lang.country("Korea")
#' @export

lang.country <- function(x, list = FALSE){
  ret <- lapply(x, function(y){
    cntr <- lingtypology::countries$common[(tolower(lingtypology::countries$common) %in% tolower(y) |
                                tolower(lingtypology::countries$official) %in% tolower(y) |
                                tolower(lingtypology::countries$abbreviation) %in% tolower(y))]
    if(length(cntr) > 0){
      lingtypology::glottolog[grep(cntr, lingtypology::glottolog$country),]$languoid}
    else{NA}})
  if(list == TRUE){
    return(ret)} else {
      return(unlist(ret))}}
