#' Download AUTOTYP data
#'
#' This function downloads data from AUTOTYP. You need the internet connection.
#'
#' @param features A character vector that define with a feature names from AUTOTYP.
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology. By default is TRUE.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' autotyp.feature(c('Gender', 'Numeral classifiers'))
#' @export
#'
#' @importFrom utils read.csv
#'

autotyp.feature <- function(features, na.rm = TRUE, glottolog.source = "modified"){
  features <- gsub(" ", "_", features)
  links <- paste0("https://raw.githubusercontent.com/autotyp/autotyp-data/master/data/", features, ".csv")
  datalist  <-  lapply(links, function(x){utils::read.csv(x)})
  final_df <- Reduce(function(x,y){merge(x,y, all = TRUE)}, datalist)
  final_df <- merge(final_df, lingtypology::autotyp)

  final_df$language <- lingtypology::lang.gltc(final_df$Glottocode,
                                 glottolog.source = glottolog.source)

  ifelse(na.rm == TRUE,
         final_df <- final_df[!is.na(final_df$language),],
         final_df <- final_df)
  return(final_df)
}
