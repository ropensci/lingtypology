#' Opens data from the database of WCS Data Archives
#'
#' This function opens downloaded data from the database of WCS Data Archives (\url{https://www1.icsi.berkeley.edu/wcs/data.html}).
#'
#' @param feature Berlin and Kay for Database of Berlin and Kay; WCS for World Color Survey Database
#' @author Kirill Koncha <majortomblog@gmail.com>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#'
#' wcs.feature()
#'
#' @export
#'
#'
wcs.feature <- function(feature){
  message("Don't forget to cite a source:

http://www.icsi.berkeley.edu/wcs/data.html")
  if (feature == "Berlin and Kay")
    {result <- lingtypology::wcs_bk
  }
  if (feature == "WCS") {
    result <- lingtypology::wcs
  }
  else {
    message("Function doesn't have this parameter")
  }
  return(result)
}

