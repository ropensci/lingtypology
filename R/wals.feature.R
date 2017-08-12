#' Download WALS data
#'
#' This function downloads data from WALS (http://wals.info) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature ids from WALS (e. g. "1a", "21b").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' # wals.feature(c("1a", "20a"))
#' @export
#'
#' @importFrom utils read.csv
#'

wals.feature <- function(features, na.rm = TRUE, glottolog.source = "modified"){
  links <- paste0("http://wals.info/feature/", toupper(features), ".tab")
  datalist  <-  lapply(links, function(x){utils::read.csv(x,
                                                          sep = "\t",
                                                          skip = 7,
                                                          stringsAsFactors = FALSE)})
  final_df <- Reduce(function(x,y){merge(x,y, all = TRUE,
                                         by = c("wals.code",
                                                "name",
                                                "latitude",
                                                "longitude",
                                                "genus",
                                                "family"))}, datalist)

  final_df <- final_df[, c(1:4, grep("description", colnames(final_df)))]
  colnames(final_df)[grep("description", colnames(final_df))] <- features

  final_df <- merge(final_df, lingtypology::wals, by = "wals.code")

  final_df$language <- lingtypology::lang.gltc(final_df$glottocode,
                                              glottolog.source = glottolog.source)
  na_rm <- is.na(final_df$language)
  ifelse(na.rm == TRUE,
         final_df <- final_df[!na_rm,],
         final_df[is.na(final_df$language), "language"] <- final_df[is.na(final_df$language), "name"])
  final_df <- final_df[, -2]
  return(final_df)
}
