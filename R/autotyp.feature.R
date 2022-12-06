#' Download AUTOTYP data
#'
#' This function downloads data from AUTOTYP (https://github.com/autotyp/autotyp-data#the-autotyp-database) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature names from AUTOTYP.
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # autotyp.feature(c('Has Gender', 'Has Numeral Classifiers'))
#' @export
#'
#' @importFrom utils read.csv
#'

autotyp.feature <-
  function(features,
           na.rm = TRUE) {
    message("Don't forget to cite a source:

Bickel, Balthasar, Nichols, Johanna, Zakharko, Taras, Witzlack-Makarevich, Alena, Hildebrandt, Kristine, Rie\u00DFler, Michael, Bierkandt, Lennart, Z\u00FA\u00F1iga, Fernando & Lowe, John B. 2022. The AUTOTYP database (v1.1.0). https://doi.org/10.5281/zenodo.5931509

@misc{AUTOTYP,
  author = {
    Bickel, Balthasar and
    Nichols, Johanna and
    Zakharko, Taras and
    Witzlack-Makarevich, Alena and
    Hildebrandt, Kristine and
    Rie{\\ss}ler, Michael and
    Bierkandt, Lennart and
    Z{\\'u}{\\~n}iga, Fernando and
    Lowe, John B
  },
  doi = {10.5281/zenodo.6793367},
  title = {The AUTOTYP database (v1.1.0)},
  url = {https://doi.org/10.5281/zenodo.6793367},
  year = {2022}
}")

    features <- match.arg(arg = gsub(" ", "", features),
                          choices =  unique(c(lingtypology::autotyp$variable,
                                              lingtypology::autotyp$file)),
                          several.ok = TRUE)

    if (sum(features %in% lingtypology::autotyp$variable) > 0) {
      paths <- c(lingtypology::autotyp[lingtypology::autotyp$variable %in% features,]$path,
                 lingtypology::autotyp[lingtypology::autotyp$file %in% features,]$path)

      links <- paste0(
          "https://raw.githubusercontent.com/autotyp/autotyp-data/master/data/csv/",
          unique(paths))
      datalist  <-  lapply(links, function(x) {
        utils::read.csv(x, stringsAsFactors = FALSE)
      })

      final_df <- Reduce(function(x, y) {merge(x, y, all = TRUE)}, datalist)

      final_df$language_for_lingtypology <-
        lingtypology::lang.gltc(final_df$Glottocode)

      if(na.rm == TRUE){
        final_df <- final_df[!is.na(final_df$language_for_lingtypology), ]
      }

      columns_to_select <- c("LID", "Glottocode", "Language",
                             lingtypology::autotyp[lingtypology::autotyp$file %in% features, ]$variable,
                             features[!(features %in% lingtypology::autotyp$file)],
                             "MarkerID", "MarkerID", "MarkerLabel",
                             "MarkerExemplar", "ConstructionLabel",
                             "IntuitiveClassification", "OriginalName",
                             "NPStructureID", "NPStructureMarkerID",
                             "SelectorID", "MarkerID", "SelectorLabel",
                             "PredicateClassID", "PredicateClassLabel",
                             "PredicateClassDescription", "Examples",
                             "language_for_lingtypology")

      final_df <- final_df[colnames(final_df) %in% unique(columns_to_select)]

    } else {
      not_features <- features[which(!features %in%
                                       unique(c(lingtypology::autotyp$variable,
                                                lingtypology::autotyp$file)))]
      stop(paste(
        "There is no features",
        paste0("'", not_features, "'", collapse = ", "),
        "in AUTOTYP database."
      ))
    }
    return(final_df)
    }
