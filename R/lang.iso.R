#' Get languoid by ISO 639--3 code
#'
#' Takes any vector of ISO codes and return languoids.
#' @param x A character vector of the ISO codes.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{lang.aff}}, \code{\link{lang.country}}
#' @examples
#' lang.iso('ady')
#' lang.iso(c('ady', 'rus'))
#' @export

lang.iso <- function(x, glottolog.source = "modified") {
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original, 
        glottolog <- lingtypology::glottolog.modified)
    vapply(x, function(y) {
        ifelse(y %in% glottolog$iso, glottolog[tolower(glottolog$iso) %in% tolower(y), 
            ]$languoid, NA_character_)
    }, character(1))
}
