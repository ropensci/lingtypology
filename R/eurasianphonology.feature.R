#' Open .csv file of The database of Eurasian phonological inventories (beta version) which was downloaded via eurasianphonology.R script.
#'
#' This function open downloaded data from the database of Eurasian phonological inventories (\url{http://eurasianphonology.info}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @author Kirill Koncha <majortomblog@gmail.com>
#' @seealso \code, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' eurasianphonolgy.feature
#'
#' @export
#'
eurasianphonolgy.feature <- function(){
  message("Don't forget to cite a source:

Dmitry Nikolaev (ed.), Andrey Nikulin, Anton Kukhto. 2020. The database of Eurasian phonological inventories (beta version) (Available online at http://eurasianphonology.info, Accessed on ...)")
  data <- lingtypology::eurasianphonology
  return(data)
}


