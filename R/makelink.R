#' Make a link for a languoid
#'
#' Takes any vector of linguoids and return links to glottolog pages.
#' @param x A character vector of linguoids (can be written in lower case)
#' @param popup character vector of strings that will appear in pop-up window of the function map.feature
#' @param glottolog.source A character vector that define which glottolog database is used: "original" or "modified" (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @export

makelink <- function(x, popup = NULL, glottolog.source = "modified"){
  ifelse(grepl(glottolog.source, "original"), glottolog <- lingtypology::glottolog.original, glottolog <- lingtypology::glottolog.modified)
  link <- paste("<a href='",
                "http://glottolog.org/resource/languoid/iso/",
                glottolog[tolower(glottolog$languoid) %in% tolower(x),]$iso,
                "' target='_blank'>",
                as.character(x),
                "</a><br>",
                as.character(popup),
                sep = "")
  return(link)
}
