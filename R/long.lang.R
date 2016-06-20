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
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$longitude)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a languoid')
  } else {
    if (length(ret) != length(x)) warning('one or more macro area are missed')
    ret}}
