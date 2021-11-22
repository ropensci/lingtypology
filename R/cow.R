#' Функция звукоподражаний корове

#' При вызове функции выведет n-ое количество звуков му

#' @param
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
