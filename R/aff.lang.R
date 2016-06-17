#' Get affiliation by languoid
#'
#' Takes any vector of languoids and return affiliation.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' aff.lang("Korean")
#' aff.lang(c("Korean", "Polish"))
#' @export

aff.lang <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$affiliation)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a languoid')
  } else {
    if(length(ret) != length(x))warning('one or more affiliations are missed')
    ret}}
