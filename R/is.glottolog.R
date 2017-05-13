#' Are these languages in glottolog?
#'
#' Takes any vector of languages or ISO codes and return a logical vector.
#' @param x A character vector of languages (can be written in lower case)or ISO codes
#' @param response logical. If TRUE, when language is absent, return warnings with a possible candidates.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' is.glottolog(c('Adyghe', 'Russian'))
#' is.glottolog('Buyaka')
#'
#' # Add warning message with sugestions
#' is.glottolog(c('Adygey', 'Russian'), response = TRUE)
#' # > FALSE TRUE
#' # Warning message:
#' # In is.glottolog(c('Adyge', 'Russian'), response = TRUE) :
#' # Language Adyge is absent in our version of the Glottolog database. Did you mean Aduge, Adyghe?
#'
#' @export
#' @importFrom stringdist stringdist
#'

is.glottolog <- function(x, response = FALSE, glottolog.source = "modified") {
    if(typeof(x) == "list"){x <- unlist(x)}
    ifelse(grepl(glottolog.source, "original"),
           glottolog <- lingtypology::glottolog.original,
           glottolog <- lingtypology::glottolog.modified)
    y <- tolower(x)
# check whether there are languages in database ---------------------------
    result <- y %in% tolower(glottolog$language)
    if (response == TRUE) {
        vapply(x[!result], function(z) {
# computes pairwise string Levenshtein distance ---------------------------
            cand <- stringdist::stringdist(tolower(as.character(z)),
                                           tolower(glottolog$language),
                                           method = "lv")
# add exact substrings ---------------------------------------------------
            cand_subst <- c(grep(paste0(tolower(z), " "),
                                 tolower(glottolog$language)),
                            grep(paste0(" ", tolower(z)),
                                 tolower(glottolog$language)),
                            grep(paste0(tolower(z), "-"),
                                 tolower(glottolog$language)),
                            grep(paste0("-", tolower(z)),
                                 tolower(glottolog$language)))

# alternative names -------------------------------------------------------
            alternates <- grepl(tolower(z), tolower(glottolog$alternate_names))

            # make a string with all candidates ---------------------------------------
            candidate <- unique(c(
              glottolog[cand == cand[which.min(cand)], ]$language,
              glottolog[cand_subst, ]$language,
              glottolog[alternates, ]$language))

            candidate <- paste(candidate[!is.na(candidate)], collapse = ", ")

            # make a warning message --------------------------------------------------
            warning(paste("Language ", z, " is absent in our version of the",
                          " Glottolog database. Did you mean ",
                          candidate, "?",
                          sep = ""), call. = FALSE)
        }, character(1))
    }
    return(result)
}
