#' Are these langoids in glottolog?
#'
#' Takes any vector of linguoids or ISO codes and return a logical vector.
#' @param x A character vector of linguoids (can be written in lower case)or ISO codes
#' @param response logical. If TRUE, when languoid is absent, return warnings with a possible candidates.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' is.glottolog(c("Adyghe", "Russsian"))
#'
#' # Add warning message with sugestions
#' is.glottolog(c("Adyge", "Russian"), response = TRUE)
#' # > FALSE TRUE
#' # Warning message:
#' # In is.glottolog(c("Adyge", "Russian"), response = TRUE) :
#' # Languoid Adyge is absent in our database. Did you mean Aduge, Adyghe?
#'
#' @export
#' @import stringdist

is.glottolog <- function(x, response = FALSE){
  y <- tolower(x)
# check whether there are linguoids in database ---------------------------
  result <- y %in% tolower(lingtypology::glottolog$languoid)
  if(response == TRUE){
    sapply(x[!result], function(z){

# computes pairwise string Levenshtein distance ---------------------------
      cand <- stringdist::stringdist(tolower(z),
                                     tolower(lingtypology::glottolog$languoid),
                                     method = "lv")

# make a string with all candidates ---------------------------------------
      candidate <- paste(lingtypology::glottolog[cand == cand[which.min(cand)],]$languoid,
                         collapse = ", ")

# make a warning message --------------------------------------------------
      warning(paste("Languoid ",
                    z,
                    " is absent in our database. Did you mean ",
                    candidate, "?",
                    sep = ""))})}
  return(result)
}
