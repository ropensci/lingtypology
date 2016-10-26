#' Get languoid by ISO 639-3 code
#'
#' Takes any vector of ISO codes and return languoids.
#' @param x A character vector of the ISO codes.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' lang.iso("ady")
#' lang.iso(c("ady", "rus"))
#' @export

lang.iso <- function(x){
  sapply(x, function(y){
    ifelse(y %in% glottolog$iso,
           glottolog[tolower(glottolog$iso) %in% tolower(y),]$languoid,
           NA)})}
