#' Get latitude by languoid
#'
#' Takes any vector of languoids and return latitude.
#' @param x A character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' lat.lang("Adyghe")
#' long.lang("Adyghe")
#' lat.lang(c("Adyghe", "Russian"))
#' long.lang(c("Adyghe", "Russian"))
#' @export

lat.lang <- function(x){
  input <- tolower(x)
  a <- NA
  for (i in 1:length(input)) {
    if (is.glottolog(x[i], response = T) == T) {
      a <- c(a, glottolog[(tolower(glottolog$lang) == input[i]),]$latitude)
    } else {
      a <- c(a, NA)
    }}
  ret <- a[-1]; ret
}
