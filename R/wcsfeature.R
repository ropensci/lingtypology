#' Downloads data from World Color Survey Data Archives.
#'
#' This function downloads data from World Color Survey Data Archives. (\url{http://www1.icsi.berkeley.edu/wcs/data.html}).
#'
#' @author Kirill Koncha <majortomblog@gmail.com>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}, \code{\link{eurasianphonology.feature}}
#' @examples
#'
#' wcs.feature()
#'
#' @export
#'
#'

wcs.feature <- function(){
  message("Don't forget to cite a source:

Richard Cook, Paul Kay, Terry Regier. WCS Data Archives (Available online at http://www1.icsi.berkeley.edu/wcs/data.html, Accessed on ...)")
  lang <- utils::read.delim("http://www1.icsi.berkeley.edu/wcs/data/20021219/txt/lang.txt", encoding='UTF-8', header = FALSE)
  colnames(lang) <- c("id", "language", "location", "contr1", "contr2", "contr3")

}
x <- "M{\x9C}ra Pirah{\x8B}"
x <- gsub("\\{","",x)
x <- gsub("\\}", "", x)
x
