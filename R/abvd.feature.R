#' Download ABVD data
#'
#' This function downloads data from ABVD (\url{https://abvd.eva.mpg.de/austronesian/}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param feature A character vector that define a language id from ABVD (e. g. "1", "292").
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{bivaltyp.feature}}, \code{\link{eurasianphonology.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{soundcomparisons.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}, \code{\link{vanuatu.feature}}, \code{\link{wals.feature}}
#' @examples
#' # abvd.feature(c(292, 7))
#' @export
#'
#' @importFrom utils read.csv
#'

abvd.feature <- function(feature) {
  message(
    "Don't forget to cite a source:

Greenhill, S.J., Blust. R, & Gray, R.D. (2008). The Austronesian Basic Vocabulary Database: From Bioinformatics to Lexomics. Evolutionary Bioinformatics, 4:271-283."
  )
  if (is.numeric(feature)) {
    links <-
      paste0(
        "https://abvd.eva.mpg.de/utils/save/?type=tdf&section=austronesian&language=",
        feature
      )
  } else{
    stop("You need to provide a numeric vector with language id from ABVD.")
  }
  datalist  <-  lapply(links, function(x) {
    lines <- readLines(x, n = 26)
    skip <- grep(pattern = "^id", lines)
    skip <- skip[length(skip)]
    utils::read.csv(x,
                    sep = "\t",
                    skip = skip - 1,
                    stringsAsFactors = FALSE)[, c(2:4)]
  })
  langs <-
    lang.gltc(lingtypology::abvd[feature, 2])
  lapply(seq_along(feature), function(i) {
    datalist[[i]]$language <<- langs[i]
  })
  final_df <- Reduce(function(x, y) {
    rbind.data.frame(x, y, stringsAsFactors = FALSE)
  }, datalist)
  return(final_df)
}
