#' Open .csv file of The database of Eurasian phonological inventories (beta version) which was downloaded via eurasianphonology.R script.
#'
#' This function open downloaded data from the database of Eurasian phonological inventories (\url{http://eurasianphonology.info}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @author Kirill Koncha <majortomblog@gmail.com>
#' @seealso \code, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' eurasianphonolgy.feature
#'

eurasianphonolgy.feature <- function(){
  message("Don't forget to cite a source:

Dmitry Nikolaev (ed.), Andrey Nikulin, Anton Kukhto. 2020. The database of Eurasian phonological inventories (beta version) (Available online at http://eurasianphonology.info, Accessed on ...)")
  data <- utils::read.csv("database_creation/eurasianphonology.csv")
  data$latitude <- data$coords1
  data$longitude <- data$coords2
  data$iso <- data$code
  data$type <- gsub("Язык", "language", data$type)
  data$type <- gsub("Диалект", "dialect", data$type)
  data$language <- lingtypology::lang.gltc(data$glottocode)
  data_final <- data[c("id",
                       "name",
                       "language",
                       "iso",
                       "glottocode",
                       "type",
                       "latitude",
                       "longitude",
                       "gen1",
                       "gen2",
                       "tones",
                       "syllab",
                       "cluster",
                       "finals",
                       "segments",
                       "segment_type",
                       "source",
                       "comment",
                       "contr")]
  return(data_final)
}



