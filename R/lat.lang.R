#' Get latitude by languoid
#'
#' Takes any vector of languoids and return latitude.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{long.lang}}
#' @examples
#' lat.lang("Adyghe")
#' long.lang("Adyghe")
#' lat.lang(c("Adyghe", "Russian"))
#' long.lang(c("Adyghe", "Russian"))
#' @export

lat.lang <- function(x){
  sapply(x, function(y){
    ifelse(is.glottolog(y, response = TRUE) == TRUE,
           lingtypology::glottolog[tolower(lingtypology::glottolog$lang) == tolower(y),]$latitude,
           NA)})}
