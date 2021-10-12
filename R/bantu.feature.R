#' Download BANTU data
#'
#' This function downloads data from Bantu Basic Vocabulary Database (\url{https://abvd.shh.mpg.de/bantu/index.php}) and changes language names to the names from lingtypology database. You need the internet connection.
#'
#' @param features A character vector that define with a feature ids from BANTU ('house', 'cat').
#' @seealso \code{\link{abvd.feature}}, \code{\link{afbo.feature}}, \code{\link{autotyp.feature}}, \code{\link{oto_mangueanIC.feature}}, \code{\link{phoible.feature}}, \code{\link{sails.feature}}, \code{\link{uralex.feature}}, \code{\link{valpal.feature}}
#' @author Anna Smirnova <annedadaa@gmail.com>
#' @examples
#' # bantu.feature(c('house', 'cat'))
#' @export
#'
#' @importFrom utils read.csv
#'

bantu.feature <- function(features){
  message(paste0("Don't forget to cite a source (modify in case of using individual chapters):
Greenhill, S.J., Blust. R, & Gray, R.D. (2008). The Austronesian Basic Vocabulary Database: From Bioinformatics to Lexomics.
Evolutionary Bioinformatics, 4:271-283.
(Available online at https://abvd.shh.mpg.de/bantu/index.php, Accessed on ",
                 Sys.Date(),
                 ".)

@book{The Austronesian Basic Vocabulary Database,
  editor    = {Simon J. Greenhill , Robert Blust and Russell D. Gray},
  publisher = {1Department of Psychology, The University of Auckland, Private Bag 92019,
  Auckland 1142, New Zealand. 2Department of Linguistics, University of Hawaii at Manoa,
  1890 East-West Road, Moore Hall 569, Honolulu, HI 96822.},
  title     = {Bantu Basic Vocabulary Database},
  url       = {https://abvd.shh.mpg.de/bantu/index.php},
  year      = {2008}
}"))
  my_data <- lapply(features, function(x) {
    if (x %in% lingtypology::bantu$word){
      link <- paste0("https://abvd.shh.mpg.de/utils/save/?type=csv&section=bantu&word=",
                 lingtypology::bantu[lingtypology::bantu$word==x,]['id'])
      datalist <- lapply(link, function(l) {
        bantu_df <- utils::read.csv(l, header = FALSE ,encoding = "UTF-8")
        bantu_df <- bantu_df[-c(1, 2, 3), ]})
      datalist <- datalist[[1]]
      }else{
        stop(paste(
          "There is no features",
          paste0("'", x, "'", collapse = ", "),
          "in bantu database."))}
    })
  my_df <- do.call("rbind", my_data)
  colnames(my_df) <- c("id",
                       "nominal_prefix",
                       "item",
                       "gram",
                       "genre",
                       "annotation",
                       "cognacy",
                       "language_id",
                       "language")
  language <- c("Asu G.22",
                "Basaa A.43a",
                "Bemba M.42",
                "Bukusu E.31c",
                "Kinyamwezi F22",
                "Koyo C.24",
                "Lega D.25",
                "Rumanyo (Gciriku) K.38",
                "Tswana S.30",
                "Yao P.21")
  glottocode <- c("asut1235",
           "basa1284",
           "bemb1257",
           "buku1249",
           "nyam1276",
           "koyo1242",
           "lega1249",
           "diri1252",
           "tswa1253",
           "yaoo1241")
  df_glots <- data.frame(language, glottocode)
  my_df <-  merge(my_df, df_glots, by = "language")
  return(my_df)}
