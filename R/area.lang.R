#' Get macro area by languoid
#'
#' Takes any vector of languoids and return macro area.
#' @param x character vector of the languoids (can be written in lower case)
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' area.lang('Adyghe')
#' area.lang(c('Adyghe', 'Aduge'))
#' @export

area.lang <- function(x, glottolog.source = "modified") {
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original, 
        glottolog <- lingtypology::glottolog.modified)
    vapply(x, function(y) {
        ifelse(is.glottolog(y, response = TRUE, glottolog.source = glottolog.source) == 
            TRUE, glottolog[tolower(glottolog$lang) == tolower(y), ]$macro_area, 
            NA_character_)
    }, character(1))
}
