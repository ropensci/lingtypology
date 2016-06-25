#' Get country by languoid
#'
#' Takes any vector of languoids and return affiliation.
#' @param x character vector of the languoids (can be written in lower case)
#' @param intersection logical. If TRUE, function reterns vector of countries, where all languoids from x argument are spoken.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' country.lang("Udi")
#' country.lang(c("Udi", "Laz"))
#' country.lang(c("Udi", "Laz"), intersection = TRUE)
#' @export


country.lang <- function(x, intersection = FALSE){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    if (is.glottolog(x[i], response = T) == T) {
      a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$country)
    } else {
      a <- c(a, NA)
    }}
  ret <- a[-1]; ret
  if (intersection == TRUE){
    b <- unlist(strsplit(paste(ret, collapse = ", "), ", "))
    names(table(b)[table(b) == max(table(b))])
  } else{ret}}
