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
    if (is.glottolog(x[i], response = T) == T) {
      a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$affiliation)
    } else {
      a <- c(a, NA)
    }}
  ret <- a[-1]; ret
  }
