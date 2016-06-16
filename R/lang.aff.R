#' Get languoids by affiliation
#'
#' Takes any vector of affiliations and return languoids.
#' @param x A character vector of the affiliations (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @export

lang.aff <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[grepl(input[i], tolower(glottolog$affiliation)),]$languoid)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such an affiliation')
  } else {ret}}
