#' Get longitude by languoid
#'
#' Takes any vector of languoids and return longitude.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' lat.lang("Adyghe")
#' long.lang("Adyghe")
#' lat.lang(c("Adyghe", "Russian"))
#' long.lang(c("Adyghe", "Russian"))
#' @export

long.lang <- function(x){
  sapply(x, function(y){
    ifelse(is.glottolog(y, response = TRUE) == TRUE,
           glottolog[tolower(glottolog$lang) == tolower(y),]$longitude,
           NA)})}
