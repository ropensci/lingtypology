#' Sounds of a cow

#' This function produces a specified number of Sounds mu

#' @param feature times of repetitions
#' @author Sasha Shakhnova
#' @examples
#' # cow(3)
#' @export

cow <- function(num){
  print(paste(replicate(num, 'му'), collapse = '-'))
}
cow(5)
