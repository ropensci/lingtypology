#' Are these languages in glottolog?
#'
#' Takes any vector of languages or ISO codes and returns a logical vector.
#' @param x A character vector of languages (can be written in lower case)or ISO codes
#' @param response logical. If TRUE, when language is absent, return warnings with a possible candidates.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' is.glottolog(c('Kabardian', 'Russian'))
#' is.glottolog('Buyaka')
#'
#' \dontrun{
#' # Add warning message with sugestions
#' is.glottolog(c('Adyge', 'Russian'), response = TRUE)
#' # > FALSE TRUE
#' # Warning message:
#' # In is.glottolog(c('Kabardia', 'Russian'), response = TRUE) :
#' # Language Kabardia is absent in our version of the Glottolog database.
#' # Did you mean Kabardian, Greater Kabardian?
#' }
#' @export
#' @importFrom stringdist stringdist
#'

is.glottolog <-
  function(x,
           response = FALSE) {
    if (typeof(x) == "list") {
      x <- unlist(x)
    }
    glottolog <- lingtypology::glottolog
    y <- tolower(x)
    # check whether there are languages in database ---------------------------
    result <- y %in% tolower(glottolog$language)
    if (response == TRUE) {
      vapply(x[!result], function(z) {
        if(is.na(z)){
          NA_character_
        } else{
        # computes pairwise string Levenshtein distance ---------------------------
        cand <- stringdist::stringdist(tolower(as.character(z)),
                                       tolower(glottolog$language),
                                       method = "lv")
        # add exact substrings ---------------------------------------------------
        cand_subst <- c(
          grep(paste0(tolower(z), " "),
               tolower(glottolog$language)),
          grep(paste0(" ", tolower(z)),
               tolower(glottolog$language)),
          grep(paste0(tolower(z), "-"),
               tolower(glottolog$language)),
          grep(paste0("-", tolower(z)),
               tolower(glottolog$language))
        )

        # make a string with all candidates ---------------------------------------
        candidate <- unique(c(
          glottolog[cand == cand[which.min(cand)],]$language,
          glottolog[cand_subst,]$language
        ))

        candidate <-
          paste(candidate[!is.na(candidate)], collapse = ", ")

        # make a warning message --------------------------------------------------
        warning(
          paste(
            "Language ",
            z,
            " is absent in our version of the",
            " Glottolog database. Did you mean ",
            candidate,
            "?\n",
            sep = ""
          ),
          call. = FALSE
        )
      }}, character(1))
    }
    return(result)
  }
