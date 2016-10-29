#' Get languoids by affiliation
#'
#' Takes any vector of affiliations and return languoids.
#' @param x A character vector of the affiliations (can be written in lower case)
#' @param list logical. If TRUE, returns a list of languoids, if FALSE return a named vector.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' lang.aff("Balto-Slavic")
#' lang.aff(c("East Slavic", "West Slavic"))
#' lang.aff(c("East Slavic", "West Slavic"), list = TRUE)
#' @export

lang.aff <- function(x, list = FALSE){
  if(list == FALSE){
    c(unlist(sapply(x, function(y){
      glottolog[grep(tolower(y), tolower(glottolog$affiliation)),]$languoid})))
    } else {
      sapply(x, function(y){
        glottolog[grep(tolower(y), tolower(glottolog$affiliation)),]$languoid})}
  }
