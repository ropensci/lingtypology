#' Get affiliation by languoid
#'
#' Takes any vector of languoids and return affiliation.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' aff.lang("Korean")
#' aff.lang(c("Korean", "Polish"))
#' @export

aff.lang <- function(x){
  sapply(x, function(y){
    ifelse(is.glottolog(y, response = TRUE) == TRUE,
           lingtypology::glottolog[tolower(lingtypology::glottolog$lang) == tolower(y),]$affiliation,
           NA)})}
