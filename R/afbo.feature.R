#' Download AfBo data
#'
#' This function downloads data from AfBo (http://afbo.info) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with an affix functions from AfBo (e. g. "all", "adjectivizer", "focus").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{autotyp.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{wals.feature}}
#' @examples
#' # afbo.feature()
#' # afbo.feature(c("adjectivizer", "focus"))
#' @export
#'
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom utils read.csv
#'

afbo.feature <- function(features = "all", na.rm = TRUE, glottolog.source = "modified"){
  features <- gsub(c(" |:|/|\\(|\\)"), ".", tolower(features))
  features_set <- c("all", "comparative", "superlative", "adjectivizer", "adverbializer", "clause.level.TAM", "clause.linking", "case..dative", "case..ergative", "case..non.locative.peripheral.case", "case..locative", "case..comparative","gender..human.", "noun.class..inanimate.","diminutive", "augmentative","definite.indefinite", "topic","focus", "nominalizer..miscellaneous","nominalizer..agent", "nominalizer..abstract","nominalizer..social.group", "nominalizer..place.name","number..plural", "number..dual","number..singular", "nominal.derivation..miscellaneous.","privative", "possessor.indexing","numeral.classifier", "numeral.derivation..ordinals","numeral.and.quantifier.derivation", "valency..passive","valency..causative", "valency..reflexive","valency..applicative", "valency..reciprocal","verbal.TAM", "verbal.derivation..miscellaneous.","subject.object.indexing", "verbalizer","relativizer.subordinator", "verbal.negation")
  if(sum(!features %in% features_set) < 1){
    temp1 <- tempfile()
    temp2 <- tempfile()
    utils::download.file("http://afbo.info/static/download/afbo-pair.csv.zip", destfile = temp1)
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

    ifelse(features == "all",
           final_df <- df,
           final_df <- cbind(df[, c(2:12, 14)], df[, features]))
    } else {
      not_features <- features[which(!features %in% features_set)]
      stop(paste(
        "There is no features",
        paste0("'", not_features, "'", collapse = ", "),
        "in AfBo database."))
      }
  return(final_df)
}
