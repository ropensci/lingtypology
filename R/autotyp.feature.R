#' Download AUTOTYP data
#'
#' This function downloads data from AUTOTYP (https://github.com/autotyp/autotyp-data#the-autotyp-database) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature names from AUTOTYP.
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # autotyp.feature(c('Gender', 'Numeral classifiers'))
#' @export
#'
#' @importFrom utils read.csv
#'

autotyp.feature <-
  function(features,
           na.rm = TRUE) {
    message(paste0("Don't forget to cite a source:

Bickel, Balthasar, Johanna Nichols, Taras Zakharko, Alena Witzlack-Makarevich, Kristine Hildebrandt, Michael Rie\u00DFler, Lennart Bierkandt, Fernando Z\u00FA\u00F1iga & John B. Lowe. 2017. The AUTOTYP typological databases. Version ",
                   readLines("https://raw.githubusercontent.com/autotyp/autotyp-data/master/VERSION")))
    features_set <-
      c(
        "Agreement",
        "Alienability",
        "Alignment_case_splits",
        "Alignment",
        "Alignment_per_language",
        "Clause_linkage",
        "Clause_word_order",
        "Clusivity",
        "Gender",
        "Grammatical_markers",
        "GR_per_language",
        "Locus_per_language",
        "Locus_per_macrorelation",
        "Locus_per_microrelation",
        "Markers_per_language",
        "Morpheme_types",
        "Morphology_per_language",
        "NP_per_language",
        "NP_structure",
        "NP_structure_presence",
        "NP_word_order",
        "Numeral_classifiers",
        "Register",
        "Rhythm_per_language",
        "Synthesis",
        "VAgreement",
        "VAgr_multiexponence",
        "VAgr_position",
        "VAgr_position",
        "VAgr_position",
        "VAgr_postposed",
        "VAgr_preposed",
        "Valence_classes",
        "Valence_classes_per_language",
        "VInfl_categories",
        "VInfl_cat_multiexponence",
        "VInfl_cat_positions",
        "VInfl_cat_positions",
        "VInfl_cat_positions",
        "VInfl_cat_postposed",
        "VInfl_cat_preposed",
        "VInfl_counts_per_position",
        "VInfl_macrocategories",
        "VInfl_macrocat_multiexponence",
        "VInfl_macrocat_position",
        "VInfl_macrocat_position",
        "VInfl_macrocat_position",
        "VInfl_macrocat_postposed",
        "VInfl_macrocat_preposed",
        "Word_domains"
      )
    features <- match.arg(arg = gsub(" ", "_", features),
                          choices =  features_set,
                          several.ok = TRUE)

    if (sum(!features %in% features_set) < 1) {
      links <-
        paste0(
          "https://raw.githubusercontent.com/autotyp/autotyp-data/master/data/",
          features,
          ".csv"
        )
      datalist  <-  lapply(links, function(x) {
        utils::read.csv(x, stringsAsFactors = FALSE)
      })
      final_df <-
        Reduce(function(x, y) {
          merge(x, y, all = TRUE)
        }, datalist)
      final_df <- merge(final_df, lingtypology::autotyp)

      final_df$language <-
        lingtypology::lang.gltc(final_df$Glottocode)

      ifelse(na.rm == TRUE,
             final_df <- final_df[!is.na(final_df$language), ],
             final_df <- final_df)
    } else {
      not_features <- features[which(!features %in% features_set)]
      stop(paste(
        "There is no features",
        paste0("'", not_features, "'", collapse = ", "),
        "in AUTOTYP database."
      ))
    }
    return(final_df)
    }
