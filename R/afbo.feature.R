#' Download AfBo data
#'
#' This function downloads data from AfBo (\url{https://afbo.info/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with an affix functions from AfBo (e. g. "all", "adjectivizer", "focus").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @seealso \code{\link{abvd.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @seealso \code{\link{abvd.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # afbo.feature()
#' # afbo.feature(c("adjectivizer", "adverbializer"))
#' @export
#'
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom utils read.csv
#'

afbo.feature <- function(features = "all", na.rm = TRUE){
  message("Don't forget to cite a source:

Seifart, Frank. 2013. AfBo: A world-wide survey of affix borrowing. Leipzig: Max Planck Institute for Evolutionary Anthropology. (Available online at https://afbo.info/, Accessed on ...)

A BibTeX entry for LaTeX users is
@book{afbo,
  address   = {Leipzig},
  editor    = {Frank Seifart},
  publisher = {Max Planck Institute for Evolutionary Anthropology},
  title     = {AfBo: A world-wide survey of affix borrowing},
  url       = {https://afbo.info/},
  year      = {2013}
}")
  features <- gsub(c(" |:|/|\\(|\\)"), ".", tolower(features))
  features_set <- c("all", "comparative", "superlative", "adjectivizer", "adverbializer", "clause.level.TAM", "clause.linking", "case..dative", "case..ergative", "case..non.locative.peripheral.case", "case..locative", "case..comparative","gender..human.", "noun.class..inanimate.","diminutive", "augmentative","definite.indefinite", "topic","focus", "nominalizer..miscellaneous","nominalizer..agent", "nominalizer..abstract","nominalizer..social.group", "nominalizer..place.name","number..plural", "number..dual","number..singular", "nominal.derivation..miscellaneous.","privative", "possessor.indexing","numeral.classifier", "numeral.derivation..ordinals","numeral.and.quantifier.derivation", "valency..passive","valency..causative", "valency..reflexive","valency..applicative", "valency..reciprocal","verbal.TAM", "verbal.derivation..miscellaneous.","subject.object.indexing", "verbalizer","relativizer.subordinator", "verbal.negation")
  if(sum(!features %in% features_set) < 1){
    temp1 <- tempfile()
    temp2 <- tempfile()
    utils::download.file("https://cdstar.shh.mpg.de/bitstreams/EAEA0-59C8-38F2-28DC-0/afbo_pair.csv.zip", destfile = temp1)
    utils::unzip(temp1, exdir = temp2)
    df <- utils::read.csv(paste0(temp2, "/pair.csv"), stringsAsFactors = FALSE)

    vapply(seq_along(df$Recipient.name), function(i){
      ifelse(!is.na(lang.gltc(df$Recipient.glottocode[i])),
             df$Recipient.name[i] <<- lingtypology::lang.gltc(df$Recipient.glottocode[i]),
             df$Recipient.name[i] <<- NA_character_)
    }, character(1))

    vapply(seq_along(df$Donor.name), function(i){
      ifelse(!is.na(lang.gltc(df$Donor.glottocode[i])),
             df$Donor.name[i] <<- lingtypology::lang.gltc(df$Donor.glottocode[i]),
             df$Donor.name[i] <<- NA_character_)
    }, character(1))

    if(na.rm == TRUE){
    df <- df[is.glottolog(df$Donor.name),]
    df <- df[is.glottolog(df$Recipient.name),]}
    indexes <- grep("Recipient.name|Donor.name|reliability", colnames(df))

    ifelse(features == "all",
           final_df <- df[, c(indexes, 15:57)],
           final_df <- df[, c(indexes, which(colnames(df) %in% features))])
    } else {
      not_features <- features[which(!features %in% features_set)]
      stop(paste(
        "There is no features",
        paste0("'", not_features, "'", collapse = ", "),
        "in AfBo database."))
    }
  if("all" %in% features){features <- features_set[-1]}
  final_df <- final_df[rowSums(data.frame(a = !is.na(final_df[,features]))) > 0,]
  return(final_df)
}
