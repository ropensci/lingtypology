#' Is it in glottolog?
#'
#' Takes any vector of linguoids or ISO codes and return a logical vector.
#' @param x A character vector of linguoids (can be written in lower case)or ISO codes
#' @author George Moroz <agricolamz@gmail.com>
#' @export

is.glottolog <- function(x){
result <- NA
  for (i in 1:length(x)) {
  result[i] <- sum(tolower(glottolog$languoid)==tolower(x[i]) | tolower(glottolog$iso)==tolower(x[i])) > 0
  }
return(result)
}
