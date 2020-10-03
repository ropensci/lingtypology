#' Download ValPaL data
#'
#' This function downloads data from ValPal (\url{https://www.valpal.info/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is FALSE.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{wals.feature}}
#' @examples
#' # valpal.feature()
#' @export
#'
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom utils read.csv
#'

valpal.feature <- function(na.rm = FALSE){
  message("Don't forget to cite a source:

Hartmann, Iren & Haspelmath, Martin & Taylor, Bradley (eds.) 2013.
Valency Patterns Leipzig. Leipzig: Max Planck Institute for Evolutionary Anthropology.(Available online at https://valpal.info/, Accessed on ...)

A BibTeX entry for LaTeX users is
@book{valpal,
  publisher = {Max Planck Institute for Evolutionary Anthropology},
  title = {Valency Patterns Leipzig},
  url = {https://valpal.info/},
  address = {Leipzig},
  editor = {Hartmann, Iren & Haspelmath, Martin & Taylor, Bradley (eds.)},
  year = {2013}
}")
  temp1 <- tempfile()
  temp2 <- tempfile()
  utils::download.file("https://www.valpal.info/public/all_lgs_valency_data.zip", destfile = temp1)
  utils::unzip(temp1, exdir = temp2)
  files <- paste0(temp2, "/",
                  grep("verb-coding_frame-microroles.txt", list.files(path = temp2), value = TRUE))
  datalist  <-  lapply(files, function(x) {
    utils::read.csv(x,
                    sep = "\t",
                    fileEncoding="UTF-16LE",
                    stringsAsFactors = FALSE)
  })
  final_df <- Reduce(function(x, y) merge(x, y, all = TRUE), datalist)
  final_df$language <- final_df$Language_name
  final_df[final_df$language == "Ainu", 11] <- "Hokkaido Ainu"
  final_df[final_df$language == "Central Alaskan Yupik", 11] <- "Central Yupik"
  final_df[final_df$language == "Eastern Armenian", 11] <- "Armenian"
  final_df[final_df$language == "Emai", 11] <- "Emai-Iuleha-Ora"
  final_df[final_df$language == "Hooc\u0105k", 11] <- "Ho-Chunk"
  final_df[final_df$language == "Jakarta Indonesian", 11] <- "Indonesian"
  final_df[final_df$language == "Japanese (standard)", 11] <- "Japanese"
  final_df[final_df$language == "Modern Standard Arabic", 11] <- "Standard Arabic"
  final_df[final_df$language == "N\u01C0\u01C0ng", 11] <- "N/u"
  final_df[final_df$language == "Ojibwe", 11] <- "Ottawa"
  final_df[final_df$language == "Sliammon", 11] <- "Comox"
  final_df[final_df$language == "X\u00E2r\u00E2c\u00F9\u00F9", 11] <- "Xaracuu"
  final_df[final_df$language == "Yor\u00F9b\u00E1", 11] <- "Yoruba"
  if(na.rm == TRUE){
    return(final_df[is.glottolog(final_df$language),])
  } else{
    return(final_df)
  }
}
