#' Get macro area by languoid
#'
#' Takes any vector of languoids and return macro area.
#' @param x character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' area.lang("Adyghe")
#' area.lang(c("Adyghe", "Aduge"))
#' @export

area.lang <- function(x){
    input <- tolower(x)
    a <- NA
    for (i in 1:length(input)) {
      if (is.glottolog(x[i], response = T) == T) {
        a <- c(a, glottolog[tolower(glottolog$lang) == input[i],]$macro_area)
      } else {
        a <- c(a, NA)
      }}
    ret <- a[-1]; ret
  }
