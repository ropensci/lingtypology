#' Make a link for a languoid
#'
#' Takes any vector of linguoids and return links.
#' @param x A character vector of linguoids (can be written in lower case)
#' @param popup character vector of strings that will appear in pop-up window
#' @author George Moroz <agricolamz@gmail.com>
#' @export

makelink <- function(x, popup = NULL){
  link <- paste("<a href='",
                "http://glottolog.org/resource/languoid/iso/",
                lingtypology::glottolog[tolower(lingtypology::glottolog$languoid) %in% tolower(x),]$iso,
                "' target='_blank'>",
                as.character(x),
                "</a><br>",
                as.character(popup),
                sep = "")
  return(link)
}
