#' Get languoids by affiliation
#'
#' Takes any vector of affiliations and return languoids.
#' @param x A character vector of the affiliations (can be written in lower case)
#' @param list logical. If TRUE, returns a list of languoids, if FALSE return a named vector.
#' @param glottolog.source A character vector that define which glottolog database is used: "original" or "modified" (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.country}}, \code{\link{lang.iso}}
#' @examples
#' lang.aff("Balto-Slavic")
#' lang.aff(c("East Slavic", "West Slavic"))
#' lang.aff(c("East Slavic", "West Slavic"), list = TRUE)
#' @export

lang.aff <- function(x, list = FALSE, glottolog.source = "modified"){
  ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original, glottolog <- lingtypology::glottolog.modified)
  if(list == FALSE){
    c(unlist(sapply(x, function(y){
      glottolog[grep(tolower(y), tolower(glottolog$affiliation)),]$languoid})))
    } else {
      sapply(x, function(y){
        glottolog[grep(tolower(y), tolower(glottolog$affiliation)),]$languoid})}
  }
