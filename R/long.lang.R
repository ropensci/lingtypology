#' Get longitude by language
#'
#' Takes any vector of languages and return longitude.
#' @param x A character vector of the languages (can be written in lower case)
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @param map.orientation A character verctor with values "Pacific" and "Atlantic". It distinguishes Pacific-centered and Atlantic-centered maps. By default is "Pacific".
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{area.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}
#' @examples
#' lat.lang('Adyghe')
#' long.lang('Adyghe')
#' lat.lang(c('Adyghe', 'Russian'))
#' long.lang(c('Adyghe', 'Russian'))
#' long.lang(c('Adyghe', 'Aleut'), map.orientation = "Pacific")
#' @export

long.lang <- function(x, map.orientation = "Pacific", glottolog.source = "modified") {
    if(typeof(x) == "list"){x <- unlist(x)}
    ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original,
        glottolog <- lingtypology::glottolog.modified)
    result <- vapply(x, function(y) {
        ifelse(is.glottolog(y, response = TRUE, glottolog.source = glottolog.source) == TRUE,
               glottolog[tolower(glottolog$language) %in% tolower(y), ]$longitude, NA_real_)
    }, double(1))
    if(map.orientation == "Atlantic"){
      am <- grep("America", area.lang(x))
      result[am] <- result[am]-360
      }
    return(result)
}
