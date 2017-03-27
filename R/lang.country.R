#' Get languages by country
#'
#' Takes any vector of countries and return languages.
#' @param x character vector of the countries (can be written in lower case)
#' @param list logical. If TRUE, returns a list of languages, if FALSE return a vector.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}, \code{\link{lang.iso}}
#' @examples
#' lang.country('North Korea')
#' lang.country(c('North Korea', 'Luxembourg'))
#' lang.country(c('North Korea', 'Luxembourg'), list = TRUE)
#' @export

lang.country <- function(x, list = FALSE, glottolog.source = "modified") {
    if(typeof(x) == "list"){x <- unlist(x)}
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original,
        glottolog <- lingtypology::glottolog.modified)
    ret <- lapply(x, function(y) {
      cntr <- lingtypology::countries$common[which(unlist(lingtypology::countries) %in% y) %% nrow(lingtypology::countries)]
        if (length(cntr) > 0) {
            glottolog[grep(cntr, glottolog$country), ]$language
        } else {
            NA
        }
    })
    if (list == TRUE) {
        return(ret)
    } else {
        return(unlist(ret))
    }
}
