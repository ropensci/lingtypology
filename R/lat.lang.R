#' Get latitude by languoid
#'
#' Takes any vector of languoids and return latitude.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @export

lat.lang <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$latitude)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a languoid')
  } else {
    if(length(ret) != length(x))warning('one or more macro area are missed')
    ret}}
