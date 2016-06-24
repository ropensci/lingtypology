#' Make a link for a languoid
#'
#' Takes any vector of linguoids and return links.
#' @param x A character vector of linguoids (can be written in lower case)
#' @param popup character vector of strings that will appear in pop-up window
#' @author George Moroz <agricolamz@gmail.com>
#' @export

makelink <- function(x, popup = NULL){
  link <- NA
  for (i in 1:length(x)) {
    if (is.glottolog(x[i]) == T) {
    link[i] <- paste(c("<a href='",
                       "http://glottolog.org/resource/languoid/iso/",
                       glottolog[tolower(glottolog$languoid) == tolower(x[i]),]$iso,
                       "' target='_blank'>",
                       x[i],
                       "</a><br>", as.character(popup[i])), sep = "", collapse = "")
    } else{
      link[i] <- NA
    }}
  link
}
