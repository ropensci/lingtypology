#' Get ISO 639-3 code by languoid
#'
#' Takes any vector of languoids and return ISO code.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' iso.lang("Adyghe")
#' iso.lang(c("Adyghe", "Udi"))
#' @export

iso.lang <- function(x){
  sapply(x, function(y){
    ifelse(is.glottolog(y, response = TRUE) == TRUE,
           lingtypology::glottolog[tolower(lingtypology::glottolog$lang) == tolower(y),]$iso,
           NA)})}
