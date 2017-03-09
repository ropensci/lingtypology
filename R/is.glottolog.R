#' Are these langoids in glottolog?
#'
#' Takes any vector of languoids or ISO codes and return a logical vector.
#' @param x A character vector of languoids (can be written in lower case)or ISO codes
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
    if(typeof(x) == "list"){x <- unlist(x)}
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original,
        glottolog <- lingtypology::glottolog.modified)
    y <- tolower(x)
    # check whether there are languoids in database ---------------------------
    result <- y %in% tolower(glottolog$languoid)
    if (response == TRUE) {
        vapply(x[!result], function(z) {

            # computes pairwise string Levenshtein distance ---------------------------
            cand <- stringdist::stringdist(tolower(z), tolower(glottolog$languoid),
                method = "lv")

            # add exact substrings ---------------------------------------------------
            cand_subst <- c(grep(paste0(tolower(z), " "), tolower(glottolog$languoid)),
                            grep(paste0(" ", tolower(z)), tolower(glottolog$languoid)),
                            grep(paste0(tolower(z), "-"), tolower(glottolog$languoid)),
                            grep(paste0("-", tolower(z)), tolower(glottolog$languoid)))

            # make a string with all candidates ---------------------------------------
            candidate <- paste(unique(c(
              glottolog[cand == cand[which.min(cand)], ]$languoid,
              glottolog[cand_subst, ]$languoid)),
              collapse = ", ")

            # make a warning message --------------------------------------------------
            warning(paste("Languoid ", z, " is absent in our database. Did you mean ",
                candidate, "?", sep = ""), call. = FALSE)
        }, character(1))
    }
    return(result)
}
