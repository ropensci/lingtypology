#' Sounds of a hedgehog
#'
#' This function reproduces the sounds of a hedgehog. You don't need the internet connection.
#'
#' @param feature times number of repetitions.
#' @author Ekaterina Zalivina <zalivina01@mail.ru>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @examples
#' # hedgehog()
#' @export

hedgehog <- function(times){
  sound <- "фыр"
  text <- rep(sound, times)
  print(paste(text, collapse="-"))
}
hedgehog(3)
