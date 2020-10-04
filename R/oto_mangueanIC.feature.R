#' Download Oto-Manguean Inflectional Class Database data
#'
#' This function downloads data from Oto-Manguean Inflectional Class Database (\url{https://oto-manguean.surrey.ac.uk/}) and creates a language column with the names from lingtypology database. You need the internet connection.
#'
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # oto_mangueanIC.feature()
#' @export
#'
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom utils read.csv
#'

oto_mangueanIC.feature <- function(){
  message("Don't forget to cite a source:

Feist, Timothy & Enrique L. Palancar. 2015. Oto-Manguean Inflectional Class Database. University of Surrey. https://dx.doi.org/10.15126/SMG.28/1/")
  temp1 <- tempfile()
  utils::download.file("https://oto-manguean.surrey.ac.uk/Database/Export/", destfile = temp1)
  final_df <- utils::read.csv(temp1, stringsAsFactors = FALSE)
  final_df <- merge(final_df, lingtypology::oto_mangueanIC)
  return(final_df)
}
