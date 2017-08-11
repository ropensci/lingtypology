#' Download AfBo data
#'
#' This function downloads data from AfBo (http://afbo.info) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with an affix functions from AfBo (e. g. "all", "adjectivizer", "focus").
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' # afbo.feature()
#' # afbo.feature(c("adjectivizer", "focus"))
#' @export
#'
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @importFrom utils read.csv
#'

afbo.feature <- function(features = "all", glottolog.source = "modified"){
  temp1 <- tempfile()
  temp2 <- tempfile()
  utils::download.file("http://afbo.info/static/download/afbo-pair.csv.zip", destfile = temp1)
  utils::unzip(temp1, exdir = temp2)
  df <- utils::read.csv(paste0(temp2, "/pair.csv"), stringsAsFactors = FALSE)

  vapply(seq_along(df$Recipient.name), function(i){
    ifelse(!is.na(lang.gltc(df$Recipient.glottocode[i])),
           df$Recipient.name[i] <<- lingtypology::lang.gltc(df$Recipient.glottocode[i]),
           df$Recipient.name[i] <<- df$Recipient.name[i])
  }, character(1))

  vapply(seq_along(df$Donor.name), function(i){
    ifelse(!is.na(lang.gltc(df$Donor.glottocode[i])),
           df$Donor.name[i] <<- lingtypology::lang.gltc(df$Donor.glottocode[i]),
           df$Donor.name[i] <<- df$Donor.name[i])
  }, character(1))

  features <- gsub(c(" |:|/|\\(|\\)"), ".", features)

  ifelse(features == "all",
         final_df <- df,
         final_df <- cbind(df[, c(2:12, 14)], df[, features]))

  return(final_df)
}
