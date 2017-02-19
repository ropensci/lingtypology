#' Get ISO 639--3 code by languoid
#'
#' Takes any vector of languoids and return ISO code.
#' @param x A character vector of the languoids (can be written in lower case)
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' iso.lang('Adyghe')
#' iso.lang(c('Adyghe', 'Udi'))
#' @export

iso.lang <- function(x, glottolog.source = "modified") {
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original, 
        glottolog <- lingtypology::glottolog.modified)
    vapply(x, function(y) {
        ifelse(is.glottolog(y, response = TRUE, glottolog.source = glottolog.source) == 
            TRUE, glottolog[tolower(glottolog$lang) == tolower(y), ]$iso, NA_character_)
    }, character(1))
}
