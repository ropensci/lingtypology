#' Get languages by affiliation
#'
#' Takes any vector of affiliations and returns languages.
#' @param x A character vector of the affiliations (can be written in lower case)
#' @param include.dialects logical. If TRUE, it returns all langauges and dialects, if FALSE it returns only languages.
#' @param list logical. If TRUE, it returns a list of languages, if FALSE it returns a named vector.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.iso}}
#' @examples
#' lang.aff('Slavic')
#' lang.aff(c('Slavic', 'Celtic'))
#' lang.aff(c('Slavic', 'Celtic'), list = TRUE)
#' @export

lang.aff <- function(x, include.dialects = FALSE, list = FALSE) {
    if (typeof(x) == "list") {
      x <- unlist(x)
    }
    ifelse(isTRUE(include.dialects),
           glottolog <- lingtypology::glottolog,
           glottolog <- lingtypology::glottolog[lingtypology::glottolog$level %in% c("language", "sign language"),]
    )
    result <- lapply(x, function(y) {
      glottolog[grep(tolower(y), tolower(glottolog$affiliation)),]$language
    })
    if (list == FALSE) {
      unlist(result)
    } else {
      result
    }
  }
