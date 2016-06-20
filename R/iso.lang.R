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
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[tolower(glottolog$languoid) == input[i],]$iso)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a languoid')
  } else {
    if (length(ret) != length(x)) warning('one or more iso-codes are missed')
    ret}}
