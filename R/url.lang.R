#' Make a url-link to glottolog page for a language
#'
#' Takes any vector of languages and return links to glottolog pages.
#' @param x A character vector of languages (can be written in lower case)
#' @param popup character vector of strings that will appear in pop-up window of the function map.feature
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' url.lang('Korean')
#' url.lang(c('Gangou', 'Hachijo', 'Adyghe', 'Ganai'))
#' @export

url.lang <- function(x,
                     popup = "",
                     glottolog.source = "modified") {
  if (typeof(x) == "list") {
    x <- unlist(x)
  }
  ifelse(
    grepl(glottolog.source, "original"),
    glottolog <- lingtypology::glottolog.original,
    glottolog <- lingtypology::glottolog.modified
  )
  df <-
    glottolog[tolower(glottolog$language) %in% tolower(x), 1:3]
  df <- df[match(tolower(x), tolower(df$language)),]

  df$popup <- popup

  if (sum(grepl("NOCODE_", df$iso)) > 0) {
    df[grep("NOCODE_", df$iso),]$iso <- NA
  }
  df$link <- NA

  df$link[!is.na(df$iso)] <- paste0(
    "<a href='",
    "http://glottolog.org/resource/languoid/iso/",
    df$iso[!is.na(df$iso)],
    "' target='_blank'>",
    as.character(df$language[!is.na(df$iso)]),
    "</a><br>",
    as.character(df$popup[!is.na(df$iso)])
  )
  df$link[is.na(df$iso) & !is.na(df$glottocode)] <- paste0(
    "<a href='",
    "http://glottolog.org/resource/languoid/id/",
    df$glottocode[is.na(df$iso) & !is.na(df$glottocode)],
    "' target='_blank'>",
    as.character(df$language[is.na(df$iso) &
                               !is.na(df$glottocode)]),
    "</a><br>",
    as.character(df$popup[is.na(df$iso) & !is.na(df$glottocode)])
  )
  df$link[is.na(df$iso) &
            is.na(df$glottocode)] <-
    paste0(as.character(df$language[is.na(df$iso) &
                                      is.na(df$glottocode)]),
           "<br>",
           as.character(df$popup[is.na(df$iso) &
                                   is.na(df$glottocode)]))
  return(df$link)
}
