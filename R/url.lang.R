#' Make a url-link to glottolog page for a language
#'
#' Takes any vector of languages and return links to glottolog pages.
#' @param x A character vector of languages (can be written in lower case)
#' @param popup character vector of strings that will appear in pop-up window of the function map.feature
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' url.lang('Korean')
#' url.lang(c('Gangou', 'Hachijo', 'Adyghe', 'Ganai'))
#' @export

url.lang <- function(x,
                     popup = "") {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  glottolog <- lingtypology::glottolog
  df <- glottolog[tolower(glottolog$language) %in% tolower(x), 1:3]
  df <- df[match(tolower(x), tolower(df$language)),]

  df$popup <- popup

  df$link <- NA

  df$link[!is.na(df$glottocode)] <- paste0(
    "<a href='",
    "https://glottolog.org/resource/languoid/id/",
    df$glottocode[!is.na(df$glottocode)],
    "' target='_blank'>",
    as.character(df$language[!is.na(df$glottocode)]),
    "</a><br>",
    as.character(df$popup[!is.na(df$glottocode)])
  )
  df$link[is.na(df$glottocode) & !is.na(df$glottocode)] <- paste0(
    "<a href='",
    "http://glottolog.org/resource/languoid/id/",
    df$glottocode[is.na(df$glottocode) & !is.na(df$glottocode)],
    "' target='_blank'>",
    as.character(df$language[is.na(df$glottocode) &
                               !is.na(df$glottocode)]),
    "</a><br>",
    as.character(df$popup[is.na(df$glottocode) & !is.na(df$glottocode)])
  )
  df$link[is.na(df$glottocode) &
            is.na(df$glottocode)] <-
    paste0(as.character(df$language[is.na(df$glottocode) &
                                      is.na(df$glottocode)]),
           "<br>",
           as.character(df$popup[is.na(df$glottocode) &
                                   is.na(df$glottocode)]))
  return(df$link)
}
