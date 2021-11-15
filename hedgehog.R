hedgehog <- function(times){
  sound <- "фыр"
  text <- rep(sound, times)
  print(paste(text, collapse="-"))
}
hedgehog(3)
