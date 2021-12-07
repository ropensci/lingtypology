#' Opens data from the database of WCS Data Archives
#'
#' This function opens downloaded data from the database of WCS Data Archives (\url{https://www1.icsi.berkeley.edu/wcs/data.html}).
#'
#' @param feature "Berlin and Kay" to show data collected by Berlin and Kay; "WCS" for World Color Survey Database. Both databases were created by asking native speakers of different languages to name each of 330 Munsell chips, shown in a constant, random order, and (2), exposed to a palette of these chips and asked to to pick out the best example(s) ("foci") of the major terms elicited in the naming task. Two databases are differ in number of languages as WCS Database is significantly larger.
#' @author Kirill Koncha <majortomblog@gmail.com>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#'
#' wcs.feature("WCS")
#'
#' @export
#'
#'
wcs.feature <- function(feature){
  message("Don't forget to cite a source:

Richard Cook, Paul Kay, Terry Regier. WCS Data Archives (Available online at http://www.icsi.berkeley.edu/wcs/data.html, Accessed on ...)")
  if (feature == "Berlin and Kay") {
    result <- lingtypology::wcs_bk
    return(result)
  } else if (feature == "WCS") {
    result <- lingtypology::wcs
    return(result)
  } else {
    message('It seems that function does not have this parameter. Use "WCS" to get World Color Survey Database and "Berlin and Kay" to get original data collected by Berlin and Kay.')
  }
}

