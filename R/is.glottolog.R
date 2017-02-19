#' Are these langoids in glottolog?
#'
#' Takes any vector of linguoids or ISO codes and return a logical vector.
#' @param x A character vector of linguoids (can be written in lower case)or ISO codes
#' @param response logical. If TRUE, when languoid is absent, return warnings with a possible candidates.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' is.glottolog(c('Adyghe', 'Russsian'))
#'
#' # Add warning message with sugestions
#' is.glottolog(c('Adyge', 'Russian'), response = TRUE)
#' # > FALSE TRUE
#' # Warning message:
#' # In is.glottolog(c('Adyge', 'Russian'), response = TRUE) :
#' # Languoid Adyge is absent in our database. Did you mean Aduge, Adyghe?
#'
#' @export
#' @importFrom stringdist stringdist
#'

is.glottolog <- function(x, response = FALSE, glottolog.source = "modified") {
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original,
        glottolog <- lingtypology::glottolog.modified)
    y <- tolower(x)
    # check whether there are linguoids in database ---------------------------
    result <- y %in% tolower(glottolog$languoid)
    if (response == TRUE) {
        vapply(x[!result], function(z) {

            # computes pairwise string Levenshtein distance ---------------------------
            cand <- stringdist::stringdist(tolower(z), tolower(glottolog$languoid),
                method = "lv")

            # make a string with all candidates ---------------------------------------
            candidate <- paste(glottolog[cand == cand[which.min(cand)], ]$languoid,
                collapse = ", ")

            # make a warning message --------------------------------------------------
            warning(paste("Languoid ", z, " is absent in our database. Did you mean ",
                candidate, "?", sep = ""), call. = FALSE)
        }, character(1))
    }
    return(result)
}
