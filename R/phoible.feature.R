#' Download PHOIBLE data
#'
#' This function downloads data from PHOIBLE (\url{https://phoible.org/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param source A character vector that define with a source names from PHOIBLE (possible values: "all", "aa", "gm", "ph", "ra", "saphon", "spa", "upsid").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # phoible.feature()
#' # phoible.feature(c('consonants', 'vowels'), source = "UPSID")
#' @export
#'
#' @importFrom utils read.csv
#'

phoible.feature <-
  function(source = "all",
           na.rm = TRUE) {
    message("Don't forget to cite a source:

Moran, Steven & McCloy, Daniel & Wright, Richard (eds.) 2014. PHOIBLE Online. Leipzig: Max Planck Institute for Evolutionary Anthropology. (Available online at https://phoible.org/, Accessed on ...)

A BibTeX entry for LaTeX users is
@book{phoible,
  address   = {Leipzig},
  editor    = {Steven Moran and Daniel McCloy and Richard Wright},
 publisher = {Max Planck Institute for Evolutionary Anthropology},
 title     = {PHOIBLE Online},
 url       = {https://phoible.org/},
 year      = {2014}
}")
    source <- match.arg(tolower(source),
                        c("all", "aa", "gm", "ph", "ra", "saphon", "spa", "upsid"),
                        several.ok = TRUE)
    final_df <-
      utils::read.csv(
        "https://raw.githubusercontent.com/phoible/dev/master/data/phoible.csv",
        stringsAsFactors = FALSE)
    ifelse(source == "all",
           final_df <- final_df,
           final_df <- final_df[final_df$Source %in% source, ])

    final_df <- merge(final_df, lingtypology::phoible, by = "Glottocode")
    na_rm <- is.na(final_df$language)
    ifelse(na.rm == TRUE,
           final_df <- final_df[!na_rm, ],
           final_df[is.na(final_df$language), "language"] <-
             final_df[is.na(final_df$language), "LanguageName"])
    colnames(final_df) <- tolower(colnames(final_df))
    return(final_df[,-which(colnames(final_df)=="languagename")])
  }
