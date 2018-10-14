#' Download UraLex data
#'
#' This function downloads data from UraLex (https://github.com/lexibank/uralex) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{wals.feature}}
#' @examples
#' # uralex.feature()
#' @export
#'
#' @importFrom utils read.csv
#'

uralex.feature <-
  function(na.rm = TRUE) {
    message("Don't forget to cite a source:

Kaj Syrj\u00E4nen, Jyri Lehtinen, Outi Vesakoski, Mervi de Heer, Toni Suutari, Michael Dunn, Urho M\u00E4\u00E4tt\u00E4 & Unni-P\u00E4iv\u00E4 Leino (2018). UraLex basic vocabulary dataset.")
    final_df <-
      utils::read.csv(
        "https://github.com/lexibank/uralex/raw/master/raw/Data.tsv",
        sep = "\t",
        stringsAsFactors = FALSE
      )
    final_df <- merge(final_df, lingtypology::uralex)
    if(isTRUE(na.rm)){
      final_df <- final_df[!is.na(final_df$language2),]}
    return(final_df)
}
