#' Sounds of a cow

#' This function produces a specified number of Sounds mu

#' @param num times of repetitions
#' @author Sasha Shakhnova
#' @examples
cow(3)
#' @export

cow <- function(num){
  paste(replicate(num, 'moo'), collapse = '-')
}
