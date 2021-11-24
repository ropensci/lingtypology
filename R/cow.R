#' Sounds of a cow

#' This function produces a specified number of Sounds mu

#' @param feature times of repetitions
#' @author suppukerr
#' @examples
#' cow(3)

cow <- function(num){
  zvuk = 'му'
  for (i in 2:num) {
    zvuk = paste(zvuk, 'му', sep='-', collapse=NULL)
  }
  print(zvuk)
}
