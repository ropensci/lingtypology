#' Download PHOIBLE data
#'
#' This function downloads data from PHOIBLE (http://phoible.org/) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature names from PHOIBLE (possible values: "all", "Phonemes", "Consonants", "Tones", "Vowels").
#' @param source A character vector that define with a source names from PHOIBLE (possible values: "all", "AA", "GM", "PH", "RA", "SAPHON", "SPA", "UPSID").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{sails.feature}}, \code{\link{wals.feature}}
#' @examples
#' # phoible.feature()
#' # phoible.feature(c('consonants', 'vowels'), source = "UPSID")
#' @export
#'
#' @importFrom utils read.csv
#'

phoible.feature <- function(features = "all", source = "all", na.rm = TRUE, glottolog.source = "modified"){
  features <- tolower(features)
  features_set <- c("all", "phonemes", "consonants", "tones", "vowels")
  if(sum(!features %in% features_set) < 1){
    final_df <- utils::read.csv("https://raw.githubusercontent.com/clld/phoible/master/data/phoible-aggregated.tsv",
                                sep = "\t", stringsAsFactors = FALSE)
    ifelse(source == "all",
           final_df <- final_df,
           final_df <- final_df[final_df$Source %in% source,])

    final_df$language <- lingtypology::lang.iso(final_df$LanguageCode,
                                                glottolog.source = glottolog.source)
    na_rm <- is.na(final_df$language)
    ifelse(na.rm == TRUE,
           final_df <- final_df[!na_rm,],
           final_df[is.na(final_df$language), "language"] <- final_df[is.na(final_df$language), "LanguageName"])

    colnames(final_df) <- tolower(colnames(final_df))
    ifelse(features == "all",
           final_df <- final_df[, 13:17],
           final_df <- final_df[, c(features, "language")])
  } else {
    not_features <- features[which(!features %in% features_set)]
    stop(paste(
      "There is no features",
      paste0("'", not_features, "'", collapse = ", "),
      "in PHOIBLE database."))
    }
  return(final_df)
}
