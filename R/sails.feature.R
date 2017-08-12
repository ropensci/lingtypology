#' Download SAILS data
#'
#' This function downloads data from SAILS (http://sails.clld.org/) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature ids from SAILS (e. g. "and1", "argex4-1-3").
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{phoible.feature}}, \code{\link{wals.feature}}
#' @examples
#' # sails.feature(c("and1", "and11"))
#' @export
#'
#' @importFrom utils read.csv
#'

sails.feature <- function(features, glottolog.source = "modified"){
  links <- paste0("http://sails.clld.org/parameters/", toupper(features), ".tab")
  datalist  <-  lapply(links, function(x){utils::read.csv(x,
                                                          sep = "\t",
                                                          skip = 1,
                                                          na.strings = "N/A",
                                                          header = FALSE,
                                                          stringsAsFactors = FALSE)})

  vapply(seq_along(datalist), function(i){
    colnames(datalist[[i]]) <<- c("iso-639-3", "name", "value", "description", "latitude", "longitude", "family")
    }, character(7))

  final_df <- Reduce(function(x,y){merge(x,y, all = TRUE,
                                         by = c("iso-639-3",
                                                "name",
                                                "latitude",
                                                "longitude",
                                                "family"))}, datalist)

  colnames(final_df)[grep("description", colnames(final_df))] <- paste(features, "description", sep = "_")
  colnames(final_df)[grep("value", colnames(final_df))] <- paste(features, "value", sep = "_")

  final_df$language <- lingtypology::lang.iso(final_df$`iso-639-3`,
                                               glottolog.source = glottolog.source)
  final_df <- final_df[, -c(1:2, 5)]
  final_df <- final_df[, c(ncol(final_df), 1:(ncol(final_df)-1))]
  return(final_df)
}
