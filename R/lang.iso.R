#' Get languoid by ISO 639-3 code
#'
#' Takes any vector of ISO codes and return languoids.
#' @param x A character vector of the ISO codes.
#' @author George Moroz <agricolamz@gmail.com>
#' @export

lang.iso <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[tolower(glottolog$iso) == input[i],]$languoid)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a iso')
  } else {
    if(length(ret) != length(x))warning('one or more languoids are missed')
    ret}}
