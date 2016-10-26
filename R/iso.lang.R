#' Get ISO 639-3 code by languoid
#'
#' Takes any vector of languoids and return ISO code.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' iso.lang("Adyghe")
#' iso.lang(c("Adyghe", "Udi"))
#' @export

iso.lang <- function(x){
  sapply(x, function(y){
    ifelse(is.glottolog(y, response = TRUE) == TRUE,
           glottolog[tolower(glottolog$lang) == tolower(y),]$iso,
           NA)})}
