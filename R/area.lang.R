#' Get macro area by languoid
#'
#' Takes any vector of languoids and return macro area.
#' @param x character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' area.lang("Adyghe")
#' area.lang(c("Adyghe", "Aduge"))
#' @export

area.lang <- function(x){
  sapply(x, function(y){
    ifelse(is.glottolog(y, response = TRUE) == TRUE,
           lingtypology::glottolog[tolower(lingtypology::glottolog$lang) == tolower(y),]$macro_area,
           NA)})}
