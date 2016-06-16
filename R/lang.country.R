#' Get languoids by country
#'
#' Takes any vector of countries and return languoids.
#' @param x A character vector of the countries (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @export

lang.country <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[grepl(input[i], tolower(glottolog$country)),]$languoid)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a country')
  } else {ret}}
