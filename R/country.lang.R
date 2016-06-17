#' Get country by languoid
#'
#' Takes any vector of languoids and return affiliation.
#' @param x character vector of the languoids (can be written in lower case)
#' @param intersection logical. If TRUE, function reterns vector of countries, where all languoids from x argument are spoken.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' country.lang("Udi")
#' country.lang(c("Udi", "Laz"))
#' country.lang(c("Udi", "Laz"), intersection = T)
#' @export

country.lang <- function(x, intersection = FALSE){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$country)
  }
  ret <- unique(a[complete.cases(a)])
  if (length(ret) < 1) {
    warning('There is no such a languoid')
  } else {
    if(length(ret) != length(x))warning('one or more countries are missed')
    if(intersection == T){
      b <- unlist(strsplit(paste(ret, collapse = ", "), ", "))
      names(table(b)[table(b) > 1])
    } else{ret}}}
