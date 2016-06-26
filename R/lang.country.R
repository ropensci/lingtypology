#' Get languoids by country
#'
#' Takes any vector of countries and return languoids.
#' @param x character vector of the countries (can be written in lower case)
#' @examples
#' lang.country("Bali")
#' lang.country(c("Bali", "Luxembourg"))
#' ## What languoids are both in North Korea and in South Korea?
#' lang.country("Korea")
#' @author George Moroz <agricolamz@gmail.com>
#' @export

lang.country <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
# abbreviation -----------------------------------------
    if (sum(input[i]==tolower(countries$abbreviation)) > 0) {
      input[i]<- tolower(as.character(countries$common[input[i]==tolower(countries$abbreviation)]))
    }
# common -----------------------------------------
    if (sum(input[i]==tolower(countries$official)) > 0) {
      input[i]<- tolower(as.character(countries$common[input[i]==tolower(countries$official)]))
    }
# get country -------------------------------------------------------------
    a <- c(a, glottolog[grepl(input[i], tolower(glottolog$country)),]$languoid)
  }
  ret <- a[complete.cases(a)]
  if (length(ret) < 1) {
    warning('There is no such a country')
  } else {ret}}
