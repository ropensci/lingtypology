#' Are these langoids in glottolog?
#'
#' Takes any vector of linguoids or ISO codes and return a logical vector.
#' @param x A character vector of linguoids (can be written in lower case)or ISO codes
#' @param response logical. If TRUE, when languoid is absent, return warnings with a possible candidates.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' is.glottolog(c("Adyghe", "Russsian")
#' TRUE FALSE
#'
#' is.glottolog(c("Adyghe", "Russsian", response = T)
#' TRUE FALSE
#' Warning:
#' In is.glottolog(c("Adyghe", "Russsian"), response = T) :
#' Languoid Russsian is absent in our database. Did you mean Russian?
#'
#' @export
#' @import stringdist

is.glottolog <- function(x, response = F){
if(response == T) {
result <- NA
    for (i in 1:length(x)) {
    result[i] <- sum(tolower(glottolog$languoid)==tolower(x[i]) | tolower(glottolog$iso)==tolower(x[i])) > 0
    if (result[i] == FALSE) {
      cand <- stringdist::stringdist(x[i], glottolog$languoid, method = "lv")
      candidates <- paste(glottolog[cand == cand[which.min(cand)],]$languoid, collapse = ", ")
      warning(paste("Languoid ", x[i], " is absent in our database. Did you mean ",
                    candidates, "?", sep = ""))
      x <- c(4, 4, 9, 9)
      x[x == x[which.min(x)]]
      which.min(x)
    }
  }
} else {
result <- NA
  for (i in 1:length(x)) {
  result[i] <- sum(tolower(glottolog$languoid)==tolower(x[i]) | tolower(glottolog$iso)==tolower(x[i])) > 0
  }}
return(result)
}
