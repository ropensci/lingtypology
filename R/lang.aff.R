#' Get languages by affiliation
#'
#' Takes any vector of affiliations and return languages.
#' @param x A character vector of the affiliations (can be written in lower case)
#' @param list logical. If TRUE, returns a list of languages, if FALSE return a named vector.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.country}}, \code{\link{lang.iso}}
#' @examples
#' lang.aff('Slavic')
#' lang.aff(c('Slavic', 'Celtic'))
#' lang.aff(c('Slavic', 'Celtic'), list = TRUE)
#' @export

lang.aff <- function(x, list = FALSE, glottolog.source = "modified") {
    if(typeof(x) == "list"){x <- unlist(x)}
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original,
        glottolog <- lingtypology::glottolog.modified)
    result <- lapply(x, function(y) {
      glottolog[grep(tolower(y), tolower(glottolog$affiliation)), ]$language
      })
    if (list == FALSE) {
      unlist(result)
      } else {
        result
        }
    }
