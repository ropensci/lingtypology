#' Download WALS data
#'
#' This function downloads data from WALS (http://wals.info) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature ids from WALS (e. g. "1a", "21b").
#' @param na.rm Logical. If TRUE function removes all languages not available in lingtypology database. By default is TRUE.
#' @param glottolog.source A character vector that define which glottolog database is used: 'original' or 'modified' (by default)
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' # wals.feature(c("1a", "20a"))
#' @export
#'
#' @importFrom utils read.csv
#'

wals.feature <-
  function(features,
           na.rm = TRUE,
           glottolog.source = "modified") {
    features_set <-
      c(
        "1A",
        "2A",
        "3A",
        "4A",
        "5A",
        "6A",
        "7A",
        "8A",
        "9A",
        "10A",
        "10B",
        "11A",
        "12A",
        "13A",
        "14A",
        "15A",
        "16A",
        "17A",
        "18A",
        "19A",
        "20A",
        "21A",
        "21B",
        "22A",
        "23A",
        "24A",
        "25A",
        "25B",
        "26A",
        "27A",
        "28A",
        "29A",
        "30A",
        "31A",
        "32A",
        "33A",
        "34A",
        "35A",
        "36A",
        "37A",
        "38A",
        "39A",
        "39B",
        "40A",
        "41A",
        "42A",
        "43A",
        "44A",
        "45A",
        "46A",
        "47A",
        "48A",
        "49A",
        "50A",
        "51A",
        "52A",
        "53A",
        "54A",
        "55A",
        "56A",
        "57A",
        "58A",
        "58B",
        "59A",
        "60A",
        "61A",
        "62A",
        "63A",
        "64A",
        "65A",
        "66A",
        "67A",
        "68A",
        "69A",
        "70A",
        "71A",
        "72A",
        "73A",
        "74A",
        "75A",
        "76A",
        "77A",
        "78A",
        "79A",
        "79B",
        "80A",
        "81A",
        "81B",
        "82A",
        "83A",
        "84A",
        "85A",
        "86A",
        "87A",
        "88A",
        "89A",
        "90A",
        "90B",
        "90C",
        "90D",
        "90E",
        "90F",
        "90G",
        "91A",
        "92A",
        "93A",
        "94A",
        "95A",
        "96A",
        "97A",
        "98A",
        "99A",
        "100A",
        "101A",
        "102A",
        "103A",
        "104A",
        "105A",
        "106A",
        "107A",
        "108A",
        "108B",
        "109A",
        "109B",
        "110A",
        "111A",
        "112A",
        "113A",
        "114A",
        "115A",
        "116A",
        "117A",
        "118A",
        "119A",
        "120A",
        "121A",
        "122A",
        "123A",
        "124A",
        "125A",
        "126A",
        "127A",
        "128A",
        "129A",
        "130A",
        "130B",
        "131A",
        "132A",
        "133A",
        "134A",
        "135A",
        "136A",
        "136B",
        "137A",
        "137B",
        "138A",
        "139A",
        "140A",
        "141A",
        "142A",
        "143A",
        "143B",
        "143C",
        "143D",
        "143E",
        "143F",
        "143G",
        "144A",
        "144B",
        "144C",
        "144D",
        "144E",
        "144F",
        "144G",
        "144H",
        "144I",
        "144J",
        "144K",
        "144L",
        "144M",
        "144N",
        "144O",
        "144P",
        "144Q",
        "144R",
        "144S",
        "144T",
        "144U",
        "144V",
        "144W",
        "144X",
        "144Y"
      )
    message(paste0("Don't forget to cite a source (modify in case of using individual chapters):

Dryer, Matthew S. & Haspelmath, Martin (eds.) 2013. The World Atlas of Language Structures Online. Leipzig: Max Planck Institute for Evolutionary Anthropology.
(Available online at http://wals.info, Accessed on ",
            Sys.Date(),
            ".)

@book{wals,
  address   = {Leipzig},
  editor    = {Matthew S. Dryer and Martin Haspelmath},
  publisher = {Max Planck Institute for Evolutionary Anthropology},
  title     = {WALS Online},
  url       = {http://wals.info/},
  year      = {2013}
}"))
    if (sum(!toupper(features) %in% features_set) < 1){
      links <-
        paste0("http://wals.info/feature/", toupper(features), ".tab")
      datalist  <-  lapply(links, function(x) {
        utils::read.csv(x,
                        sep = "\t",
                        skip = 7,
                        stringsAsFactors = FALSE)
      })
      final_df <- Reduce(function(x, y) {
        merge(
          x,
          y,
          all = TRUE,
          by = c(
            "wals.code",
            "name",
            "latitude",
            "longitude",
            "genus",
            "family"
          )
        )
      }, datalist)

      final_df <-
        final_df[, grep("description|wals.code|name|latitude|longitude", colnames(final_df))]
      colnames(final_df)[grep("description", colnames(final_df))] <-
        features

      final_df <-
        merge(final_df, lingtypology::wals, by = "wals.code")

      final_df$language <-
        lingtypology::lang.gltc(final_df$glottocode,
                                glottolog.source = glottolog.source)
      na_rm <- is.na(final_df$language)
      ifelse(na.rm == TRUE,
             final_df <- final_df[!na_rm, ],
             final_df[is.na(final_df$language), "language"] <-
               final_df[is.na(final_df$language), "name"])
      final_df <- final_df[,-2]
    } else {
      not_features <- features[which(!features %in% features_set)]
      stop(paste(
        "There is no features",
        paste0("'", not_features, "'", collapse = ", "),
        "in WALS database."
      ))
    }
    return(final_df)
  }
