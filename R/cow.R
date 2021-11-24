#' Sounds of a cow

#' This function produces a specified number of Sounds mu

#' @param feature times of repetitions
#' @author suppukerr
#' @examples
#' # cow()
#' @export

cow <- function(num){
  zvuk = 'mu'
  for (i in 2:num) {
    zvuk = paste(zvuk, 'mu', sep='-', collapse=NULL)
  }
  print(zvuk)
}
cow(2)
