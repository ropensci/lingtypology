#' Download BivalTyp data
#'
#' This function downloads data from BivalTyp (\url{https://www.bivaltyp.info/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' # bivaltyp.feature()
#' @export
#'
#' @importFrom utils read.csv
#'

bivaltyp.feature <- function(){
  message("Don't forget to cite a source:

Say, Sergey (ed.). 2020. BivalTyp: Typological database of bivalent verbs and their encoding frames. St. Petersburg: Institute for Linguistic Studies, RAS. (Available online at https://www.bivaltyp.info, Accessed on ...)")

  la <- utils::read.csv("https://raw.githubusercontent.com/macleginn/bivaltyp/master/data/languages.csv", sep = "\t")
  la$language_source <- la$language
  la$family_WALS <- la$family..WALS.
  la$genus_WALS <- la$genus..WALS.
  la$language <- lingtypology::lang.gltc(la$glottocode)

  la <-
    la[, c(
      "language_no",
      "language_external",
      "expert",
      "family_WALS",
      "genus_WALS",
      "latitude",
      "longitude",
      "number_nominal_cases",
      "glottocode",
      "language_source",
      "language"
    )]

  pr <- utils::read.csv("https://raw.githubusercontent.com/macleginn/bivaltyp/master/data/predicates.csv", sep = "\t")
  pr <-
    pr[, c(
      "predicate_no",
      "predicate_label_en",
      "argument_frame_en",
      "stimulus_sentence_en",
      "present_tense"
    )]

  dfd <- utils::read.csv("https://raw.githubusercontent.com/macleginn/bivaltyp/master/data/data_for_download.csv", sep = "\t")
  dfd <-
    dfd[, c(
      "language_no",
      "predicate_no",
      "verb",
      "X",
      "Y",
      "locus",
      "valency_pattern"
    )]

  result <- merge(merge(la, dfd), pr)
  result <-
    result[, c(
      "family_WALS",
      "genus_WALS",
      "language_source",
      "language_external",
      "language",
      "glottocode",
      "latitude",
      "longitude",
      "expert",
      "number_nominal_cases",
      "verb",
      "X",
      "Y",
      "locus",
      "valency_pattern",
      "predicate_label_en",
      "argument_frame_en",
      "stimulus_sentence_en",
      "present_tense"
    )]

  return(result)
}
